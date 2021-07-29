# UNT_CSCE5430_Marketplace
Team Project for Class CSCE5430 at UNT

#Install MySQL ver 8.x ( will have to remove password for root after installing)
	->either by running this sql query inside MySQL DB server (connecting with a client such as Workbench - provided with default MySQL installation)
		SET PASSWORD FOR root@localhost='';
	->or this command on command-line console after navigating to install directory of MySQL Server (default: C:\Program Files\MySQL\MySQL Server 8.0\bin)
		mysqladmin --user=root --password="<the password you enter for root-account during setup>" password "";
#Install nodejs 14+

#Pull the repo from this location
	https://github.com/eteral00/UNT_CSCE5430_Marketplace

#Build the DB using MySQL model file in project Database\models directory -> would produce a blank db
#or (PREFERRED) restore it from a dumped-db using a DB dump file/file-set in Database\dumps directory -> would make a DB with data

#Open up a command line console with admin right.
#Navigate to directory where you put the project repo. 
	For example mine was "D:\Workspace\UNT_CSCE5430_Marketplace"
#Run command:
	node app_server
or	
	node app_server.js 
this will start the server on local machine (localhost)

#Open a browser, and enter the URL:
	localhost:3000
(localhost at port 3000)

#for unit tests, in the project directory, run command:
	npm run test

#for additional ADMIN's Functions, install "xampp" (should leave out the mysql in the package to avoid conflicting software because we installed the standalone version already), and config xampp's apache web server to use "port 8081" (we set it up for our site to use this port, so if you use another port, it will require more config/modification)