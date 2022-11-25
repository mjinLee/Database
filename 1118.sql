-- 1 사원번호, 사원이름, 입사일 (입사일이 빠른 순으로 정렬)
SELECT EMPNO, ENAME, HIREDATE FROM EMP ORDER BY HIREDATE;
-- 2 사원이름, 급여, 연봉을 구하고 연봉이 높은 순으로 출력
SELECT ENAME AS 사원이름, SAL AS 급여, SAL*12+COMM AS 연봉 FROM EMP
  ORDER BY SAL*12+COMM DESC;
-- 3 10번 부서와 20번 부서에서 근무하고 있는 사원의 이름, 부서번호
SELECT ENAME, DEPTNO FROM EMP
  WHERE DEPTNO IN (10,20);
-- 4 커미션을 받는 모든 사원의 이름, 급여, 커미션을 커미션을 기준으로 내림차순 정렬
SELECT ENAME, SAL, COMM FROM EMP
  WHERE COMM IS NOT NULL
  ORDER BY COMM DESC;
-- 5 EMP 테이블의 업무를 첫글자는 대문자, 나머지는 소문자로 출력 (업무의 중복 제거)
SELECT DISTINCT(INITCAP(JOB)) FROM EMP;
-- 6 사원이름 중 A가 포함된 사원의 이름을 구하고 그 이름 중 앞에서 3자만 추출
SELECT SUBSTR(ENAME,1,3) FROM EMP WHERE ENAME LIKE '%A%';
-- 7 이름의 세 번째 문자가 A인 모든 사원의 이름
SELECT ENAME FROM EMP WHERE ENAME LIKE '__A%';
-- 8 사원의 이름이 J, A 또는 M 으로 시작하는 모든 사원의 이름(첫글자는 대문자, 나머지는 소문자 및 길이를 출력
-- 열 레이블은 NAME, LENGTH로 작성
SELECT INITCAP(ENAME) AS NAME, LENGTH(ENAME) AS LENGTH FROM EMP
  WHERE ENAME LIKE 'J%' OR ENAME LIKE 'A%' OR ENAME LIKE 'M%';
--SELECT INITCAP(ENAME), LENGTH(ENAME) FROM EMP
--  WHERE REGEXP_LIKE(ENAME,'^J|^A|^M');
-- 9 이름의 세 번째 문자가 A인 모든 사원의 이름 출력
SELECT ENAME FROM EMP WHERE ENAME LIKE '__A%';
-- 10 이름의 글자수가 6자 이상인 사원의 이름을 소문자로 출력
SELECT LOWER(ENAME) FROM EMP WHERE LENGTH(ENAME)>=6;
-- 11 모든 사원의 이름과 급여를 출력
-- 급여는 15자 길이로 왼쪽에 $ 기호가 채워진 형식으로 표기하고 열 레이블은 SALARY
SELECT ENAME, LPAD(SAL,15,'$') AS SALARY FROM EMP;
-- 12 사원이름, 월급, 월급과 커미션을 더한 값은 실급여로 출력 (단, NULL값은 나타나지 않게 작성)
SELECT ENAME AS 사원이름, SAL AS 월급, NVL(TO_CHAR(SAL+COMM),' ') AS 실급여 FROM EMP;
-- 13 월급과 커미션을 합친 금액이 2000이상인 급여를 받는 사원의 이름, 업무, 월급, 커미션, 고용날짜를 출력
-- 단, 고용날짜는 1980-12-17 형태로 출력
SELECT ENAME, JOB, SAL, COMM, TO_CHAR(HIREDATE,'YYYY-MM-DD') FROM EMP
  WHERE SAL+COMM >= 2000;
-- 14 업무가 동일한 사원 수를 표시
SELECT JOB AS 업무, COUNT(*) AS 사원수 FROM EMP GROUP BY JOB;
-- 15 30번 부서의 사원수
SELECT DEPTNO AS 부서번호, COUNT(*) AS 사원수 FROM EMP WHERE DEPTNO=30 GROUP BY DEPTNO;
-- 16 업무별 최고 월급을 구하고 업무, 최고 월급을 출력
SELECT JOB AS 업무, MAX(SAL) AS 최고월급 FROM EMP GROUP BY JOB;
-- 17 20번 부서의 급여 합계를 구하고 급여합계금액을 출력
SELECT SUM(SAL) FROM EMP WHERE DEPTNO=20;

-- 1 부서별로 지급되는 총월급에서 금액이 7000 이상인 부서번호, 총월급
SELECT DEPTNO, SUM(SAL) AS 총월급 FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=7000;
-- 2 업무별 총월급을 출력하는데 업무가 'MANAGER'인 사원들은 제외하고 총급여가 5000 보다 큰 업무와 총급여만 출력
SELECT JOB, SUM(SAL) AS 총월급 FROM EMP
  WHERE JOB != 'MANAGER'
  GROUP BY JOB HAVING SUM(SAL)>5000;
-- 3 업무별로 사원수가 4명 이상인 업무와 인원수
SELECT JOB, COUNT(*) FROM EMP
  GROUP BY JOB HAVING COUNT(*) >= 4;
-- 4 업무가 MANAGER인 사원의 이름, 업무, 부서명, 근무지
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
  WHERE E.JOB = 'MANAGER';
-- 5 커미션을 받고 급여가 1600 이상인 사원의 이름, 부서명, 근무지
SELECT E.ENAME, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO=D.DEPTNO)
  WHERE COMM IS NOT NULL AND SAL >= 1600;
