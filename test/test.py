import requests
import time
import sys

def BashWins():
    topics=["bash","python","go"]
    URL ='http://votingapp:8080/vote'
    headers = {'Content-type': 'application/json'}
    expectedWinner = 'bash'
    votes = ["bash","bash","bash","python"]
    print("Given voting topics " + str(topics) + ", when vote for " + str(votes) + ", then winner is " + expectedWinner)

    r = requests.post(url=URL, json={'topics':topics}, headers=headers)
    print("Post status: " + str(r.status_code))

    for i in range(len(votes)) :
        r = requests.put(url=URL, json={'topic':votes[i]}, headers=headers)

    r = requests.delete(url=URL).json()
    winner = r['winner']

    if (winner == expectedWinner):
        print("Test OK")
        sys.exit()
    else:
        print("test FAILED")
        sys.exit(1)


def Retry(func):
    waitingSeconds = 1
    print("Init test (py)...")
    for i in range(0,3):
        print("Try " + str(i))
        try:
            func()   
        except requests.exceptions.RequestException as e:
            print(e)
            if i==2:
                sys.exit(1)
            time.sleep(waitingSeconds)
            waitingSeconds = waitingSeconds * 5
            continue
        break

Retry(BashWins)

