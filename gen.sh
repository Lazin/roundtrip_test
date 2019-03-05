# Generate 8 files
# Every file has cardinality of 57870 which will give us total cardinality of 462960.
# The time range is 10-day with 5-second step. This gives us 7200 datapoints per series per day and
# 79999488000 datapoints total which is close to 10-billion datapoints per file.
# The required storage is approximately 300GB.

# python2.7 gen.py --format=RESP2 --rbegin=0      --rend=5787  --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_0.gz &
# python2.7 gen.py --format=RESP2 --rbegin=5787   --rend=11574 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_1.gz &
# python2.7 gen.py --format=RESP2 --rbegin=11574  --rend=17361 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_2.gz &
# python2.7 gen.py --format=RESP2 --rbegin=17361  --rend=23148 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_3.gz &
# wait
# python2.7 gen.py --format=RESP2 --rbegin=23148  --rend=28935 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_4.gz &
# python2.7 gen.py --format=RESP2 --rbegin=28935  --rend=34722 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_5.gz &
# python2.7 gen.py --format=RESP2 --rbegin=34722  --rend=40509 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_6.gz &
# python2.7 gen.py --format=RESP2 --rbegin=40509  --rend=46296 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_7.gz &
# wait

python2.7 gen.py --format=RESP2 --rbegin=5786   --rend=5787  --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_0.gz &
python2.7 gen.py --format=RESP2 --rbegin=11573  --rend=11574 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_1.gz &
python2.7 gen.py --format=RESP2 --rbegin=17360  --rend=17361 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_2.gz &
python2.7 gen.py --format=RESP2 --rbegin=23147  --rend=23148 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_3.gz &
wait
python2.7 gen.py --format=RESP2 --rbegin=28934  --rend=28935 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_4.gz &
python2.7 gen.py --format=RESP2 --rbegin=34721  --rend=34722 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_5.gz &
python2.7 gen.py --format=RESP2 --rbegin=40508  --rend=40509 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_6.gz &
python2.7 gen.py --format=RESP2 --rbegin=46295  --rend=46296 --tbegin=20170101T000000 --tend=20170110T235959 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_7.gz &
wait
