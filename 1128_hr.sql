SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
--1 각 직책별로 급여의 총합을 구하되 직책이 Representative 인 사람은 제외
-- 단, 급여 총합이 30000 초과인 직책만 나타내며, 급여 총합 오름차순 정렬
SELECT JOB_ID AS 직책, SUM(SALARY) AS 급여총합
  FROM EMPLOYEES
  WHERE JOB_ID NOT LIKE 'SA_REP'
  GROUP BY JOB_ID
  HAVING SUM(SALARY) > 30000
  ORDER BY SUM(SALARY) ASC;
--2 각 부서 이름별로 2005년 이전에 입사한 직원들의 인원수를 출력
SELECT D.DEPARTMENT_NAME AS 부서이름, COUNT(*) AS 인원수
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE TO_CHAR(HIRE_DATE,'YYYY') < 2005
  GROUP BY D.DEPARTMENT_NAME;
--3 사원수가 3명 이상의 사원을 포함하고 있는 부서번호, 부서이름, 사원수, 최고급여, 최저급여,
-- 평균급여, 급여총액을 출력
-- 출력 결과는 부서에 속한 사원의 수가 많은 순서로 출력, 평균급여 계산시 소수점 이하는 버림
SELECT D.DEPARTMENT_ID AS 부서번호, D.DEPARTMENT_NAME AS 부서이름, COUNT(*) AS 사원수,
       MAX(E.SALARY) AS 최고급여, MIN(E.SALARY) AS 최저급여, TRUNC(AVG(E.SALARY)) AS 평균급여, SUM(E.SALARY) AS 급여총액
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
  HAVING COUNT(*) >= 3
  ORDER BY COUNT(*) DESC;
--4 
-- 1) 테이블 생성/입력/수정
CREATE TABLE TEST_TBL(DEPTNO, DEPTNAME, MGR, LOC) AS SELECT * FROM DEPARTMENTS WHERE 1=2;
SELECT * FROM TEST_TBL;
-- 2) 테이블 입력
INSERT INTO TEST_TBL VALUES(10, '기획부', 100, 120);
INSERT INTO TEST_TBL VALUES(20, '관리부', NULL, NULL);
INSERT INTO TEST_TBL VALUES(30, '개발부', 120, 300);
INSERT INTO TEST_TBL VALUES(40, '경리부', 200, 250);
-- 3) TEST_TBL 의 첫 번째 행 삭제
DELETE FROM TEST_TBL WHERE ROWNUM = 1;
-- 4) 30번 부서의 MGR 값을 300으로 변경
UPDATE TEST_TBL SET MGR = 300 WHERE DEPTNO = 30;
-- 5) 경리부의 MGR값을 500, LOC값을 222로 변경
UPDATE TEST_TBL SET MGR = 500, LOC = 222 WHERE DEPTNAME = '경리부';