-- 6 사원의 이름 및 사원번호를 관리자의 이름과 관리자 번호와 함께 표시하고
-- 각 열 레이블은 EMPLOYEE, EMP#, MANAGER, MGR#
SELECT E1.ENAME AS EMPLOYEE, E1.EMPNO AS EMP#, E2.ENAME AS MANAGER, E2.EMPNO AS MGR#
  FROM EMP E1, EMP E2
  WHERE E1.MGR = E2.EMPNO(+);
-- 7 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자의 이름 및 입사일과 함께 표시하고
-- 열 레이블은 각 EMPLOYEE, EMP_HIRED, MANAGER, MGR_HIRED
SELECT E1.ENAME AS EMPLOYEE, E1.HIREDATE AS EMP_HIRED, E2.ENAME AS MANAGER, E2.HIREDATE AS MGR_HIRED
  FROM EMP E1, EMP E2
  WHERE E1.MGR = E2.EMPNO(+)
    AND E1.HIREDATE < E2.HIREDATE;
-- 8 사원의 이름 및 사원번호를 관리자의 이름과 관리자 번호와 함계 표시하고
-- 각 열 레이블은 EMPLOYEE, EMP#, MANAGER, MGR#
-- KING 을 포함하여 관리자가 없는 모든 사원을 표시, 사원번호를 기준으로 정렬
SELECT E1.ENAME AS EMPLOYEE, E1.EMPNO AS EMP#, E2.ENAME AS MANAGER, E2.EMPNO AS MGR#
  FROM EMP E1, EMP E2
  WHERE E1.MGR = E2.EMPNO(+)
  ORDER BY E1.EMPNO;
--SELECT * FROM EMP;
-- 9 사원수가 3명이 넘는 부서의 부서명과 사원수
SELECT D.DNAME AS 부서명, COUNT(*) AS 사원수
  FROM EMP E JOIN DEPT D ON (E.DEPTNO=D.DEPTNO)
  GROUP BY D.DNAME
  HAVING COUNT(*) > 3;
-- 10 사원번호가 7844인 사원보다 빨리 입사한 사원의 이름과 입사일
SELECT ENAME, HIREDATE FROM EMP
  WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE EMPNO=7844);
-- 11 20번 부서에서 가장 급여를 많이 받는 사원과 동일한 급여를 받는 사원의 이름, 부서명, 급여, 급여등급
SELECT E.ENAME, D.DNAME, E.SAL, S.GRADE
  FROM EMP E, DEPT D, SALGRADE S
  WHERE E.DEPTNO=D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL IN (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);
-- 12 커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급
SELECT E.ENAME, S.GRADE
  FROM EMP E JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL)
  WHERE SAL IN (SELECT MAX(SAL) FROM EMP WHERE COMM IS NULL);
-- 13 SMITH의 관리자의 이름과 부서명, 근무지역
SELECT E1.ENAME AS 사원명, E2.ENAME AS 관리자명, D.DNAME AS 부서명, D.LOC AS 근무지역
  FROM EMP E1, EMP E2, DEPT D
  WHERE E1.MGR = E2.EMPNO AND E1.DEPTNO = D.DEPTNO
    AND E1.ENAME = 'SMITH';
    
