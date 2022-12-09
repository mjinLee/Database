-- ���� �������α׷�
-- Ʈ���� (�ڵ� ���� ���α׷�)
-- DML Ʈ����
-- DML Ʈ������ ���� �� ���(BEFORE)
CREATE TABLE EMP_TRG AS SELECT * FROM EMP; -- ���̺� ����
CREATE OR REPLACE TRIGGER TRG_EMP_NODML_WEEKEND
  -- �ָ��� DML(INSERT|UPDATE|DELETE) EVENT(�۾�)��������� Ʈ����
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
  IF TO_CHAR(SYSDATE, 'DY') IN ('��', '��') THEN
    IF INSERTING THEN
      RAISE_APPLICATION_ERROR(-20000, '�ָ� ������� �߰� �Ұ�'); -- �����ڵ�(-20000 ~ -20999) ���Ƿ� �ο��� ���
    ELSIF UPDATING THEN
      RAISE_APPLICATION_ERROR(-20001, '�ָ� ������� ���� �Ұ�');
    ELSIF DELETING THEN
      RAISE_APPLICATION_ERROR(-20002, '�ָ� ������� ���� �Ұ�');
    ELSE
      RAISE_APPLICATION_ERROR(-20003, '�ָ� ������� ���� �Ұ�');
    END IF;
  END IF;
END;
/
-- ������-�ð� �� �ð�-��¥ �� �ð�-�ð� �� ��¥ ����->����Ϸ� ���� �� UPDATE ����
UPDATE EMP_TRG SET SAL = 3500 WHERE EMPNO = 7788; -- ��������(�ָ� ������� ���� �Ұ�)

-- DML Ʈ������ ���� �� ���(AFTER)
CREATE TABLE EMP_TRG_LOG(
  TABLENAME VARCHAR2(10), DML_TYPE VARCHAR2(10), EMPNO NUMBER(4),
  USER_NAME VARCHAR2(30), CHANGE_DATE DATE ); -- ���̺� ����
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW -- �� Ʈ����
BEGIN
   IF INSERTING THEN
      INSERT INTO emp_trg_log
      VALUES ('EMP_TRG', 'INSERT', :new.empno,
               SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate); 
               -- SYS_CONTEXT : ���� ������ ������ �Լ�(namespace,parameter)
   ELSIF UPDATING THEN
      INSERT INTO emp_trg_log
      VALUES ('EMP_TRG', 'UPDATE', :old.empno,
               SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
   ELSIF DELETING THEN
      INSERT INTO emp_trg_log
      VALUES ('EMP_TRG', 'DELETE', :old.empno,
               SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
   END IF;
END;
/
SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') FROM DUAL;
SELECT SYS_CONTEXT('USERENV', 'HOST') FROM DUAL; -- PC ��ġ �̸�
SELECT SYS_CONTEXT('USERENV', 'IP_ADDRESS') FROM DUAL; -- ������ �ּ�
SELECT SYS_CONTEXT('USERENV', 'OS_USER') FROM DUAL;
--
INSERT INTO EMP_TRG
VALUES(9999, 'TestEmp', 'CLERK', 7788, TO_DATE('2018-03-03', 'YYYY-MM-DD'), 1200, null, 20);
COMMIT;
SELECT * FROM EMP_TRG;
SELECT * FROM EMP_TRG_LOG;
UPDATE EMP_TRG SET SAL = 1300 WHERE MGR = 7788;
-- Ʈ���� ���� (DD)
SELECT TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT, TABLE_NAME, STATUS
  FROM USER_TRIGGERS;
