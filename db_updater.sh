# Source the python venv and run database update script
cd ./app/helpers/db_helpers
source env/bin/activate
python3 bronco_update.py &
