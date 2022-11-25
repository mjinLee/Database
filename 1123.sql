SET SERVEROUTPUT ON;
-- SELECT INTO (��ȸ�Ǵ� �����Ͱ� �� �ϳ��� ���� �� ���)
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
 SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
   FROM DEPT
   WHERE DEPTNO = 40;
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
 DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
 DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;
/

-- Ŀ�� (CURSOR; SQL���� ó���ϴ� ������ ������ �޸� ����; Ư�� ���� �����Ͽ� ó��) - �����, ������ Ŀ��
-- ����� Ŀ��
-- �ϳ��� �� ��ȸ
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
 -- ����� Ŀ�� ����
 CURSOR C1 IS
   SELECT DEPTNO, DNAME, LOC
   FROM DEPT
   WHERE DEPTNO = 40;
BEGIN
 -- Ŀ�� ����
 OPEN C1;
 -- Ŀ���κ��� �о�� ������ ���
 FETCH C1 INTO V_DEPT_ROW;
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
 DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
 DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
 -- Ŀ�� �ݱ�
 CLOSE C1;
END;
/
-- ���� �� ��ȸ (LOOP��)
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
 CURSOR C1 IS
   SELECT DEPTNO, DNAME, LOC
   FROM DEPT;
BEGIN
 OPEN C1;
 LOOP
  FETCH C1 INTO V_DEPT_ROW;
  EXIT WHEN C1%NOTFOUND; -- '%NOTFOUND' �Ӽ�: �� �̻� ������ �����Ͱ� ������ EXIT
  -- %NOTFOUND�� ����� FETCH������ ���� ���������� FALSE, �������� �ʾ����� TRUE ��ȯ
  DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO 
                        || ', DNAME : ' || V_DEPT_ROW.DNAME 
                        || ', LOC : ' || V_DEPT_ROW.LOC);
 END LOOP;
 CLOSE C1;
END;
/
-- ���� �� ��ȸ (FOR LOOP��) - OPEN, FETCH, CLOSE �ۼ� X.
DECLARE
 CURSOR C1 IS
   SELECT DEPTNO, DNAME, LOC
   FROM DEPT;
BEGIN
 FOR C1_REC IN C1 LOOP
  EXIT WHEN C1%NOTFOUND; -- '%NOTFOUND' �Ӽ�: �� �̻� ������ �����Ͱ� ������ EXIT
  -- %NOTFOUND�� ����� FETCH������ ���� ���������� FALSE, �������� �ʾ����� TRUE ��ȯ
  DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_REC.DEPTNO 
                        || ', DNAME : ' || C1_REC.DNAME 
                        || ', LOC : ' || C1_REC.LOC);
 END LOOP;
END;
/

-- Q1
-- LOOP�� ����� ���
DECLARE
 V_EMP_ROW EMP%ROWTYPE;
 CURSOR C1 IS
   SELECT * FROM EMP;
BEGIN
 OPEN C1;
 LOOP
  FETCH C1 INTO V_EMP_ROW;
  EXIT WHEN C1%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE('EMPNO : ' || V_EMP_ROW.EMPNO 
                        || ', ENAME : ' || V_EMP_ROW.ENAME 
                        || ', JOB : ' || V_EMP_ROW.JOB
                        || ', SAL : ' || V_EMP_ROW.SAL
                        || ', DEPTNO : ' || V_EMP_ROW.DEPTNO);
 END LOOP;
 CLOSE C1;
END;
/
-- FOR LOOP�� ����� ���
DECLARE
 CURSOR C1 IS
   SELECT * FROM EMP;
BEGIN
 FOR C1_REC IN C1 LOOP
  EXIT WHEN C1%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE('EMPNO : ' || C1_REC.EMPNO 
                        || ', ENAME : ' || C1_REC.ENAME 
                        || ', JOB : ' || C1_REC.JOB
                        || ', SAL : ' || C1_REC.SAL
                        || ', DEPTNO : ' || C1_REC.DEPTNO);
 END LOOP;
END;
/

-- Ŀ���� �Ķ���� ����ϱ�
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
 CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS
  SELECT DEPTNO, DNAME, LOC
    FROM DEPT
    WHERE DEPTNO = P_DEPTNO;
