# Generate 6 files
# Every file has cardinality of 57870 which will give us total cardinality of 347220.
# The time range is 10-day with 5-second step. This gives us 17280 datapoints per series per day and
# 59999616000 datapoints total which is close to 60-billion datapoints total.
# The required storage is approximately 223GB.


python2.7 gen.py --format=RESP2 --rbegin=0      --rend=1000  --tbegin=20170101T000000 --tend=20170104T235959 --tdelta=00:00:30 | gzip > 1day_1Mrows_30sec_step_0.gz &
python2.7 gen.py --format=RESP2 --rbegin=1000      --rend=2000  --tbegin=20170101T000000 --tend=20170104T235959 --tdelta=00:00:30 | gzip > 1day_1Mrows_30sec_step_1.gz &
#python2.7 gen.py --format=RESP2 --rbegin=5787   --rend=11574 --tbegin=20170101T000000 --tend=20170104T235959 --tdelta=00:01:00 | gzip > 1day_5787rows_5sec_step_1.gz &
#python2.7 gen.py --format=RESP2 --rbegin=11574  --rend=17361 --tbegin=20170101T000000 --tend=20170104T235959 --tdelta=00:01:00 | gzip > 1day_5787rows_5sec_step_2.gz &
#python2.7 gen.py --format=RESP2 --rbegin=17361  --rend=23148 --tbegin=20170101T000000 --tend=20170104T235959 --tdelta=00:01:00 | gzip > 1day_5787rows_5sec_step_3.gz &
wait
#python2.7 gen.py --format=RESP2 --rbegin=23148  --rend=28935 --tbegin=20170101T000000 --tend=20170104T235959 --tdelta=00:01:00 | gzip > 1day_5787rows_5sec_step_4.gz &
#python2.7 gen.py --format=RESP2 --rbegin=28935  --rend=34722 --tbegin=20170101T000000 --tend=20170104T235959 --tdelta=00:01:00 | gzip > 1day_5787rows_5sec_step_5.gz &
#wait

