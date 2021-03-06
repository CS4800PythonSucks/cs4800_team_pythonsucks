# cs4800_team_pythonsucks
CS4800 team repo<br>
<h3>Configuration</h3>
To set up the database, supply config/database.yml, db_helpers/db.ini, and db_helpers/praw.ini<br>
To install the required python dependencies, use <code>pip install -r requirements.txt</code><br>
To launch the service, start the database updater script first and then start rails<br>
<code>
./db_updater.sh && rails server
</code><br>
If requirements were installed into a python virtual environment, edit <strong>db_updater.sh</strong> to source the virtual environment first<br>
<h3>Routes</h3>
<p>
  <a href="http://memepoly.com/">memepoly.com</a> <strong>(Domain name)</strong><br>
  <a href="http://memepoly.com/">Home</a><br>
  <a href="http://memepoly.com/gallery?page=1&sort=new">Gallery</a>
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
<h3>Assignment 6</h3>
<p>
  Tests are written using the Minitest testing framework bundled with rails to verify the integrity of models, controllers, views, etc. Because they need access to the database, database credentials are required to run them.
  <br><br>
  Harvey Lin: Wrote a validation test for the Post model sub_id field in test/models/post_test.rb<br>
  Sean: Validation test for user model in test/models/user_test.rb
</p>
