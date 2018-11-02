import requests
import sys

def testBashWins():
    topics=["bash","python","go"]
    URL ='http://localhost:8080/vote'
    headers = {'Content-type': 'application/json'}
    expectedWinner = 'bash'
    votes = ["bash","bash","bash","python"]
    #print("Given voting topics " + str(topics) + ", when vote for " + str(votes) + ", then winner is " + expectedWinner)

    r = requests.post(url=URL, json={'topics':topics}, headers=headers)
    #print("Post status: " + str(r.status_code))
    
    for i in range(len(votes)) :
        r = requests.put(url=URL, json={'topic':votes[i]}, headers=headers)

    r = requests.delete(url=URL).json()
    winner = r['winner']

    if (winner == expectedWinner):
        sys.exit()
    else:
        sys.exit(1)

print(testBashWins())