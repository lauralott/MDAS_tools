url='http://votingapp:8080/vote'
bash_wins(){
    set -e 
    http_client(){
        curl --url url \
        --request $1 \
        --data  "$2" \
        --header 'Content-Type: application/json' \
        --silent \
        --output /dev/null  \
        --write-out "%{http_code}"
    }
    topics='{"topics":["bash","python","go"]}'
    expectedWinner='bash'
    echo "Given voting topics $topics, when vote for $options, then winner is $expectedWinner"   

    status=$(http_client POST $topics)
    if [  "$status" -ne 200 ]; then
        echo "status $status"
        return 1
    fi    

    for option in bash bash bash python
    do 
        http_client PUT '{"topic":"'$option'"}'
    done

    winner=$(http_client DELETE | jq -r '.winner')

    if [ "$expectedWinner" = "$winner" ]; then
        echo "Test OK"
        exit 0
    else
        echo "Test Failed"
        exit 1
    fi

}

retry(){
    waitingSeconds=2
    echo "Init test (sh)..."
    for i in 1 2 3; 
    do 
        echo "Try $i" && $1 && break || sleep $waitingSeconds;
    done
    exit 1
}

retry bash_wins