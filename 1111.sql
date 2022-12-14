-- 다중행 함수와 데이터 그룹화
-- ROLLUP
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)) FROM EMP
  GROUP BY ROLLUP(DEPTNO,JOB); -- 부서별, 직급별
-- CUBE
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)) FROM EMP
  GROUP BY CUBE(DEPTNO,JOB)
  ORDER BY DEPTNO, JOB;
--
SELECT DEPTNO, JOB, COUNT(*) FROM EMP
  GROUP BY DEPTNO, ROLLUP(JOB);
SELECT DEPTNO, JOB, COUNT(*) FROM EMP
  GROUP BY JOB, ROLLUP(DEPTNO);
-- GROUPING SETS
SELECT DEPTNO, JOB, COUNT(*) FROM EMP
  GROUP BY GROUPING SETS(DEPTNO, JOB)
  ORDER BY DEPTNO, JOB;
-- 그룹화 함수
-- GROUPING
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)), GROUPING(DEPTNO), GROUPING(JOB)
  FROM EMP
  GROUP BY CUBE(DEPTNO,JOB)
  ORDER BY DEPTNO, JOB;
-- GROUPING_ID
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)),
  GROUPING(DEPTNO), GROUPING(JOB), GROUPING_ID(DEPTNO,JOB)
  FROM EMP
  GROUP BY CUBE(DEPTNO,JOB)
  ORDER BY DEPTNO, JOB;
-- LISTAGG
SELECT ENAME FROM EMP WHERE DEPTNO=10;
SELECT DEPTNO, ENAME FROM EMP GROUP BY DEPTNO, ENAME;
SELECT DEPTNO, LISTAGG(ENAME, ', ') WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
  FROM EMP
  GROUP BY DEPTNO;

-- 부서별 인원수와 급여 합계 (GROUP BY 절)
SELECT DEPTNO, JOB, SUM(SAL), COUNT(EMPNO) FROM EMP
  GROUP BY DEPTNO, JOB;
SELECT JOB, SUM(SAL) FROM EMP GROUP BY JOB;
SELECT JOB, SUM(SAL) FROM EMP GROUP BY ROLLUP(JOB);
SELECT DEPTNO, JOB, SUM(SAL), COUNT(EMPNO) FROM EMP
  GROUP BY ROLLUP(DEPTNO,JOB);

-- PIVOT
SELECT * FROM (SELECT DEPTNO, JOB, SAL FROM EMP)
  PIVOT(MAX(SAL) FOR DEPTNO IN (10,20,30))
  ORDER BY JOB;
SELECT * FROM (SELECT DEPTNO, JOB, SAL FROM EMP)
  PIVOT( MAX(SAL) FOR JOB IN ( 'CLERK' AS CLERK, 'SALESMAN' AS SALESMAN,
                              'PRESIDENT' AS PRESIDENT, 'MANAGER' AS MANAGER,
                              'ANALYST' AS ANASYST )
       )
  ORDER BY DEPTNO;
-- DECODE() 이용하여 PIVOT()과 같은 출력 구현
SELECT DEPTNO,
  MAX(DECODE(JOB, 'CLERK',SAL)) AS CLERK,
  MAX(DECODE(JOB, 'SALESMAN',SAL)) AS SALESMAN,
  MAX(DECODE(JOB, 'PRESIDENT',SAL)) AS PRESIDENT,
  MAX(DECODE(JOB, 'MANAGER',SAL)) AS MANAGER,
  MAX(DECODE(JOB, 'ANALYST',SAL)) AS ANALYST
  FROM EMP
  GROUP BY DEPTNO
  ORDER BY DEPTNO;


-- PL/SQL
SET SERVEROUTPUT ON; -- 실행 결과를 화면에 출력
BEGIN
 DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL');
END;
/
-- 변수
DECLARE -- 선언
 V_EMPNO NUMBER(4) := 7788; -- 값 할당 (':=')
 V_ENAME VARCHAR2(10); -- 변수
BEGIN
 V_ENAME := 'SCOTT';
 V_ENAME := 'SYSTEM';
 -- DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
 DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/
-- 상수
DECLARE -- 선언
 V_TAX CONSTANT NUMBER(1) := 3; -- 상수 CONSTANT
BEGIN
 V_TAX := 100; --오류 V_TAX 식은 피할당자로 사용될 수 없음
 DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;
/

SET SERVEROUTPUT ON; -- 실행 결과를 화면에 출력
DECLARE
 V_DEPTNO NUMBER(2) DEFAULT 10; -- 변수의 기본값 지정
 V_DEPTNO2 NUMBER(2) NOT NULL := 20; -- 변수에 NULL값 저장 막기
 V_DEPTNO3 NUMBER(2) NOT NULL DEFAULT 30; -- 변수에 NOT NULL 및 기본값 설정
BEGIN
 DBMS_OUTPUT.PUT_LINE('V_DEPTNO ' || V_DEPTNO);
 DBMS_OUTPUT.PUT_LINE('V_DEPTNO2 ' || V_DEPTNO2);
 DBMS_OUTPUT.PUT_LINE('V_DEPTNO3 ' || V_DEPTNO3);
END;
/
-- 참조형 (열 참조: '%TYPE')
DECLARE
 V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
 DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/
-- 참조형 (행 참조: '%ROWTYPE')
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
 SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
   FROM DEPT
   WHERE DEPTNO = 30;
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
 DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
 DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;
/
-- 조건 제어문
-- ':=' 값 할당 / '=' 같다
DECLARE
 V_NUMBER NUMBER := 14;
BEGIN
 IF MOD(V_NUMBER,2) = 1 THEN
   DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다.');
 ELSE
   DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수입니다.');
 END IF;
END;
/
