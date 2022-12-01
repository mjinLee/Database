SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
--1 �� ��å���� �޿��� ������ ���ϵ� ��å�� Representative �� ����� ����
-- ��, �޿� ������ 30000 �ʰ��� ��å�� ��Ÿ����, �޿� ���� �������� ����
SELECT JOB_ID AS ��å, SUM(SALARY) AS �޿�����
  FROM EMPLOYEES
  WHERE JOB_ID NOT LIKE 'SA_REP'
  GROUP BY JOB_ID
  HAVING SUM(SALARY) > 30000
  ORDER BY SUM(SALARY) ASC;
--2 �� �μ� �̸����� 2005�� ������ �Ի��� �������� �ο����� ���
SELECT D.DEPARTMENT_NAME AS �μ��̸�, COUNT(*) AS �ο���
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE TO_CHAR(HIRE_DATE,'YYYY') < 2005
  GROUP BY D.DEPARTMENT_NAME;
--3 ������� 3�� �̻��� ����� �����ϰ� �ִ� �μ���ȣ, �μ��̸�, �����, �ְ�޿�, �����޿�,
-- ��ձ޿�, �޿��Ѿ��� ���
-- ��� ����� �μ��� ���� ����� ���� ���� ������ ���, ��ձ޿� ���� �Ҽ��� ���ϴ� ����
SELECT D.DEPARTMENT_ID AS �μ���ȣ, D.DEPARTMENT_NAME AS �μ��̸�, COUNT(*) AS �����,
       MAX(E.SALARY) AS �ְ�޿�, MIN(E.SALARY) AS �����޿�, TRUNC(AVG(E.SALARY)) AS ��ձ޿�, SUM(E.SALARY) AS �޿��Ѿ�
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
  HAVING COUNT(*) >= 3
  ORDER BY COUNT(*) DESC;
--4 
-- 1) ���̺� ����/�Է�/����
CREATE TABLE TEST_TBL(DEPTNO, DEPTNAME, MGR, LOC) AS SELECT * FROM DEPARTMENTS WHERE 1=2;
SELECT * FROM TEST_TBL;
-- 2) ���̺� �Է�
INSERT INTO TEST_TBL VALUES(10, '��ȹ��', 100, 120);
INSERT INTO TEST_TBL VALUES(20, '������', NULL, NULL);
INSERT INTO TEST_TBL VALUES(30, '���ߺ�', 120, 300);
INSERT INTO TEST_TBL VALUES(40, '�渮��', 200, 250);
-- 3) TEST_TBL �� ù ��° �� ����
DELETE FROM TEST_TBL WHERE ROWNUM = 1;
-- 4) 30�� �μ��� MGR ���� 300���� ����
UPDATE TEST_TBL SET MGR = 300 WHERE DEPTNO = 30;
-- 5) �渮���� MGR���� 500, LOC���� 222�� ����
UPDATE TEST_TBL SET MGR = 500, LOC = 222 WHERE DEPTNAME = '�渮��';
