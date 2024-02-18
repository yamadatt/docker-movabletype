# The CGIPath is the URL to your Movable Type directory
CGIPath /cgi-bin/mt/

# simply remove it or comment out the line by prepending a "#".
StaticWebPath /cgi-bin/mt/mt-static

#================ DATABASE SETTINGS ==================
#   CHANGE setting below that refer to databases
#   you will be using.

##### MYSQL #####
ObjectDriver DBI::mysql
Database movabletype
DBUser movabletype
DBPassword movabletype
DBHost poc-db.cl2fcorccc8w.ap-northeast-1.rds.amazonaws.com

## Change setting to language that you want to using.
DefaultLanguage ja

## Debug Mode
DebugMode 1
