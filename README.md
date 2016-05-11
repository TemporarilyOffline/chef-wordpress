#Starter Project
##Purpose
  * Assess your ability to take some general specs to a working demo
  * Gives us something to talk about
  * Shouldn't take more than 4 hours
  * Don't make it too complex

##Spec
###Need to have
  * Chef cookbook[s], structure as you see fit.
  * Implement a Linux, MySQL, HHVM, Nginx single host running some sort of blog software (take your pick)
  * Base OS should be ubuntu 14.04
  * Use Berkshelf for dependancy management, please no vendor drops (but version locks are good!)
  * Should leverage community cookbooks when it make sense.
  * Shoud be testable using Vagrant.
 
###Nice to have
  * Security hardening and user management.
  * Should converge both in chef-zero and chef-client modes.
  * Take care with secrets!
  * Funcitonal/Unit/Lint tests are cool.
  * Think in terms of re-usable components.
  * Bonus points for a rake/Thor file for common tasks.

###Details:
  * Run `kitchen converge` to build your sample box
  * Run `kitchen login` to connect to your freshly built box
  * Run `mysql -h 127.0.0.1 -u root -p` and supply the mysql password (`mysql_password`)when prompted to login to mysql
  * Run `kitchen verify` to run tests
  * Open a web browser and visit http://192.168.33.68
  ** Now you can setup wordpress to work on your test-kitchen box using:
  db_name: wordpress, db_user: wordpress, db_password: mysql_password,
  db_host: 127.0.0.1

###Answers to requirements:
  * Add users and their SSH keys by name from github
  * Converges in Chef-Zero under test-kitchen, as a result of how chef-zero is designed, it should run great in chef-client
  * Secrets are stored in encrypted data bags.  Under normal circumstances, I would .gitignore the key to protect the secrets or implement any of the     common security tools like vault or secret server
  * Tests can be vetted with `kitchen verify`
  * This is re-usable in that it creates a stand-alone wordpress server and the first thing you need to do is enter the server details and get started.  This could be designed to load up an existing wordpress site or extended to include backups
  * I'd love to add a rake/Thor file, but didn't see a need for it. Keep it simple
  