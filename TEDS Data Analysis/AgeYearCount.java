import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class AgeYearCount {

  public static class AYCMapper
       extends Mapper<Object, Text, Text, IntWritable>{

    private final static IntWritable one = new IntWritable(1);

    public void map(Object key, Text value, Context context
                    ) throws IOException, InterruptedException {
        String line = value.toString();
        if (line.contains("ADMYR")) {
          return; // Skip the header line
        }
        String[] line_split = line.split(",");
        String age = line_split[20];
        String year = line_split[0];
        context.write(new Text(age+"\t"+year+"\t"), one);
      
    }
  }

  public static class AYCReducer
       extends Reducer<Text,IntWritable,Text,IntWritable> {
    private IntWritable result = new IntWritable();

    public void reduce(Text key, Iterable<IntWritable> values,
                       Context context
                       ) throws IOException, InterruptedException {
        int sum = 0;
        for (IntWritable val : values) {
            sum += val.get();
        }
        result.set(sum);
        context.write(key, result);
    }
  }

  public static void main(String[] args) throws Exception {
    if(args.length != 2){
        throw new Exception(
            "\n (1) HDFS Path to input dataset and (2) HDFS Path to oupt for your program is required. \n"
        );
    }
    Configuration conf = new Configuration();
    FileSystem fs = FileSystem.get(conf);
    Path outputPath = new Path(args[1]);
    if (fs.exists(outputPath)) {
        fs.delete(outputPath, true); // delete output directory.
    }
    Job job = Job.getInstance(conf, "AgeYearCount");
    job.setJarByClass(AgeYearCount.class);
    job.setJar("ayc.jar"); 
    job.setMapperClass(AYCMapper.class);
    job.setCombinerClass(AYCReducer.class);
    job.setReducerClass(AYCReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}