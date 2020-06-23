import pandas
import sys
df = pandas.read_csv(sys.argv[1])
result = pandas.io.sql.get_schema(df, sys.argv[2])
name = '2' + sys.argv[2] + '.sql'
print(result, file=open(name,"w"))