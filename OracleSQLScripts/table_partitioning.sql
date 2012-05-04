select * from tab;
create table tmp_emp as select * from emp;
select empno,ename,rowid from hasanein.tmp_emp order by ename;
truncate table tmp_emp;
select * from hasanein.tmp_emp a where a.ename='RAYA';
select * from hasanein.emp;

--################################################### Part One ########################################################

-- to create a table that will contain part1 of tmp_emp table
create table tmp_emp_part1 as (select * from (select * from hasanein.tmp_emp order by ename) where rownum<11);
select * from tmp_emp_part1;
truncate table tmp_emp_part1;
drop table tmp_emp_part1;
-- to remove part1 from tmp_emp
delete from tmp_emp where rowid in (select rowid from (select * from hasanein.tmp_emp order by ename) where rownum<11);

--################################################### Part Two ########################################################

-- to create a table that will contain part1 of tmp_emp table
create table tmp_emp_part2 as (select * from (select * from hasanein.tmp_emp order by ename) where rownum<5);
select * from tmp_emp_part2;
truncate table tmp_emp_part2;
drop table tmp_emp_part2;
-- to remove part1 from tmp_emp
delete from tmp_emp where rowid in (select rowid from (select * from hasanein.tmp_emp order by ename) where rownum<5);

--################################################### Part Three ########################################################

-- to create a table that will contain part3 of tmp_emp table
create table tmp_emp_part3 as select * from hasanein.tmp_emp order by ename;
select * from tmp_emp_part3;
truncate table tmp_emp_part3;
drop table tmp_emp_part3;
-- to remove part1 from tmp_emp
delete from tmp_emp where rowid in (select rowid from (select * from hasanein.tmp_emp order by ename));

insert into hasanein.tmp_emp
			 select * from hasanein.tmp_emp;