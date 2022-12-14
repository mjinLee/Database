-- FOREIGN KEY ( FK ; 외래키, 외부키 )
DESC EMP; -- DEPTNO 열 ( FK, 외래키 )
DESC DEPT; -- DEPTNO 열 ( PK )
INSERT INTO EMP VALUES (9999,'홍길동', 'CLERK','7788',TO_DATE('2017/04/30','YYYY/MM/DD'),1200,NULL,50); --오류 무결성 제약조건 위배 (부모 키가 없음; DEPTNO->50 X)
-- FOREIGN KEY 지정
CREATE TABLE DEPT_FK (
  DEPTNO NUMBER(2) CONSTRAINT DPETFK_DPETNO_PK PRIMARY KEY,
  DNAME VARCHAR2(14),
  LOC VARCHAR2(13)
  );
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS
  WHERE TABLE_NAME IN ('DEPT_FK'); -- DD
CREATE TABLE EMP_FK (
  EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
  ENAME VARCHAR2(10), JOB VARCHAR2(9), MGR NUMBER(4),
  HIREDATE DATE, SAL NUMBER(7,2), COMM NUMBER(7,2),
  DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK (DEPTNO)
  );
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS
  WHERE TABLE_NAME IN ('EMP_FK'); -- DD
-- EMP_FK 테이블에 데이터 추가 (DEPTNO 데이터가 아직 DEPT_FK 테이블에 없을 때)  
INSERT INTO EMP_FK VALUES (9999,'TEST_NAME', 'TEST_JOB',NULL,TO_DATE('2001/01/01','YYYY/MM/DD'),3000,NULL,10); --오류 무결성 제약조건 위배 (부모 키가 없음)
INSERT INTO DEPT_FK VALUES (10, 'TEST_DNAME', 'TEST_LOC'); -- DEPT_FK에 데이터 삽입 후 다시 EMP_FK에 데이터 추가 가능
-- FOREIGN KEY로 참조 행 데이터 삭제
DELETE FROM DEPT_FK WHERE DEPTNO=10; --오류 무결성 제약조건 위배 (자식 레코드 발견 -부모 키를 참조하고 있는 자식 키가 아직 있으므로 부모키 삭제 불가)

-- CHECK : 데이터 형태와 범위를 정의
CREATE TABLE TABLE_CHECK (
  LOGIN_ID VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,
  LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD)>3), -- PWD 값이 4자리이상
  TEL VARCHAR2(20)
  );
INSERT INTO TABLE_CHECK VALUES ('TEST_ID','123','010-1234-5678'); -- CHECK 제약조건에 위배 (PWD 값이 3자리이므로 위배)
INSERT INTO TABLE_CHECK VALUES ('TEST_ID','1234','010-1234-5678');
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS
  WHERE TABLE_NAME IN ('TABLE_CHECK'); -- DD
DESC TABLE_CHECK; -- 체크 제약조건 확인 불가하므로 DD에서 조회(테이블 이름은 무조건 대문자로)

-- DEFAULT : 기본값 지정
CREATE TABLE TABLE_DEFAULT (
  LOGIN_ID VARCHAR2(20) CONSTRAINT TBLCK2_LOGINID_PK PRIMARY KEY,
  LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
  TEL VARCHAR2(20)
  );
INSERT INTO TABLE_DEFAULT VALUES ('TEST_ID1',NULL,'010-1234-5678');
INSERT INTO TABLE_DEFAULT (LOGIN_ID, TEL) VALUES ('TEST_ID2', '010-1234-5678');
SELECT * FROM TABLE_DEFAULT;

-- Q1
CREATE TABLE DEPT_CONST10 (
  DEPTNO NUMBER(2) CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
  DNAME VARCHAR2(14) CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
  LOC VARCHAR2(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL
  );
CREATE TABLE EMP_CONST10 (
  EMPNO NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY,
  ENAME VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL,
  JOB VARCHAR2(9),
  TEL VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE,
  HIREDATE DATE,
  SAL NUMBER(7,2) CONSTRAINT EMPCONST_SAL_CHK CHECK (SAL BETWEEN 1000 AND 9999),
  COMM NUMBER(7,2),
  DEPTNO NUMBER(2) CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST10 (DEPTNO)
  );
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS
  WHERE TABLE_NAME IN ('DEPT_CONST10','EMP_CONST10') ORDER BY CONSTRAINT_NAME;


-- 사용자 관리, 권한 관리, 롤 관리
-- 사용자 생성
CREATE USER ORCLSTUDY IDENTIFIED BY ORCLE; -- 패스워드(대소문자 구분) --오류 (권한 없음-insufficient privileges)
-- SYSTEM 계정에서 수행할 수 있음 => cmd> sqlplus system/oracle 에서..


-- 그룹화 함수
-- ROLLUP, CUBE
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
  FROM EMP
  GROUP BY DEPTNO, JOB
  ORDER BY DEPTNO, JOB;
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
  FROM EMP
  GROUP BY ROLLUP(DEPTNO, JOB); -- 부서별(DEPTNO)로 COUNT,MAX,SUM,AVG + 전체의 COUNT,MAX,SUM,AVG 값을 추가로 출력해줌
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
  FROM EMP
  GROUP BY CUBE(DEPTNO, JOB) -- + 직책별(JOB)에 대해서도 COUNT,MAX,SUM,AVG
  ORDER BY DEPTNO, JOB;
