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
def UpdateVotes():
    entries = db.getAll("posts", ["sub_id", "votes"])
    for entry in entries:
        submission = reddit.submission(id=entry["sub_id"])
        if submission.score != entry["votes"]:
            db.update("posts", {"votes": submission.score}, ("sub_id=%s", entry["sub_id"]))
    db.commit()
    
# Test driver
# if __name__ == "__main__":
#     MakeDB()
#     posts = db.getAll("posts", ["title"])
#     for post in posts:
#         print(post["title"])
#     UpdateVotes()
