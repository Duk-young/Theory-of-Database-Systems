import sys
import pyspark as spark
from pyspark import SparkConf
from pyspark import SparkContext

conf = SparkConf()
sc = SparkContext.getOrCreate(conf=conf)

def delete_directory(sc, path):
    try:
        conf = sc._jsc.hadoopConfiguration()
        conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem")
        fs = sc._jvm.org.apache.hadoop.fs.FileSystem.get(sc._jvm.java.net.URI.create(path), conf)
        if fs.exists(sc._jvm.org.apache.hadoop.fs.Path(path)):
            fs.delete(sc._jvm.org.apache.hadoop.fs.Path(path), True)
    except Exception as e:
        print(f"Failed to delete directory {path}: {e}")

output_dir = None
if len(sys.argv) > 2:
    output_dir = sys.argv[2]
if output_dir != None:
    delete_directory(sc, output_dir)
# rec[0] = year, rec[3] = CBSA

readCSV = sc.textFile(sys.argv[1])
readCSV.count() # Force RDD initialization for readCSV. first() crashes without this line.
header = readCSV.first()
readCSV = readCSV.filter(lambda rec: rec != header).map(lambda rec: rec.split(','))
mapReduce = (readCSV.map(lambda rec: ((int(rec[20]), int(rec[0])), 1))
            .reduceByKey(lambda v1, v2: v1+v2)
            .sortByKey())
output = mapReduce.collect()
print("Total Admissions ((Age Group, Year), Admissions):\n", output)
output_format = mapReduce.map(lambda rec: f"{rec[0][0]}, {rec[0][1]}, {rec[1]}")
header = sc.parallelize(["Age Group, Year, Admissions"])
output_with_header = header.union(output_format)
if output_dir != None:
    output_with_header.saveAsTextFile(output_dir)