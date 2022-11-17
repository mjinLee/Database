SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;
-- 실습 1
-- 1. 수당을 받고 급여가 1600 이상인 사원의 사원이름, 부서명, 근무지
SELECT E.ENAME, D.DANME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO=D.DEPTNO)
  WHERE COMM IS NOT NULL AND SAL >= 1600;
-- 2. 근무지가 CHICAGO인 모든 사원의 이름, 업무, 부서번호, 부서이름
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
    AND LOC = 'CHICAGO';
-- 3. 근무지별로 근무하는 사원의 수가 5명 이하인 경우, 인원이 적은 도시순으로 출력
SELECT COUNT(*), D.LOC
  FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
  GROUP BY D.LOC
  HAVING COUNT(*) <= 5
  ORDER BY COUNT(*) ASC;
-- 4. 관리자(MGR)보다 먼저 입사한 사원의 이름 및 입사일
SELECT E1.ENAME, E1.HIREDATE
  FROM EMP E1 JOIN EMP E2 ON (E1.MGR=E2.EMPNO)
  WHERE E1.HIREDATE < E2.HIREDATE;
-- 5. CASE WHEN THEN 함수를 사용하여 GRADE를 알파벳 등급으로 출력
SELECT E.ENAME, E.JOB, S.GRADE,
  CASE S.GRADE
    WHEN 1 THEN 'A'
    WHEN 2 THEN 'B'
    WHEN 3 THEN 'C'
    WHEN 4 THEN 'D'
    WHEN 5 THEN 'E'
  END AS GRADE
  FROM EMP E, SALGRADE S
  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
-- 6. 10번 부서에서 급여를 가장 적게 받는 사원과 동일한 급여를 받는 사원의 이름
SELECT ENAME FROM EMP
  WHERE SAL IN (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10);
-- 7. 총급여가 평균 급여보다 많은 급열르 받는 사람의 부서번호, 이름, 총급여, 커미션 출력
SELECT DEPTNO, ENAME, SAL+NVL(COMM,0), COMM, NVL2(COMM,'있음','없음') FROM EMP
  WHERE SAL+NVL(COMM,0) > (SELECT AVG(SAL) FROM EMP);
-- 8. CHICAGO 지역에서 근무하는 사원의 평균 급여보다 높은 급여를 받는 사원의 이름, 급여, 지역명
SELECT E.ENAME, E.SAL, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
  WHERE SAL > (SELECT AVG(E.SAL) FROM EMP E, DEPT D
                 WHERE E.DEPTNO = D.DEPTNO AND D.LOC = 'CHICAGO');
-- 9. 커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급
SELECT E.ENAME, S.GRADE, E.SAL 
  FROM EMP E, SALGRADE S
  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND COMM IS NULL AND SAL IN (SELECT MAX(SAL) FROM EMP);
-- 10. 직속상사가 KING 인 사원의 이름과 급여 출력
SELECT ENAME, SAL FROM EMP
  WHERE MGR IN (SELECT EMPNO FROM EMP WHERE ENAME = 'KING');

-- 실습 2
-- 1. 업무가 SALESMAN인 직원이 2명 이상인 부서의 이름, 사원이름, 업무
SELECT D.DNAME AS 부서명, E.ENAME AS 사원명, E.JOB AS 업무
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
  WHERE E.JOB IN (SELECT JOB FROM EMP 
                    WHERE JOB='SALESMAN' GROUP BY JOB HAVING COUNT(*)>=2);
-- 2. 커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급
SELECT E.ENAME AS 사원이름, S.GRADE AS 급여등급
  FROM EMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
  WHERE COMM IS NULL
    AND SAL IN (SELECT MAX(SAL) FROM EMP);
-- 3. SMITH의 관리자(MGR)의 이름과 부서명, 근무지역
SELECT E1.MGR AS 관리자명, D.DNAME AS 부서명, D.LOC AS 근무지역
  FROM EMP E1, DEPT D, EMP E2
  WHERE E1.DEPTNO =D.DEPTNO AND E1.MGR = E2.EMPNO
    AND E1.MGR IN (SELECT MGR FROM EMP WHERE ENAME='SMITH');
-- 4. 이름의 세 번째 문자가 A인 사원이름
SELECT ENAME AS 사원명 FROM EMP
  WHERE ENAME LIKE '__A%';
-- 5. 이름이 J, A 또는 M 으로 시작하는 모든 사원이름
-- 첫 글자는 대문자, 나머지는 소문자로 표시 및 이름의 길이 출력
SELECT INITCAP(ENAME) AS name, LENGTH(ENAME) AS length FROM EMP
  WHERE ENAME LIKE 'J%' OR ENAME LIKE 'A%' OR ENAME LIKE 'M%';
-- 6. 업무가 동일한 사원 수
SELECT JOB AS 업무, COUNT(*) AS 사원수 FROM EMP
  GROUP BY JOB;


-- 레코드
/*
DECLARE
TYPE 레코드명 IS RECORD
 ( 필드명 필드타입 [NOT NULL] := 디폴트값, 
   ...
 );
 레코드변수명 레코드명;
BEGIN
 레코드변수명.필드명 := 값;
 ...
 DBMS_OUTPUT.PUT_LINE('--- : ' || 레코드변수명.필드명);
END;
/
*/
set serveroutput on;
declare
 type emp_rec is record ( v_empno  number not null := 1111, v_ename varchar2(20));
 rec_emp EMP_REC;
begin
 rec_emp.v_ename := 'SMITH';
 dbms_output.put_line('-----결과-----');
 dbms_output.put_line('사원번호 : ' || rec_emp.v_empno);
 dbms_output.put_line('사원이름 : ' || rec_emp.v_ename);
end;
/
-- DESC EMP;
declare
 type emp_rec is record  ( v_empno emp.empno%type, v_ename emp.ename%type);
 rec_emp emp_rec;
 rec_emp1 emp_rec;
begin
 rec_emp.v_empno := 2222;
 rec_emp.v_ename := 'KANE';
 rec_emp1.v_empno :=  rec_emp.v_empno;
 rec_emp1.v_ename :=  rec_emp.v_ename;
 dbms_output.put_line('rec_emp.v_empno : ' || rec_emp.v_empno);
 dbms_output.put_line('rec_emp.v_ename : ' || rec_emp.v_ename);
 dbms_output.put_line('rec_emp1.v_empno : ' || rec_emp1.v_empno);
 dbms_output.put_line('rec_emp1.v_ename : ' || rec_emp1.v_ename);
end;
/
--
create table r_dept1 as select * from dept;
declare
 r_dep dept%rowtype;
begin
 select  *  into  r_dep  from dept where deptno=10;
 insert into r_dept1 values r_dep;
 end;
/
select * from r_dept1;
--
DECLARE
 V_EMP EMP%ROWTYPE;
BEGIN
 SELECT * INTO V_EMP FROM EMP WHERE ENAME='KING';
 IF(V_EMP.MGR IS NULL) THEN
  V_EMP.JOB := 'CEO';
 END IF;
 DBMS_OUTPUT.PUT_LINE(V_EMP.ENAME || ' : ' || V_EMP.JOB);
END;
/
SELECT ENAME, MGR FROM EMP WHERE ENAME='KING';
