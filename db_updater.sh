# Source the python venv and run database update script
cd ./app/helpers/db_helpers
source env/bin/activate
python bronco_update.py &
