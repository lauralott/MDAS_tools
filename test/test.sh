url='http://votingapp:8080/vote'
http_client(){
    curl --url url \
    --request $1 \
    --data  "$2" \
    --header 'Content-Type: application/json'
}
topics='{"topics":["bash","python","go"]}'
expectedWinner='bash'
echo "Given voting topics $topics, when vote for $options, then winner is $expectedWinner"   

http_client POST $topics

for option in bash bash bash python
do 
    http_client PUT '{"topic":"'$option'"}'
done

winner=$(http_client DELETE | jq -r '.winner')

if [ "$expectedWinner" = "$winner" ]; then
    exit 0
else
    echo "Test Failed"
    exit 1
fi
