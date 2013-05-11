# This script makes a backup of your database and sends it to your ftp server. The name of the backup is the date and the name of your database.
#!/bin/bash
date="$(date +%d-%m-%Y)" 			# The date format (Day, month and year in this example).
host=''    							# Put the hostname or the IP address of your ftp server.
ftpuser=""							# The ftp username.
ftppass=''							# The ftp password.
dir=""								# Represents a directory on your ftp server.
mysql_user=''						# Put the MySQL user who has privileges to backup the datababse.
mysql_pass=''						# Put the MySQL password of the user set previously.
database=''							# Put the database name that you want to backup.
echo $date							# Just displaying the date.
mysqldump -u $mysql_user -p$mysql_pass  $database | gzip > "$database"_"$date".sql.gz	# This command backups your database and compresses it into a gzip archive.
ftp -v -n $host <<END_SCRIPT															# Runs the ftp client console, authenticates and puts your gzip archive in a directory on the ftp server
quote USER $ftpuser
quote PASS $ftppass
quote CWD $dir
put "$database"_"$date".sql.gz "$database"_"$date".sql.gz
quit
END_SCRIPT