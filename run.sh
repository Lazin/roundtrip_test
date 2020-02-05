AKUMULI_ENDPOINT="127.0.0.1"

function wait_for_completion() {
    response=
    c=0
    printf "Waiting until write will be completed "
    until [ -n "$response" ]; do
        response=$(curl -s --url $AKUMULI_ENDPOINT:8181/api/query -d "{ \"select\": \"cpu.user\", \"where\" : { \"host\": \"$1\" }, \"range\": { \"from\": \"20170104T235800.000000\", \"to\": \"20170104T235959.000000\" }}")
        #printf '.'
        echo $response
        sleep 1
        ((c++)) && ((c==20)) && break
    done
    printf "\n$response"
}

# Insert downloaded data
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Sending data in RESP format to $AKUMULI_ENDPOINT @ $timestamp"

cat 1day_1Mrows_30sec_step_0.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282  &
cat 1day_1Mrows_30sec_step_1.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282  &
wait

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Wait for completion @ $timestamp"

wait_for_completion "host_1999"

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
