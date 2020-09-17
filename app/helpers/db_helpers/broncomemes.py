# broncomemes provides helper functions for constructing and updating a mysql database of memes sourced from the CalPolyPomona subreddit
import praw
from configparser import ConfigParser
from simplemysql import SimpleMysql

config = ConfigParser()
config.read("db.ini")
db = SimpleMysql(
    host = config.get("DEFAULT", "host"),
    db = config.get("DEFAULT", "db"),
    user = config.get("DEFAULT", "user"),
    passwd = config.get("DEFAULT", "passwd"),
    keep_alive = config.get("DEFAULT", "keep_alive")
)
reddit = praw.Reddit("meme")
CALPOLY = "CalPolyPomona"
subreddit = reddit.subreddit(CALPOLY)

# Initialize/Update the database with memes scraped from calpoly reddit
def MakeDB():
    # Search hot
    for submission in subreddit.search('flair:"Meme" self:no', sort='hot', limit=1000):
        db.insertOrUpdate("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
    # Search top
    for submission in subreddit.search('flair:"Meme" self:no', sort='top', limit=1000):
        db.insertOrUpdate("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
    # Search new
    for submission in subreddit.search('flair:"Meme" self:no', sort='new', limit=1000):
        db.insertOrUpdate("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
    db.commit()

# Update database with newest n posts (default 100)
def GetNew(n:int=100):
    for submission in subreddit.search('flair:"Meme" self:no', sort='new', limit=n):
        db.insertOrUpdate("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
    db.commit()

# Update the vote count of all entries in the database
def Update():
    entries = db.getAll("posts", ["sub_id", "votes"])
    id_list = []
    for entry in entries:
        id_list.append("t3_" + entry["sub_id"])
    sub_list = reddit.info(fullnames=id_list)
    for submission in sub_list:
        # Run a raw query since the update function is causing problems
        sql = "UPDATE posts SET votes='{}' WHERE sub_id='{}'".format(submission.score, submission.id)
        db.query(sql)
    db.commit()

# Upvote the submission and update the entry in the database. Return true on success
def Upvote(sub_id:str):
    try:
        submission = reddit.submission(id=sub_id)
    except:
        print("broncomemes: upvote: could not upvote id {}".format(sub_id))
        return False
    submission.upvote()
    try:
        sql = "UPDATE posts SET votes='{}' WHERE sub_id='{}'".format(submission.score, submission.id)
        db.query(sql)
    except:
        print("broncomemes: upvote: failed to update database for id {}".format(sub_id))
        return False
    db.commit()
    return True
        
# Test driver
# if __name__ == "__main__":
#     Update()
