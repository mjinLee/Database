SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;
-- �ǽ� 1
-- 1. ������ �ް� �޿��� 1600 �̻��� ����� ����̸�, �μ���, �ٹ���
SELECT E.ENAME, D.DANME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO=D.DEPTNO)
  WHERE COMM IS NOT NULL AND SAL >= 1600;
-- 2. �ٹ����� CHICAGO�� ��� ����� �̸�, ����, �μ���ȣ, �μ��̸�
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
    AND LOC = 'CHICAGO';
-- 3. �ٹ������� �ٹ��ϴ� ����� ���� 5�� ������ ���, �ο��� ���� ���ü����� ���
SELECT COUNT(*), D.LOC
  FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
  GROUP BY D.LOC
  HAVING COUNT(*) <= 5
  ORDER BY COUNT(*) ASC;
-- 4. ������(MGR)���� ���� �Ի��� ����� �̸� �� �Ի���
SELECT E1.ENAME, E1.HIREDATE
  FROM EMP E1 JOIN EMP E2 ON (E1.MGR=E2.EMPNO)
  WHERE E1.HIREDATE < E2.HIREDATE;
-- 5. CASE WHEN THEN �Լ��� ����Ͽ� GRADE�� ���ĺ� ������� ���
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
-- 6. 10�� �μ����� �޿��� ���� ���� �޴� ����� ������ �޿��� �޴� ����� �̸�
SELECT ENAME FROM EMP
  WHERE SAL IN (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10);
-- 7. �ѱ޿��� ��� �޿����� ���� �޿��� �޴� ����� �μ���ȣ, �̸�, �ѱ޿�, Ŀ�̼� ���
SELECT DEPTNO, ENAME, SAL+NVL(COMM,0), COMM, NVL2(COMM,'����','����') FROM EMP
  WHERE SAL+NVL(COMM,0) > (SELECT AVG(SAL) FROM EMP);
-- 8. CHICAGO �������� �ٹ��ϴ� ����� ��� �޿����� ���� �޿��� �޴� ����� �̸�, �޿�, ������
SELECT E.ENAME, E.SAL, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
  WHERE SAL > (SELECT AVG(E.SAL) FROM EMP E, DEPT D
                 WHERE E.DEPTNO = D.DEPTNO AND D.LOC = 'CHICAGO');
-- 9. Ŀ�̼��� ���� ����� �� ������ ���� ���� ����� �̸��� �޿����
SELECT E.ENAME, S.GRADE, E.SAL 
  FROM EMP E, SALGRADE S
  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND COMM IS NULL AND SAL IN (SELECT MAX(SAL) FROM EMP);
-- 10. ���ӻ�簡 KING �� ����� �̸��� �޿� ���
SELECT ENAME, SAL FROM EMP
  WHERE MGR IN (SELECT EMPNO FROM EMP WHERE ENAME = 'KING');

-- �ǽ� 2
-- 1. ������ SALESMAN�� ������ 2�� �̻��� �μ��� �̸�, ����̸�, ����
SELECT D.DNAME AS �μ���, E.ENAME AS �����, E.JOB AS ����
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
  WHERE E.JOB IN (SELECT JOB FROM EMP 
                    WHERE JOB='SALESMAN' GROUP BY JOB HAVING COUNT(*)>=2);
-- 2. Ŀ�̼��� ���� ����� �� ������ ���� ���� ����� �̸��� �޿����
SELECT E.ENAME AS ����̸�, S.GRADE AS �޿����
  FROM EMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
  WHERE COMM IS NULL
    AND SAL IN (SELECT MAX(SAL) FROM EMP);
-- 3. SMITH�� ������(MGR)�� �̸��� �μ���, �ٹ�����
SELECT E1.MGR AS �����ڸ�, D.DNAME AS �μ���, D.LOC AS �ٹ�����
  FROM EMP E1, DEPT D, EMP E2
  WHERE E1.DEPTNO =D.DEPTNO AND E1.MGR = E2.EMPNO
    AND E1.MGR IN (SELECT MGR FROM EMP WHERE ENAME='SMITH');
-- 4. �̸��� �� ��° ���ڰ� A�� ����̸�
SELECT ENAME AS ����� FROM EMP
  WHERE ENAME LIKE '__A%';
-- 5. �̸��� J, A �Ǵ� M ���� �����ϴ� ��� ����̸�
-- ù ���ڴ� �빮��, �������� �ҹ��ڷ� ǥ�� �� �̸��� ���� ���
SELECT INITCAP(ENAME) AS name, LENGTH(ENAME) AS length FROM EMP
  WHERE ENAME LIKE 'J%' OR ENAME LIKE 'A%' OR ENAME LIKE 'M%';
-- 6. ������ ������ ��� ��
SELECT JOB AS ����, COUNT(*) AS ����� FROM EMP
  GROUP BY JOB;


-- ���ڵ�
/*
DECLARE
TYPE ���ڵ�� IS RECORD
 ( �ʵ�� �ʵ�Ÿ�� [NOT NULL] := ����Ʈ��, 
   ...
 );
 ���ڵ庯���� ���ڵ��;
BEGIN
 ���ڵ庯����.�ʵ�� := ��;
 ...
 DBMS_OUTPUT.PUT_LINE('--- : ' || ���ڵ庯����.�ʵ��);
END;
/
*/
set serveroutput on;
declare
 type emp_rec is record ( v_empno  number not null := 1111, v_ename varchar2(20));
 rec_emp EMP_REC;
begin
 rec_emp.v_ename := 'SMITH';
 dbms_output.put_line('-----���-----');
 dbms_output.put_line('�����ȣ : ' || rec_emp.v_empno);
 dbms_output.put_line('����̸� : ' || rec_emp.v_ename);
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
