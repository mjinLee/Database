DESC EMPLOYEES;
SELECT * FROM EMPLOYEES;

--1 EMPLOYEES ���̺��� �Ի����� ������ �����Ͽ� �����ȣ, �̸�, ����, �޿�, �Ի�����, �μ���ȣ
SELECT EMPLOYEE_ID AS �����ȣ, JOB_ID AS ����, SALARY AS �޿�, HIRE_DATE AS �Ի�����, DEPARTMENT_ID AS �μ���ȣ
  FROM EMPLOYEES
  ORDER BY HIRE_DATE;
--2 EMPLOYEES ���̺��� ù ��° ������ �μ���ȣ�� �� ��° ������ ������ �� ��° ������ �޿��� ���� ������ ����
-- �����ȣ, ����, �Ի�����, �μ���ȣ, ����, �޿�
SELECT EMPLOYEE_ID AS �����ȣ, CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����, HIRE_DATE AS �Ի�����,
       DEPARTMENT_ID AS �μ���ȣ, JOB_ID AS ����, SALARY AS �޿�
  FROM EMPLOYEES
  ORDER BY DEPARTMENT_ID, JOB_ID, SALARY DESC;
--3 ��� SALESMAN(SA_)�� ���Ͽ� �޿��� ���, �ְ��, ������, �հ�
SELECT AVG(SALARY) AS ��ձ޿�, MAX(SALARY) AS �ְ��, MIN(SALARY) AS ������, SUM(SALARY) AS �հ�
  FROM EMPLOYEES
  WHERE JOB_ID LIKE 'SA%';
--4 ���̺� ��ϵǾ� �ִ� �ο���, ���ʽ��� NULL�� �ƴ� �ο���, ���ʽ��� ���, ��ϵǾ� �ִ� �μ��� ��
SELECT COUNT(EMPLOYEE_ID) AS �ο���, COUNT(COMMISSION_PCT) AS ���ʽ�NOTNULL,
       AVG(COMMISSION_PCT) AS ���ʽ����, COUNT(DISTINCT DEPARTMENT_ID) AS �μ���
  FROM EMPLOYEES;
--SELECT COUNT(*) FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
--SELECT SUM(COUNT(DISTINCT DEPARTMENT_ID)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--5 ���̺��� �μ� �ο��� 4�� ���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ��
SELECT DEPARTMENT_ID AS �μ���ȣ, COUNT(*) AS �ο���, SUM(SALARY) AS �޿��հ�
  FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  HAVING COUNT(*) > 4;
--6 ������ �޿��� ����� 10000 �̻��� ������ ���Ͽ� ������, ��ձ޿�, �޿��� ��
SELECT JOB_ID AS ������, AVG(SALARY) AS ��ձ޿�, SUM(SALARY) AS �޿��հ�
  FROM EMPLOYEES
  GROUP BY JOB_ID
  HAVING AVG(SALARY) >= 1000;
--7 ��ü ������ 10000�� �ʰ��ϴ� �� ������ ���Ͽ� ������ ���޿� �հ�
-- �� �Ǹſ�(SA_)�� �����ϰ� ���޿� �հ�� ����(��������)
SELECT JOB_ID AS ����, SUM(SALARY) AS ���޿��հ�
  FROM EMPLOYEES
  WHERE JOB_ID NOT LIKE 'SA%'
  GROUP BY JOB_ID
  HAVING SUM(SALARY) > 10000
  ORDER BY SUM(SALARY) DESC;

DESC DEPARTMENTS;
SELECT * FROM DEPARTMENTS;
--8 30�� �μ��� ���� ������� �̸�, ����, �μ���
SELECT CONCAT(CONCAT(E.FIRST_NAME,' '),E.LAST_NAME) AS ����̸�, E.JOB_ID AS ����, D.DEPARTMENT_NAME AS �μ���
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE D.DEPARTMENT_ID = 30;
--9 ������ȣ 2500 ���� �ٹ��ϴ� ����̸�, ����, �μ���ȣ, �μ���
SELECT CONCAT(CONCAT(E.FIRST_NAME,' '),E.LAST_NAME) AS ����̸�, E.JOB_ID AS ����,
       D.DEPARTMENT_ID AS �μ���ȣ, D.DEPARTMENT_NAME AS �μ���
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE D.LOCATION_ID = 2500;
--10 ����̸��� �μ���, ������ ����ϴµ� ������ 3000 �̻��� ���
SELECT CONCAT(CONCAT(E.FIRST_NAME,' '),E.LAST_NAME) AS ����̸�, D.DEPARTMENT_NAME AS �μ���, E.SALARY AS ����
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE E.SALARY >= 3000;
  
--11 TJ �̶� ������� �ʰ� �Ի��� ����� �̸��� �Ի���
SELECT CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����̸�, HIRE_DATE AS �Ի���
  FROM EMPLOYEES
  WHERE HIRE_DATE > (SELECT HIRE_DATE FROM EMPLOYEES WHERE FIRST_NAME = 'TJ');
--12 ACCOUNTING �μ� �Ҽ� ����� �̸��� �Ի���
SELECT CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����̸�, HIRE_DATE AS �Ի���
  FROM EMPLOYEES
  WHERE JOB_ID LIKE 'AC%';

--13 Kochhar�� �޿����� ���� ����� ������ �����ȣ, �̸�, ������, �޿�
SELECT EMPLOYEE_ID AS �����ȣ, CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����̸�,
       JOB_ID AS ������, SALARY AS �޿�
  FROM EMPLOYEES
  WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME = 'Kochhar');
