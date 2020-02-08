AKUMULI_ENDPOINT=${AKUMULI_ENDPOINT:-"127.0.0.1"}


echo "Akumuli endpoint: $AKUMULI_ENDPOINT"

function wait_for_completion() {
    response=
    c=0
    printf "Waiting until write will be completed "
    until [ -n "$response" ]; do
        response=$(curl -s --url $AKUMULI_ENDPOINT:8181/api/query -d "{ \"select\": \"cpu.user\", \"where\" : { \"host\": \"$1\" }, \"range\": { \"from\": \"20200115T111220.000000\", \"to\": \"20200115T111320.000000\" }}")
        printf '.'
        sleep 1
        ((c++)) && ((c==20)) && break
    done
    printf "\n$response"
}

# Insert downloaded data
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Sending data in RESP format to $AKUMULI_ENDPOINT @ $timestamp"

cat 500K_series_125000_rows_10sec_step_0.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 500K_series_125000_rows_10sec_step_1.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 500K_series_125000_rows_10sec_step_2.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 500K_series_125000_rows_10sec_step_3.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 500K_series_125000_rows_10sec_step_4.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 500K_series_125000_rows_10sec_step_5.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 500K_series_125000_rows_10sec_step_6.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 500K_series_125000_rows_10sec_step_7.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &

wait

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Wait for completion @ $timestamp"

wait_for_completion "host_49999"
wait_for_completion "host_99999"
wait_for_completion "host_149999"
wait_for_completion "host_199999"
wait_for_completion "host_249999"
wait_for_completion "host_299999"
wait_for_completion "host_349999"
wait_for_completion "host_399999"

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"

# Query everything!
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run aggregate query @ $timestamp"
time curl -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "cpu.user": "max" } }' | wc -l
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run aggregate query @ $timestamp"
time curl -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "cpu.user", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "filter": { "gt": 10000 } }' | wc -l
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
