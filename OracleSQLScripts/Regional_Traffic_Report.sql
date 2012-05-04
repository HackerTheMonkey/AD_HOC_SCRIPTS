--First Report - International - Part One
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_idd_200902 t 
where t.starttime >= '12-FEB-09'
group by t.cdr_type,substr(t.sourfilename,1,3);

--First Report - International - Part Two
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_idd_200903 t 
where t.starttime <= '13-MAR-09'
group by t.cdr_type,substr(t.sourfilename,1,3);

--Second Report - International - Part One
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_idd_200903 t 
where t.starttime >= '14-MAR-09'
group by t.cdr_type,substr(t.sourfilename,1,3);

--Second Report - International - Part Two
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_idd_200904 t 
where t.starttime <= '14-APR-09'
group by t.cdr_type,substr(t.sourfilename,1,3);

--First Report - National - Part One
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_inter_200902 t 
where t.starttime >= '12-FEB-09'
group by t.cdr_type,substr(t.sourfilename,1,3);

--First Report - National - Part Two
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_inter_200903 t 
where t.starttime <= '13-MAR-09'
group by t.cdr_type,substr(t.sourfilename,1,3);

--Second Report - National - Part One
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_inter_200903 t 
where t.starttime >= '14-MAR-09'
group by t.cdr_type,substr(t.sourfilename,1,3);

--Second Report - National - Part Two
select t.cdr_type,substr(t.sourfilename,1,3) as region,count(*) as "No_Of_Calls",sum(t.duration)/60 "total_minutes" 
from prm_inter_200904 t 
where t.starttime <= '14-APR-09'
group by t.cdr_type,substr(t.sourfilename,1,3);
