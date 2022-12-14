-- 저장 서브프로그램
-- 트리거 (자동 실행 프로그램)
-- DML 트리거
-- DML 트리거의 제작 및 사용(BEFORE)
CREATE TABLE EMP_TRG AS SELECT * FROM EMP; -- 테이블 생성
CREATE OR REPLACE TRIGGER TRG_EMP_NODML_WEEKEND
  -- 주말에 DML(INSERT|UPDATE|DELETE) EVENT(작업)하지말라는 트리거
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
  IF TO_CHAR(SYSDATE, 'DY') IN ('토', '일') THEN
    IF INSERTING THEN
      RAISE_APPLICATION_ERROR(-20000, '주말 사원정보 추가 불가'); -- 예외코드(-20000 ~ -20999) 임의로 부여해 사용
    ELSIF UPDATING THEN
      RAISE_APPLICATION_ERROR(-20001, '주말 사원정보 수정 불가');
    ELSIF DELETING THEN
      RAISE_APPLICATION_ERROR(-20002, '주말 사원정보 삭제 불가');
    ELSE
      RAISE_APPLICATION_ERROR(-20003, '주말 사원정보 변경 불가');
    END IF;
  END IF;
END;
/
-- 제어판-시계 및 시간-날짜 및 시간-시간 및 날짜 설정->토요일로 변경 후 UPDATE 실행
UPDATE EMP_TRG SET SAL = 3500 WHERE EMPNO = 7788; -- 오류보고(주말 사원정보 수정 불가)

-- DML 트리거의 제작 및 사용(AFTER)
CREATE TABLE EMP_TRG_LOG(
  TABLENAME VARCHAR2(10), DML_TYPE VARCHAR2(10), EMPNO NUMBER(4),
  USER_NAME VARCHAR2(30), CHANGE_DATE DATE ); -- 테이블 생성
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW -- 행 트리거
BEGIN
   IF INSERTING THEN
      INSERT INTO emp_trg_log
      VALUES ('EMP_TRG', 'INSERT', :new.empno,
               SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate); 
               -- SYS_CONTEXT : 세션 정보를 얻어오는 함수(namespace,parameter)
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
SELECT SYS_CONTEXT('USERENV', 'HOST') FROM DUAL; -- PC 장치 이름
SELECT SYS_CONTEXT('USERENV', 'IP_ADDRESS') FROM DUAL; -- 루프백 주소
SELECT SYS_CONTEXT('USERENV', 'OS_USER') FROM DUAL;
--
INSERT INTO EMP_TRG
VALUES(9999, 'TestEmp', 'CLERK', 7788, TO_DATE('2018-03-03', 'YYYY-MM-DD'), 1200, null, 20);
COMMIT;
SELECT * FROM EMP_TRG;
SELECT * FROM EMP_TRG_LOG;
UPDATE EMP_TRG SET SAL = 1300 WHERE MGR = 7788;
-- 트리거 관리 (DD)
SELECT TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT, TABLE_NAME, STATUS
  FROM USER_TRIGGERS;
