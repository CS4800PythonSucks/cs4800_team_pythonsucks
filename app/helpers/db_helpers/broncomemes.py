# broncomemes provides helper functions for constructing and updating a mysql database of memes sourced from the CalPolyPomona subreddit
import praw
import asyncio
from configparser import ConfigParser
from simplemysql import SimpleMysql

config = ConfigParser()
config.read("db.ini")
_db = SimpleMysql(
    host = config.get("DEFAULT", "host"),
    db = config.get("DEFAULT", "db"),
    user = config.get("DEFAULT", "user"),
    passwd = config.get("DEFAULT", "passwd"),
    keep_alive = config.get("DEFAULT", "keep_alive")
)
reddit = praw.Reddit("meme")
CALPOLY = "CalPolyPomona"
subreddit = reddit.subreddit(CALPOLY)
_lock = asyncio.Lock() # Mutex lock for db object

# Initialize/Update the database with memes scraped from calpoly reddit
async def MakeDB():
    async with _lock:
        # Search hot
        for submission in subreddit.search('flair:"Meme" self:no', sort='hot', limit=1000):
            _db.insertOrUpdate("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
        # Search top
        for submission in subreddit.search('flair:"Meme" self:no', sort='top', limit=1000):
            _db.insertOrUpdate("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
        # Search new
        for submission in subreddit.search('flair:"Meme" self:no', sort='new', limit=1000):
            _db.insertOrUpdate("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
        _db.commit()

# Update database with newest n posts (default 100)
async def GetNew(n:int=100):
    async with _lock:
        for submission in subreddit.search('flair:"Meme" self:no', sort='new', limit=n):
            # Check if the submission already exists in the database
            sql = "SELECT EXISTS(SELECT * FROM posts WHERE sub_id='{}' LIMIT 1)".format(submission.id)
            r = _db.query(sql)
            if r[0] == 0: # Insert into database
                _db.insert("posts", { "sub_id": submission.id, "title": submission.title, "url": submission.url, "votes": submission.score, "subreddit": CALPOLY, "created": submission.created_utc }, "sub_id")
        _db.commit()

# Update the vote count of all entries in the database
async def Update():
    async with _lock:
        entries = _db.getAll("posts", ["sub_id", "votes"])
        id_list = []
        for entry in entries:
            id_list.append("t3_" + entry["sub_id"])
        sub_list = reddit.info(fullnames=id_list)
        for submission in sub_list:
            # Run a raw query since the update function is causing problems
            sql = "UPDATE posts SET votes='{}' WHERE sub_id='{}'".format(submission.score, submission.id)
            # print(sql)
            _db.query(sql)
        _db.commit()

# Upvote the submission and update the entry in the database. Return true on success
async def Upvote(sub_id:str):
    try:
        submission = reddit.submission(id=sub_id)
        submission.upvote()
    except:
        print("broncomemes: upvote: could not upvote id {}".format(sub_id))
        return False
    async with _lock:
        try:
            sql = "UPDATE posts SET votes='{}' WHERE sub_id='{}'".format(submission.score, submission.id)
            _db.query(sql)
        except:
            print("broncomemes: upvote: failed to update database for id {}".format(sub_id))
            return False
        _db.commit()
    return True
        
# Test driver
# if __name__ == "__main__":
    # loop = asyncio.get_event_loop()
    # loop.run_until_complete(Update())
    # loop.close()
    # test = _db.query("SELECT EXISTS(SELECT * FROM posts WHERE sub_id='iuzcw8' LIMIT 1)")
    # print(test.fetchone()[0])
    # test = _db.query("SELECT EXISTS(SELECT * FROM posts WHERE sub_id='foo' LIMIT 1)") # Non-existent entry
    # print(test.fetchone()[0])
