SET SERVEROUTPUT ON;
-- ���� �������α׷�
-- �Լ� (����� ���� �Լ�)
-- �Լ� ����
CREATE OR REPLACE FUNCTION FUNC_AFTERTAX( SAL IN NUMBER ) RETURN NUMBER -- ��ȯ�� �������� �ڷ���
IS
  TAX NUMBER := 0.05;
BEGIN
  RETURN (ROUND(SAL - (SAL * TAX))); -- ��ȯ ��
END FUNC_AFTERTAX;
/
-- �Լ� ����
DECLARE
 AFTERTAX NUMBER;
BEGIN
 AFTERTAX := FUNC_AFTERTAX(3000); -- �Լ� ȣ��
 DBMS_OUTPUT.PUT_LINE('AFTER-TAX INCOME : ' || AFTERTAX);
END;
/
-- SQL ������ �Լ� ����
SELECT FUNC_AFTERTAX(3000) FROM DUAL;
-- �Լ��� ���̺� ������ ���
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
  DBMS_OUTPUT.PUT_LINE('�μ� ��ȣ : ' || IN_DEPTNO);
END PRO_DEPT_IN;
/
--2
DECLARE
  V_DNAME DEPT.DNAME%TYPE;
  V_LOC DEPT.LOC%TYPE;
BEGIN
  PRO_DEPT_IN(10, V_DNAME, V_LOC);
  DBMS_OUTPUT.PUT_LINE('�μ� �̸� : ' || V_DNAME);
  DBMS_OUTPUT.PUT_LINE('���� : ' || V_LOC);
END;
/
-- Q2
CREATE OR REPLACE FUNCTION FUNC_DATE_KOR( DATES IN DATE ) RETURN VARCHAR2
IS
BEGIN
  RETURN (TO_CHAR(DATES, 'YYYY"��"MM"��"DD"��"'));
END FUNC_DATE_KOR;
/
SELECT ENAME, FUNC_DATE_KOR(HIREDATE) AS HIREDATE
  FROM EMP
  WHERE EMPNO=7369;


-- ��Ű��
-- ��Ű�� ���� (��)
CREATE OR REPLACE PACKAGE pkg_example
IS
   spec_no NUMBER := 10;
   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
   PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/
-- ��Ű�� �� Ȯ�� (DD)
SELECT TEXT
  FROM USER_SOURCE
  WHERE TYPE = 'PACKAGE' AND NAME = 'PKG_EXAMPLE';
-- ��Ű�� �� Ȯ�� (DESC)
DESC pkg_example;
-- ��Ű�� ���� ����
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
-- �������α׷� �����ε�
-- ���ν��� �����ε��ϱ�
CREATE OR REPLACE PACKAGE pkg_overload
IS
   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
   PROCEDURE pro_emp(in_ename IN EMP.ENAME%TYPE);
END;
/
-- ��Ű�� �������� �����ε�� ���ν��� �ۼ�
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
-- ��Ű�� ����ϱ�
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