BEGIN
-- 10�� �μ�
 OPEN C1(10);
  LOOP
   FETCH C1 INTO V_DEPT_ROW;
   EXIT WHEN C1%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE('10�� �μ� - DEPTNO : ' || V_DEPT_ROW.DEPTNO 
                        || ', DNAME : ' || V_DEPT_ROW.DNAME 
                        || ', LOC : ' || V_DEPT_ROW.LOC);
  END LOOP;
 CLOSE C1;
 -- 20�� �μ�
 OPEN C1(20);
  LOOP
   FETCH C1 INTO V_DEPT_ROW;
   EXIT WHEN C1%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE('20�� �μ� - DEPTNO : ' || V_DEPT_ROW.DEPTNO 
                        || ', DNAME : ' || V_DEPT_ROW.DNAME 
                        || ', LOC : ' || V_DEPT_ROW.LOC);
  END LOOP;
 CLOSE C1;
END;
/
-- Ŀ���� ����� �Ķ���� �Է¹ޱ�
DECLARE
 V_DEPTNO DEPT.DEPTNO%TYPE;
 CURSOR C1(P_DEPTNO DEPT.DEPTNO%TYPE) IS 
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT
     WHERE DEPTNO = P_DEPTNO;
BEGIN
 V_DEPTNO := &INPUT_DEPTNO;  -- '&INPUT_DEPTNO' : ġȯ����
 FOR C1_REC IN C1(V_DEPTNO) LOOP
  DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_REC.DEPTNO 
                        || ', DNAME : ' || C1_REC.DNAME 
                        || ', LOC : ' || C1_REC.LOC);
 END LOOP;
END;
/
-- ������ Ŀ��
BEGIN
 UPDATE DEPT SET DNAME='DATABASE' WHERE DEPTNO=50;
 DBMS_OUTPUT.PUT_LINE('���ŵ� ���� �� : ' || SQL%ROWCOUNT);
 IF (SQL%FOUND) THEN
  DBMS_OUTPUT.PUT_LINE('���� ��� �� ���� ���� : TRUE');
 ELSE
  DBMS_OUTPUT.PUT_LINE('���� ��� �� ���� ���� : FALSE');
 END IF;
 
 IF (SQL%ISOPEN) THEN
  DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ���� : TRUE');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ���� : FALSE');
 END IF;
END;
/


-- ���� ó��
-- ������ ���� ���� ���� PL/SQL�� �ȿ��� EXCEPTION ������ �ʿ� �ڵ� �ۼ�
DECLARE
 V_WRONG NUMBER;
BEGIN
 SELECT DNAME INTO V_WRONG
   FROM DEPT
   WHERE DEPTNO=10;
 DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�'); -- ������� X.
 EXCEPTION
  WHEN VALUE_ERROR THEN
   DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�'); -- ���� O
END;
/
-- ���� ó���� �ۼ�
DECLARE
 V_WRONG NUMBER;
BEGIN
 SELECT DNAME INTO V_WRONG
   FROM DEPT
   WHERE DEPTNO=10;
 DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');
 EXCEPTION
  WHEN TOO_MANY_ROWS THEN
   DBMS_OUTPUT.PUT_LINE('���� ó�� : �䱸���� ���� �� ���� ���� �߻�');
  WHEN VALUE_ERROR THEN
   DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�'); -- ���� O
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('���� ó�� : ���� ���� �� ���� �߻�');
END;
/
-- ���� �ڵ�� ���� �޽��� ����ϱ�
DECLARE
 V_WRONG NUMBER;
BEGIN
 SELECT DNAME INTO V_WRONG
   FROM DEPT
   WHERE DEPTNO=10;
 DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');
 EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('���� ó�� : ���� ���� �� ���� �߻�');
   DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
   DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

-- Q2
DECLARE
 V_WRONG DATE;
BEGIN
 SELECT ENAME INTO V_WRONG
   FROM EMP
   WHERE EMPNO=7369;
 DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');
 EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('������ �߻��Ͽ����ϴ�.' || TO_CHAR(SYSDATE,'[YYYY"��"MM"��"DD"��" HH24"��"MI"��"SS"��"]'));
   DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
   DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/


-- ���� �������α׷�
-- ���ν���
CREATE OR REPLACE PROCEDURE PRO_NOPARAM
IS
 V_EMPNO NUMBER(4) := 7788;
 V_ENAME VARCHAR2(10);
BEGIN
 V_ENAME := 'SCOTT';
 DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
 DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/