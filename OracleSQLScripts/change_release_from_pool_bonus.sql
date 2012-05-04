-- How to change the bonus amount of the release from pool process
Select * From inf_sysparam t Where t.paramkey='CC.PPS.POOLSTATETOIDLE.CHARGEFEE';
Update inf_sysparam t Set t.paramvalue='0.0' Where t.paramkey='CC.PPS.POOLSTATETOIDLE.CHARGEFEE';