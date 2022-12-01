SET SERVEROUTPUT ON;
-- 저장 서브프로그램
-- 함수 (사용자 정의 함수)
-- 함수 생성
CREATE OR REPLACE FUNCTION FUNC_AFTERTAX( SAL IN NUMBER ) RETURN NUMBER -- 반환할 데이터의 자료형
IS
  TAX NUMBER := 0.05;
BEGIN
  RETURN (ROUND(SAL - (SAL * TAX))); -- 반환 값
END FUNC_AFTERTAX;
/
-- 함수 실행
DECLARE
 AFTERTAX NUMBER;
BEGIN
 AFTERTAX := FUNC_AFTERTAX(3000); -- 함수 호출
 DBMS_OUTPUT.PUT_LINE('AFTER-TAX INCOME : ' || AFTERTAX);
END;
/
-- SQL 문에서 함수 실행
SELECT FUNC_AFTERTAX(3000) FROM DUAL;
-- 함수에 테이블 데이터 사용
SELECT EMPNO, ENAME, SAL, FUNC_AFTERTAX(SAL) AS AFTERTAX FROM EMP;

-- Q1
--1
CREATE OR REPLACE PROCEDURE PRO_DEPT_IN
(
  IN_DEPTNO IN DEPT.DEPTNO%TYPE,
  OUT_DNAME OUT DEPT.DNAME%TYPE,
  OUT_LOC OUT DEPT.LOC%TYPE
)
IS
BEGIN
  SELECT DNAME, LOC INTO OUT_DNAME, OUT_LOC
    FROM DEPT
    WHERE DEPTNO = IN_DEPTNO;
  DBMS_OUTPUT.PUT_LINE('부서 번호 : ' || IN_DEPTNO);
END PRO_DEPT_IN;
/
--2
DECLARE
  V_DNAME DEPT.DNAME%TYPE;
  V_LOC DEPT.LOC%TYPE;
BEGIN
  PRO_DEPT_IN(10, V_DNAME, V_LOC);
  DBMS_OUTPUT.PUT_LINE('부서 이름 : ' || V_DNAME);
  DBMS_OUTPUT.PUT_LINE('지역 : ' || V_LOC);
END;
/
-- Q2
CREATE OR REPLACE FUNCTION FUNC_DATE_KOR( DATES IN DATE ) RETURN VARCHAR2
IS
BEGIN
  RETURN (TO_CHAR(DATES, 'YYYY"년"MM"월"DD"일"'));
END FUNC_DATE_KOR;
/
SELECT ENAME, FUNC_DATE_KOR(HIREDATE) AS HIREDATE
  FROM EMP
  WHERE EMPNO=7369;


-- 패키지
-- 패키지 생성 (명세)
CREATE OR REPLACE PACKAGE pkg_example
IS
   spec_no NUMBER := 10;
   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
   PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/
-- 패키지 명세 확인 (DD)
SELECT TEXT
  FROM USER_SOURCE
  WHERE TYPE = 'PACKAGE' AND NAME = 'PKG_EXAMPLE';
-- 패키지 명세 확인 (DESC)
DESC pkg_example;
-- 패키지 본문 생성
CREATE OR REPLACE PACKAGE BODY pkg_example
IS
   body_no NUMBER := 10;

   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER
      IS
         tax NUMBER := 0.05;
      BEGIN
         RETURN (ROUND(sal - (sal * tax)));
   END func_aftertax;

   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
      IS
         out_ename EMP.ENAME%TYPE;
         out_sal EMP.SAL%TYPE;
      BEGIN
         SELECT ENAME, SAL INTO out_ename, out_sal
           FROM EMP
          WHERE EMPNO = in_empno;
        DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
        DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
   END pro_emp;

   PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE)
     IS
        out_dname DEPT.DNAME%TYPE;
        out_loc DEPT.LOC%TYPE;
     BEGIN
        SELECT DNAME, LOC INTO out_dname, out_loc
          FROM DEPT
         WHERE DEPTNO = in_deptno;

        DBMS_OUTPUT.PUT_LINE('DNAME : ' || out_dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || out_loc);
   END pro_dept;
END;
/
-- 서브프로그램 오버로드
-- 프로시저 오버로드하기
CREATE OR REPLACE PACKAGE pkg_overload
IS
   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
   PROCEDURE pro_emp(in_ename IN EMP.ENAME%TYPE);
END;
/
-- 패키지 본문에서 오버로드된 프로시저 작성
CREATE OR REPLACE PACKAGE BODY pkg_overload
IS
   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
      IS
         out_ename EMP.ENAME%TYPE;
         out_sal EMP.SAL%TYPE;
      BEGIN
         SELECT ENAME, SAL INTO out_ename, out_sal
           FROM EMP
          WHERE EMPNO = in_empno;

         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
      END pro_emp;

   PROCEDURE pro_emp(in_ename IN EMP.ENAME%TYPE)
      IS
         out_ename EMP.ENAME%TYPE;
         out_sal EMP.SAL%TYPE;
      BEGIN
         SELECT ENAME, SAL INTO out_ename, out_sal
           FROM EMP
          WHERE ENAME = in_ename;

         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
      END pro_emp;

END;
/
-- 패키지 사용하기
BEGIN
   DBMS_OUTPUT.PUT_LINE('--pkg_example.func_aftertax(3000)--');
   DBMS_OUTPUT.PUT_LINE('after-tax:' || pkg_example.func_aftertax(3000));

   DBMS_OUTPUT.PUT_LINE('--pkg_example.pro_emp(7788)--');
   pkg_example.pro_emp(7788);

   DBMS_OUTPUT.PUT_LINE('--pkg_example.pro_dept(10)--' );
   pkg_example.pro_dept(10);

   DBMS_OUTPUT.PUT_LINE('--pkg_overload.pro_emp(7788)--' );
   pkg_overload.pro_emp(7788);

   DBMS_OUTPUT.PUT_LINE('--pkg_overload.pro_emp(''SCOTT'')--' );
   pkg_overload.pro_emp('SCOTT');
END;
/
