--
select ename, deptno from emp where deptno in (20,30) order by ename;

select ename, job, sal, comm , to_char(hiredate,'yyyy-mm-dd') as ����� from emp where sal+nvl(comm,0) >= 2000;

select job, count(*) from emp group by job;

select job, max(empno) from emp group by job;

select e.ename, e.job, d.deptno, d.dname 
  from emp e join dept d on (e.deptno=d.deptno) where d.loc='CHICAGO';

select d.loc, count(e.empno)
  from emp e,dept d
  where e.deptno(+)=d.deptno
  group by d.loc
  having count(e.empno) <= 5
  order by count(e.empno);
  
create view emp20 as select * from emp where deptno=20;
select * from emp20;

create view dept_sum as (select d.dname as �μ���,min(e.sal) as �ּұ޿�,max(e.sal) as �ִ�޿�,round(avg(e.sal)) as ��ձ޿� 
                          from emp e join dept d on (e.deptno=d.deptno) group by d.dname);
select * from dept_sum;

select * from user_tables;


-- �÷��� �޼���
SET SERVEROUTPUT ON;
DECLARE
 TYPE ITAB_EX IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
 TEXT_ARR ITAB_EX;
BEGIN
 TEXT_ARR(1) := '1ST DATA';
 TEXT_ARR(2) := '2ND DATA';
 TEXT_ARR(3) := '3RD DATA';
 TEXT_ARR(50) := '50ST DATA';
 DBMS_OUTPUT.PUT_LINE('TEXT_ARR.COUNT : ' || TEXT_ARR.COUNT);
 DBMS_OUTPUT.PUT_LINE('TEXT_ARR.FIRST : ' || TEXT_ARR.FIRST);
 DBMS_OUTPUT.PUT_LINE('TEXT_ARR.LAST : ' || TEXT_ARR.LAST);
 DBMS_OUTPUT.PUT_LINE('TEXT_ARR.PRIOR(50) : ' || TEXT_ARR.PRIOR(50));
 DBMS_OUTPUT.PUT_LINE('TEXT_ARR.NEXT(50) : ' || TEXT_ARR.NEXT(50));
END;
/
