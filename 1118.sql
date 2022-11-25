-- 1 �����ȣ, ����̸�, �Ի��� (�Ի����� ���� ������ ����)
SELECT EMPNO, ENAME, HIREDATE FROM EMP ORDER BY HIREDATE;
-- 2 ����̸�, �޿�, ������ ���ϰ� ������ ���� ������ ���
SELECT ENAME AS ����̸�, SAL AS �޿�, SAL*12+COMM AS ���� FROM EMP
  ORDER BY SAL*12+COMM DESC;
-- 3 10�� �μ��� 20�� �μ����� �ٹ��ϰ� �ִ� ����� �̸�, �μ���ȣ
SELECT ENAME, DEPTNO FROM EMP
  WHERE DEPTNO IN (10,20);
-- 4 Ŀ�̼��� �޴� ��� ����� �̸�, �޿�, Ŀ�̼��� Ŀ�̼��� �������� �������� ����
SELECT ENAME, SAL, COMM FROM EMP
  WHERE COMM IS NOT NULL
  ORDER BY COMM DESC;
-- 5 EMP ���̺��� ������ ù���ڴ� �빮��, �������� �ҹ��ڷ� ��� (������ �ߺ� ����)
SELECT DISTINCT(INITCAP(JOB)) FROM EMP;
-- 6 ����̸� �� A�� ���Ե� ����� �̸��� ���ϰ� �� �̸� �� �տ��� 3�ڸ� ����
SELECT SUBSTR(ENAME,1,3) FROM EMP WHERE ENAME LIKE '%A%';
-- 7 �̸��� �� ��° ���ڰ� A�� ��� ����� �̸�
SELECT ENAME FROM EMP WHERE ENAME LIKE '__A%';
-- 8 ����� �̸��� J, A �Ǵ� M ���� �����ϴ� ��� ����� �̸�(ù���ڴ� �빮��, �������� �ҹ��� �� ���̸� ���
-- �� ���̺��� NAME, LENGTH�� �ۼ�
SELECT INITCAP(ENAME) AS NAME, LENGTH(ENAME) AS LENGTH FROM EMP
  WHERE ENAME LIKE 'J%' OR ENAME LIKE 'A%' OR ENAME LIKE 'M%';
--SELECT INITCAP(ENAME), LENGTH(ENAME) FROM EMP
--  WHERE REGEXP_LIKE(ENAME,'^J|^A|^M');
-- 9 �̸��� �� ��° ���ڰ� A�� ��� ����� �̸� ���
SELECT ENAME FROM EMP WHERE ENAME LIKE '__A%';
-- 10 �̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �ҹ��ڷ� ���
SELECT LOWER(ENAME) FROM EMP WHERE LENGTH(ENAME)>=6;
-- 11 ��� ����� �̸��� �޿��� ���
-- �޿��� 15�� ���̷� ���ʿ� $ ��ȣ�� ä���� �������� ǥ���ϰ� �� ���̺��� SALARY
SELECT ENAME, LPAD(SAL,15,'$') AS SALARY FROM EMP;
-- 12 ����̸�, ����, ���ް� Ŀ�̼��� ���� ���� �Ǳ޿��� ��� (��, NULL���� ��Ÿ���� �ʰ� �ۼ�)
SELECT ENAME AS ����̸�, SAL AS ����, NVL(TO_CHAR(SAL+COMM),' ') AS �Ǳ޿� FROM EMP;
-- 13 ���ް� Ŀ�̼��� ��ģ �ݾ��� 2000�̻��� �޿��� �޴� ����� �̸�, ����, ����, Ŀ�̼�, ��볯¥�� ���
-- ��, ��볯¥�� 1980-12-17 ���·� ���
SELECT ENAME, JOB, SAL, COMM, TO_CHAR(HIREDATE,'YYYY-MM-DD') FROM EMP
  WHERE SAL+COMM >= 2000;
-- 14 ������ ������ ��� ���� ǥ��
SELECT JOB AS ����, COUNT(*) AS ����� FROM EMP GROUP BY JOB;
-- 15 30�� �μ��� �����
SELECT DEPTNO AS �μ���ȣ, COUNT(*) AS ����� FROM EMP WHERE DEPTNO=30 GROUP BY DEPTNO;
-- 16 ������ �ְ� ������ ���ϰ� ����, �ְ� ������ ���
SELECT JOB AS ����, MAX(SAL) AS �ְ���� FROM EMP GROUP BY JOB;
-- 17 20�� �μ��� �޿� �հ踦 ���ϰ� �޿��հ�ݾ��� ���
SELECT SUM(SAL) FROM EMP WHERE DEPTNO=20;

-- 1 �μ����� ���޵Ǵ� �ѿ��޿��� �ݾ��� 7000 �̻��� �μ���ȣ, �ѿ���
SELECT DEPTNO, SUM(SAL) AS �ѿ��� FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=7000;
-- 2 ������ �ѿ����� ����ϴµ� ������ 'MANAGER'�� ������� �����ϰ� �ѱ޿��� 5000 ���� ū ������ �ѱ޿��� ���
SELECT JOB, SUM(SAL) AS �ѿ��� FROM EMP
  WHERE JOB != 'MANAGER'
  GROUP BY JOB HAVING SUM(SAL)>5000;
-- 3 �������� ������� 4�� �̻��� ������ �ο���
SELECT JOB, COUNT(*) FROM EMP
  GROUP BY JOB HAVING COUNT(*) >= 4;
-- 4 ������ MANAGER�� ����� �̸�, ����, �μ���, �ٹ���
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
  WHERE E.JOB = 'MANAGER';
-- 5 Ŀ�̼��� �ް� �޿��� 1600 �̻��� ����� �̸�, �μ���, �ٹ���
SELECT E.ENAME, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO=D.DEPTNO)
  WHERE COMM IS NOT NULL AND SAL >= 1600;
