#!/usr/bin/ksh
. ~/.profile


sqlplus  prm/mmprm@boss <<! >>./accumulate.log
set serveroutput on size 1000000
exec billy_test;
quit;
!
