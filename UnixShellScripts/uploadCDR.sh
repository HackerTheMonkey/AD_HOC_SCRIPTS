# This is an FTP script that using a HERE document
ftp_user="root"
ftp_password="rootroot"
ftp_server="$1"
folder="$2"
file="$3"
ftp -n -i ${ftp_server}<<END
user ${ftp_user} ${ftp_password}
cd $folder
put $file
cd ..
END