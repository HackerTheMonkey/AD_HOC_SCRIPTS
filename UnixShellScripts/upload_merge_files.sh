#!/usr/bin/ksh
#this shell script is used for uploading the merge files to CDR-HQ, need enabling the user account in the server.
#the script assumes that the "merge" directory is under the root of the FTP server.
#it tries to tar each directory alone, upload it and delete it. after that it continues to the next directory.

tar -cvf G6_BAGHDAD.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END1
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G6_BAGHDAD.tar
bye
END1
rm -fr G6_BAGHDAD.tar

tar -cvf G6_BASRA.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END2
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G6_BASRA.tar
bye
END2
rm -fr G6_BASRA.tar

tar -cvf G6_KIRKUK.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END3
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G6_KIRKUK.tar
bye
END3
rm -fr G6_KIRKUK.tar

tar -cvf G6_MOSUL.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END4
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G6_MOSUL.tar
bye
END4
rm -fr G6_MOSUL.tar

tar -cvf G6_SUL.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END5
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G6_SUL.tar
bye
END5
rm -fr G6_SUL.tar

tar -cvf G6_SUL.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END6
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G6_SUL.tar
bye
END6
rm -fr G6_SUL.tar 

tar -cvf G6_SULY.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END7
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G6_SULY.tar
bye
END7
rm -fr G6_SULY.tar

tar -cvf G9VOICE.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END8
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G9VOICE.tar
bye
END8
rm -fr G9VOICE.tar

tar -cvf G9VTEST.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END9
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G9VTEST.tar
bye
END9
rm -fr put G9VTEST.tar

tar -cvf G9V_BAG.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END10
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G9V_BAG.tar
bye
END10
rm -fr G9V_BAG.tar

tar -cvf G9_BAGHDAD.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END11
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G9_BAGHDAD.tar
bye
END11
rm -fr G9_BAGHDAD.tar

tar -cvf G9_VOICE.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END12
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put G9_VOICE.tar
bye
END12
rm -fr G9_VOICE.tar

tar -cvf GPRS.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END13
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put GPRS.tar
bye
END13
rm -fr GPRS.tar

tar -cvf MSC.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END14
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put MSC.tar
bye
END14
rm -fr MSC.tar

tar -cvf SCD.tar G6_BAGHDAD
ftp -i -n -f 192.168.117.105<<END15
user temp 999999
cd ./merge
lcd /bossapp1/medcdr/Outdata/back/merge
binary
put SCD.tar
bye
END15
rm -fr SCD.tar