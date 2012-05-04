#!/usr/bin/perl -w
open (FILE, "/etc/passwd");
@passwd_data=<FILE>;
close(FILE);
foreach $item (@passwd_data){
(@array1)=split /:/,$item;
print "The login shell for \"" . $array1[0] . "\" user is " . $array1[6] . "\n";
}
