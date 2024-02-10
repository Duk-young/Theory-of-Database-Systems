import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class UniqueCBSA {

  public static class UCBSAMapper
       extends Mapper<Object, Text, Text, NullWritable>{

    // private boolean header = false;
    // private int yearIdx = -1;
    // private int ageIdx = -1;
    public void map(Object key, Text value, Context context
                    ) throws IOException, InterruptedException {
        String line = value.toString();
        if (line.contains("ADMYR")) {
            return; // Skip the header line
        }
        String[] line_split = line.split(",");
        String CBSA2010 = line_split[3];
        context.write(new Text(CBSA2010), NullWritable.get());
      
    }
  }

  public static class UCBSAReducer
       extends Reducer<Text,IntWritable,Text, NullWritable> {
    private IntWritable result = new IntWritable();

    public void reduce(Text key, Iterable<IntWritable> values,
                       Context context
                       ) throws IOException, InterruptedException {
        context.write(key, NullWritable.get());
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
    Job job = Job.getInstance(conf, "UniqueCBSA");
    job.setJar("ucbsa.jar");
    job.setJarByClass(UniqueCBSA.class);
    job.setMapperClass(UCBSAMapper.class);
    job.setCombinerClass(UCBSAReducer.class);
    job.setReducerClass(UCBSAReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(NullWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}