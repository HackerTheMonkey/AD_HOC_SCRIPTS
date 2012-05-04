hostname
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
echo Export from P570_DB1 began at `date`
exp system/tig4boss4@p570rate file=boss070719.dmp owner=billing,ccare,mediation,medser,medtopeng,topeng grants=y buffer=102400 feedback=1000000
echo Export ended at `date`
