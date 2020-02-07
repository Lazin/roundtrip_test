# Generate 8 files
# Every file has cardinality of 500000 which will give us total cardinality of 4000000.
# The time range is 10-day with 5-second step. This gives us 17280 datapoints per series per day and
# 59999616000 datapoints total which is close to 60-billion datapoints total.
# The required storage is approximately 223GB.


python2.7 gen.py --rbegin=0       --rend=50000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_0.gz &
python2.7 gen.py --rbegin=50000  --rend=100000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_1.gz &
python2.7 gen.py --rbegin=100000 --rend=150000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_2.gz &
python2.7 gen.py --rbegin=150000 --rend=200000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_3.gz &
python2.7 gen.py --rbegin=200000 --rend=250000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_4.gz &
python2.7 gen.py --rbegin=250000 --rend=300000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_5.gz &
python2.7 gen.py --rbegin=300000 --rend=350000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_6.gz &
python2.7 gen.py --rbegin=350000 --rend=400000 --tbegin=20200101T000000 --tend=20200115T111520 --tdelta=00:00:10 | gzip > 500K_series_125000_rows_10sec_step_7.gz &
wait

