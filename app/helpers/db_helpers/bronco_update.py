# Keep the database up to date with new posts and vote counts
import asyncio
import broncomemes
lock = asyncio.Lock()

# _update keeps the vote counts of all entries up to date every 12 hours
async def update():
    while True:
        async with lock:
            print("Updating database...")
            broncomemes.Update()
            print("Done")
        await asyncio.sleep(12 * 3600)

# _getNew fetches the newest 100 posts every hour
async def getNew():
    while True:
        async with lock:
            print("Getting new posts...")
            broncomemes.GetNew()
            print("Done")
        await asyncio.sleep(3600)

if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    group = asyncio.gather(update(), getNew())
    loop.run_forever()
