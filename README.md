# cs4800_team_pythonsucks
CS4800 team repo<br>
<h3>Configuration</h3>
To set up the database, supply config/database.yml, app/helpers/db_helpers/db.ini, and app/helpers/db_helpers/praw.ini<br>
To install the required python dependencies, use <code>pip install -r requirements.txt</code><br>
To launch the service, start the database updater script first and then start rails<br>
<code>
./db_updater.sh && rails server
</code><br>
If requirements were installed into a python virtual environment, edit <strong>db_updater.sh</strong> to source the virtual environment first<br>
<strong>The server is currently hosted under the address:<code>54.193.67.197:3003</code></strong>
<h3>Routes</h3>
<p>
  <a href="http://54.193.67.197:3003/">Home</a> <strong>(WIP)</strong><br>
  <a href="http://54.193.67.197:3003/gallery">Gallery</a> <strong>(Not yet implemented)</strong>
</p>
<h3>Assignment 3</h3>
<p>
  Relevant pages for assignment 3 have been given routes of the form<br>
  <code>/assignments/[FIRST_NAME]</code><br>
  e.g. /assignments/harvey<br>
  and are associated with the controller "assignments"<br>
  <a href="http://54.193.67.197:3003/assignments/harvey">/assignments/harvey</a><br>
  <a href="http://54.193.67.197:3003/assignments/alan">/assignments/alan</a><br>
  <a href="http://54.193.67.197:3003/assignments/sean">/assignments/sean</a><br>
  <a href="http://54.193.67.197:3003/assignments/ian">/assignments/ian</a><br>
</p>
<h3>Assignment 4</h3>
<p>
  New packages are added to the Gemfile and installed using <code>bundle install</code><br>
  React has been installed to our ruby on rails now by using <code>bundle install</code> then <code>rails g react:install</code> <br>
  Relevant pages for assignment 4 have been given routes of the form<br>
  <code>/assignments/[FIRST_NAME]2</code><br>
  <a href="http://54.193.67.197:3003/assignments/harvey2">/assignments/harvey2</a><br>
  <a href="http://54.193.67.197:3003/assignments/alan2">/assignments/alan2</a><br>
  <a href="http://54.193.67.197:3003/assignments/sean2">/assignments/sean2</a><br>
</p>
