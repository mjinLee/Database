SET SERVEROUTPUT ON;
-- SELECT INTO (조회되는 데이터가 단 하나의 행일 때 사용)
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

-- 커서 (CURSOR; SQL문을 처리하는 정보를 저장한 메모리 공간; 특정 열을 선택하여 처리) - 명시적, 묵시적 커서
-- 명시적 커서
-- 하나의 행 조회
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
 -- 명시적 커서 선언
 CURSOR C1 IS
   SELECT DEPTNO, DNAME, LOC
   FROM DEPT
   WHERE DEPTNO = 40;
BEGIN
 -- 커서 열기
 OPEN C1;
 -- 커서로부터 읽어온 데이터 사용
 FETCH C1 INTO V_DEPT_ROW;
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
 DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
 DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
 -- 커서 닫기
 CLOSE C1;
END;
/
-- 여러 행 조회 (LOOP문)
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
 CURSOR C1 IS
   SELECT DEPTNO, DNAME, LOC
   FROM DEPT;
BEGIN
 OPEN C1;
 LOOP
  FETCH C1 INTO V_DEPT_ROW;
  EXIT WHEN C1%NOTFOUND; -- '%NOTFOUND' 속성: 더 이상 추출할 데이터가 없으면 EXIT
  -- %NOTFOUND는 실행된 FETCH문에서 행을 추출했으면 FALSE, 추출하지 않았으면 TRUE 반환
  DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO 
                        || ', DNAME : ' || V_DEPT_ROW.DNAME 
                        || ', LOC : ' || V_DEPT_ROW.LOC);
 END LOOP;
 CLOSE C1;
END;
/
-- 여러 행 조회 (FOR LOOP문) - OPEN, FETCH, CLOSE 작성 X.
DECLARE
 CURSOR C1 IS
   SELECT DEPTNO, DNAME, LOC
   FROM DEPT;
BEGIN
 FOR C1_REC IN C1 LOOP
  EXIT WHEN C1%NOTFOUND; -- '%NOTFOUND' 속성: 더 이상 추출할 데이터가 없으면 EXIT
  -- %NOTFOUND는 실행된 FETCH문에서 행을 추출했으면 FALSE, 추출하지 않았으면 TRUE 반환
  DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_REC.DEPTNO 
                        || ', DNAME : ' || C1_REC.DNAME 
                        || ', LOC : ' || C1_REC.LOC);
 END LOOP;
END;
/

-- Q1
-- LOOP를 사용한 방식
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
-- FOR LOOP를 사용한 방식
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

-- 커서에 파라미터 사용하기
DECLARE
 V_DEPT_ROW DEPT%ROWTYPE;
 CURSOR C1 (P_DEPTNO DEPT.DEPTNO%TYPE) IS
  SELECT DEPTNO, DNAME, LOC
    FROM DEPT
    WHERE DEPTNO = P_DEPTNO;
BEGIN
-- 10번 부서
 OPEN C1(10);
  LOOP
   FETCH C1 INTO V_DEPT_ROW;
   EXIT WHEN C1%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE('10번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO 
                        || ', DNAME : ' || V_DEPT_ROW.DNAME 
                        || ', LOC : ' || V_DEPT_ROW.LOC);
  END LOOP;
 CLOSE C1;
 -- 20번 부서
 OPEN C1(20);
  LOOP
   FETCH C1 INTO V_DEPT_ROW;
   EXIT WHEN C1%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE('20번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO 
                        || ', DNAME : ' || V_DEPT_ROW.DNAME 
                        || ', LOC : ' || V_DEPT_ROW.LOC);
  END LOOP;
 CLOSE C1;
END;
/
-- 커서에 사용할 파라미터 입력받기
DECLARE
 V_DEPTNO DEPT.DEPTNO%TYPE;
 CURSOR C1(P_DEPTNO DEPT.DEPTNO%TYPE) IS 
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT
     WHERE DEPTNO = P_DEPTNO;
BEGIN
 V_DEPTNO := &INPUT_DEPTNO;  -- '&INPUT_DEPTNO' : 치환변수
 FOR C1_REC IN C1(V_DEPTNO) LOOP
  DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_REC.DEPTNO 
                        || ', DNAME : ' || C1_REC.DNAME 
                        || ', LOC : ' || C1_REC.LOC);
 END LOOP;
END;
/
-- 묵시적 커서
BEGIN
 UPDATE DEPT SET DNAME='DATABASE' WHERE DEPTNO=50;
 DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);
 IF (SQL%FOUND) THEN
  DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : TRUE');
 ELSE
  DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : FALSE');
 END IF;
 
 IF (SQL%ISOPEN) THEN
  DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : TRUE');
 ELSE
  DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : FALSE');
 END IF;
END;
/


-- 예외 처리
-- 비정상 종료 막기 위해 PL/SQL문 안에서 EXCEPTION 영역에 필요 코드 작성
DECLARE
 V_WRONG NUMBER;
BEGIN
 SELECT DNAME INTO V_WRONG
   FROM DEPT
   WHERE DEPTNO=10;
 DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다'); -- 실행되지 X.
 EXCEPTION
  WHEN VALUE_ERROR THEN
   DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생'); -- 실행 O
END;
/
-- 예외 처리부 작성
DECLARE
 V_WRONG NUMBER;
BEGIN
 SELECT DNAME INTO V_WRONG
   FROM DEPT
   WHERE DEPTNO=10;
 DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
 EXCEPTION
  WHEN TOO_MANY_ROWS THEN
   DBMS_OUTPUT.PUT_LINE('예외 처리 : 요구보다 많은 행 추출 오류 발생');
  WHEN VALUE_ERROR THEN
   DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생'); -- 실행 O
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
END;
/
-- 오류 코드와 오류 메시지 사용하기
DECLARE
 V_WRONG NUMBER;
BEGIN
 SELECT DNAME INTO V_WRONG
   FROM DEPT
   WHERE DEPTNO=10;
 DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
 EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
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
 DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
 EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('오류가 발생하였습니다.' || TO_CHAR(SYSDATE,'[YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"]'));
   DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
   DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/


-- 저장 서브프로그램
-- 프로시저
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