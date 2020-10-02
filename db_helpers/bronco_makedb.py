# Initialize the mysql database with as many memes as we can pull from reddit using PRAW
import broncomemes

if __name__ == "__main__":
    print("Constructing database...")
    broncomemes.MakeDB()
    print("Done")
