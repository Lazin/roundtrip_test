# Generate 8 files

python2.7 main.py --format=RESP2 --rbegin=0      --rend=5787  --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_0.gz &
python2.7 main.py --format=RESP2 --rbegin=5787   --rend=11574 --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_1.gz &
python2.7 main.py --format=RESP2 --rbegin=11574  --rend=17361 --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_2.gz &
python2.7 main.py --format=RESP2 --rbegin=17361  --rend=23148 --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_3.gz &
wait
python2.7 main.py --format=RESP2 --rbegin=23148  --rend=28935 --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_4.gz &
python2.7 main.py --format=RESP2 --rbegin=28935  --rend=34722 --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_5.gz &
python2.7 main.py --format=RESP2 --rbegin=34722  --rend=40509 --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_6.gz &
python2.7 main.py --format=RESP2 --rbegin=40509  --rend=46296 --tbegin=20170101T000000 --tend=20170102T000000 --tdelta=00:00:05 | gzip > 1day_5787rows_5sec_step_7.gz &
wait
