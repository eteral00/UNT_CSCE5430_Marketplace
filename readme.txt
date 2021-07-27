+Install MySQL ver 8.x ( do NOT set password for root )
+Install nodejs 14+

+Pull the repo from this location
	https://github.com/eteral00/UNT_CSCE5430_Marketplace

+Build the DB using MySQL model file in project Database\models directory -> would produce a blank db
+or (PREFERRED) restore it from a dumped-db using a DB dump file/file-set in Database\dumps directory -> would make a DB with data

+Open up a command line console with admin right.
+Navigate to directory where you put the project repo. 
	For example mine was "D:\Workspace\UNT_CSCE5430_Marketplace"
+Run command:
	node app_server
or	
	node app_server.js 
this will start the server on local machine (localhost)

+Open a browser, and enter the URL:
	localhost:3000
localhost at port 3000