import sys
import pyspark as spark
from pyspark import SparkConf
from pyspark import SparkContext

conf = SparkConf()
sc = SparkContext.getOrCreate(conf=conf)

def delete_directory(sc, path):
    try:
        conf = sc._jsc.hadoopConfiguration()
        conf.set("fs.gs.impl", "com.google.cloud.hadoop.fs.gcs.GoogleHadoopFileSystem")
        fs = sc._jvm.org.apache.hadoop.fs.FileSystem.get(sc._jvm.java.net.URI.create(path), conf)
        if fs.exists(sc._jvm.org.apache.hadoop.fs.Path(path)):
            fs.delete(sc._jvm.org.apache.hadoop.fs.Path(path), True)
    except Exception as e:
        print(f"Failed to delete GCS directory {path}: {e}")

output_dir = None
if len(sys.argv) > 2:
    output_dir = sys.argv[2]
if output_dir != None:
    delete_directory(sc, output_dir)


# rec[0] = year, rec[3] = CBSA
    
readCSV = sc.textFile(sys.argv[1]).map(lambda rec: rec.split(','))
countAdmissions = (
    readCSV.filter(lambda rec: rec[3] != '-9') # exclude missing values
    .map(lambda rec: (rec[3], 1))
    .reduceByKey(lambda v1, v2: v1+v2)
    )

top5CBSA = countAdmissions.sortBy(lambda rec: rec[1], ascending=False).take(5)
print("Top 5 CBSA (CBSA, Admissions):\n", top5CBSA)
top5CBSA = [CBSA[0] for CBSA in top5CBSA]


top5CBSARDD = readCSV.filter(lambda rec:rec[3] in top5CBSA)
top5CBSAPerYear = (
    top5CBSARDD.map(lambda rec:((int(rec[0]), int(rec[3])),1))
    .reduceByKey(lambda v1, v2: v1+v2) # Total admission per year
    )
lowestYearPerCBSA = (
    top5CBSAPerYear.map(lambda rec:(rec[0][1],(rec[0][0], rec[1]))) # map to (CBSA, (year, count)) format
    .reduceByKey(lambda v1, v2: v1 if v1[1] < v2[1] else v2) # Compute lowest year for each CBSA
    .map(lambda rec:((rec[0], rec[1][0]), rec[1][1])) # Conver it back to ((year, CBSA), count) form
    )

output = lowestYearPerCBSA.collect()
print("Lowest admission year for top 5 CBSA ((CBSA, Year), Admissions):\n", output)

output_format = lowestYearPerCBSA.map(lambda rec: f"{rec[0][0]}, {rec[0][1]}, {rec[1]}")
header = sc.parallelize(["CBSA, Year, Admissions"])
output_with_header = header.union(output_format)
if output_dir != None:
    output_with_header.saveAsTextFile(output_dir)