-- 6 ����� �̸� �� �����ȣ�� �������� �̸��� ������ ��ȣ�� �Բ� ǥ���ϰ�
-- �� �� ���̺��� EMPLOYEE, EMP#, MANAGER, MGR#
SELECT E1.ENAME AS EMPLOYEE, E1.EMPNO AS EMP#, E2.ENAME AS MANAGER, E2.EMPNO AS MGR#
  FROM EMP E1, EMP E2
  WHERE E1.MGR = E2.EMPNO(+);
-- 7 ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� �������� �̸� �� �Ի��ϰ� �Բ� ǥ���ϰ�
-- �� ���̺��� �� EMPLOYEE, EMP_HIRED, MANAGER, MGR_HIRED
SELECT E1.ENAME AS EMPLOYEE, E1.HIREDATE AS EMP_HIRED, E2.ENAME AS MANAGER, E2.HIREDATE AS MGR_HIRED
  FROM EMP E1, EMP E2
  WHERE E1.MGR = E2.EMPNO(+)
    AND E1.HIREDATE < E2.HIREDATE;
-- 8 ����� �̸� �� �����ȣ�� �������� �̸��� ������ ��ȣ�� �԰� ǥ���ϰ�
-- �� �� ���̺��� EMPLOYEE, EMP#, MANAGER, MGR#
-- KING �� �����Ͽ� �����ڰ� ���� ��� ����� ǥ��, �����ȣ�� �������� ����
SELECT E1.ENAME AS EMPLOYEE, E1.EMPNO AS EMP#, E2.ENAME AS MANAGER, E2.EMPNO AS MGR#
  FROM EMP E1, EMP E2
  WHERE E1.MGR = E2.EMPNO(+)
  ORDER BY E1.EMPNO;
--SELECT * FROM EMP;
-- 9 ������� 3���� �Ѵ� �μ��� �μ���� �����
SELECT D.DNAME AS �μ���, COUNT(*) AS �����
  FROM EMP E JOIN DEPT D ON (E.DEPTNO=D.DEPTNO)
  GROUP BY D.DNAME
  HAVING COUNT(*) > 3;
-- 10 �����ȣ�� 7844�� ������� ���� �Ի��� ����� �̸��� �Ի���
SELECT ENAME, HIREDATE FROM EMP
  WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE EMPNO=7844);
-- 11 20�� �μ����� ���� �޿��� ���� �޴� ����� ������ �޿��� �޴� ����� �̸�, �μ���, �޿�, �޿����
SELECT E.ENAME, D.DNAME, E.SAL, S.GRADE
  FROM EMP E, DEPT D, SALGRADE S
  WHERE E.DEPTNO=D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL IN (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);
-- 12 Ŀ�̼��� ���� ����� �� ������ ���� ���� ����� �̸��� �޿����
SELECT E.ENAME, S.GRADE
  FROM EMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
  WHERE SAL IN (SELECT MAX(SAL) FROM EMP WHERE COMM IS NULL);
-- 13 SMITH�� �������� �̸��� �μ���, �ٹ�����
SELECT E1.ENAME AS �����, E2.ENAME AS �����ڸ�, D.DNAME AS �μ���, D.LOC AS �ٹ�����
  FROM EMP E1, EMP E2, DEPT D
  WHERE E1.MGR = E2.EMPNO AND E1.DEPTNO = D.DEPTNO
    AND E1.ENAME = 'SMITH';
    
