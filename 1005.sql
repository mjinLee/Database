DESC EMP;

SELECT * FROM EMP;
SELECT EMPNO,ENAME,DEPTNO FROM EMP;

SELECT DISTINCT DEPTNO FROM EMP;
SELECT DISTINCT JOB,DEPTNO FROM EMP;

SELECT ALL JOB,DEPTNO FROM EMP;

SELECT ENAME,SAL*12+COMM,COMM FROM EMP;

SELECT ENAME, SAL*12+COMM AS ANNSAL
 FROM EMP;