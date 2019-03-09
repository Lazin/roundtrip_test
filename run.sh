AKUMULI_ENDPOINT="167.99.144.58"

function wait_for_completion() {
    response=
    c=0
    printf "Waiting until write will be completed "
    until [ -n "$response" ]; do
        response=$(curl -s --url $AKUMULI_ENDPOINT:8181/api/query -d "{ \"select\": \"cpu.user\", \"where\" : { \"host\": \"$1\" }, \"range\": { \"from\": \"20170110T235955.000000\", \"to\": \"20170111T000000.000000\" }}")
        printf '.'
        sleep 1
        ((c++)) && ((c==20)) && break
    done
    printf "\n$response"
}

# Insert downloaded data
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Sending data in RESP format to $AKUMULI_ENDPOINT @ $timestamp"

cat 1day_5787rows_5sec_step_0.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 1day_5787rows_5sec_step_1.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 1day_5787rows_5sec_step_2.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 1day_5787rows_5sec_step_3.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 1day_5787rows_5sec_step_4.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 1day_5787rows_5sec_step_5.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 1day_5787rows_5sec_step_6.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 1day_5787rows_5sec_step_7.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &

wait

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Wait for completion @ $timestamp"

wait_for_completion "host_5786"
wait_for_completion "host_11573"
wait_for_completion "host_17360"
wait_for_completion "host_23147"
wait_for_completion "host_28934"
wait_for_completion "host_34721"
wait_for_completion "host_40490"
wait_for_completion "host_46295"

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