--14 �޿��� ��պ��� ���� ����� �����ȣ, �̸�, ������, �޿�, �μ���ȣ
SELECT EMPLOYEE_ID AS �����ȣ, CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����̸�,
       JOB_ID AS ������, SALARY AS �޿�, DEPARTMENT_ID AS �μ���ȣ
  FROM EMPLOYEES
  WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);
--15 100�� �μ��� �ּ� �޿����� �ּ� �޿��� ���� �ٸ� ��� �μ�
SELECT DEPARTMENT_ID AS �μ���ȣ FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  HAVING MIN(SALARY) > (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 100);
--16 ������ SA_MAN�� ����� ������ �̸�, ����, �μ���, �ٹ���
SELECT CONCAT(CONCAT(E.FIRST_NAME,' '),E.LAST_NAME) AS ����̸�, E.JOB_ID AS ����,
       D.DEPARTMENT_NAME AS �μ���, D.LOCATION_ID AS �ٹ���
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE E.JOB_ID = 'SA_MAN';
--17 ���� ���� ����� ���� MANAGER �� �����ȣ
SELECT MANAGER_ID AS MGR�����ȣ 
  FROM EMPLOYEES
  GROUP BY MANAGER_ID
  HAVING COUNT(MANAGER_ID) IN (SELECT MAX(COUNT(*)) FROM EMPLOYEES GROUP BY MANAGER_ID);
--SELECT MANAGER_ID, COUNT(*) FROM EMPLOYEES GROUP BY MANAGER_ID;
--18 ���� ���� ����� ���� �ִ� �μ���ȣ�� �����
SELECT DEPARTMENT_ID AS �μ���ȣ, COUNT(*) AS �����
  FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  HAVING COUNT(*) IN (SELECT MAX(COUNT(*)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID);
--19 �����ȣ�� 123�� ����� ������ ���� �����ȣ�� 192�� ����� �޿����� ���� �����ȣ, �̸�, ����, �޿�
SELECT EMPLOYEE_ID AS �����ȣ, CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����̸�,
       JOB_ID AS ����, SALARY AS �޿�
  FROM EMPLOYEES
  WHERE JOB_ID IN (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=123)
    AND SALARY > (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID=192);
--20 �������� �ּұ޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ��� (�� �������� �������� ����)
SELECT E.EMPLOYEE_ID AS �����ȣ, CONCAT(CONCAT(E.FIRST_NAME,' '),E.LAST_NAME) AS ����̸�,
       E.JOB_ID AS ����, D.DEPARTMENT_NAME AS �μ���, E.SALARY
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE (E.JOB_ID, E.SALARY) IN (SELECT JOB_ID, MIN(SALARY) FROM EMPLOYEES GROUP BY JOB_ID)
  ORDER BY E.JOB_ID DESC;
--SELECT MIN(SALARY),JOB_ID FROM EMPLOYEES GROUP BY JOB_ID ORDER BY JOB_ID DESC;
--21 50�� �μ��� �ּұ޿��� �޴� ������� ���� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի�����, �޿�, �μ���ȣ
-- �� 50�� �μ��� ����
SELECT EMPLOYEE_ID AS �����ȣ, CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����̸�, JOB_ID AS ����,
       HIRE_DATE AS �Ի�����, SALARY AS �޿�, DEPARTMENT_ID AS �μ���ȣ
  FROM EMPLOYEES
  WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID=50)
    AND DEPARTMENT_ID != 50;
--22 50�� �μ��� �ְ�޿��� �޴� ������� ���� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի�����, �޿�, �μ���ȣ
-- �� 50�� �μ��� ����
SELECT EMPLOYEE_ID AS �����ȣ, CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS ����̸�, JOB_ID AS ����,
       HIRE_DATE AS �Ի�����, SALARY AS �޿�, DEPARTMENT_ID AS �μ���ȣ
  FROM EMPLOYEES
  WHERE SALARY > (SELECT MAX(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID=50)
    AND DEPARTMENT_ID != 50;
