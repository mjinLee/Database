SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14) FROM DUAL;

SELECT MOD(15,6), MOD(10,2), MOD(11,2) FROM DUAL;
SELECT TRUNC(150/60) || '분' || MOD(150,60) || '초' FROM DUAL;

SELECT SYSDATE FROM DUAL;
SELECT SYSDATE AS NOW, SYSDATE -1 AS YESTERDAY, SYSDATE+1 AS TOMORROW FROM DUAL;
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) FROM DUAL;
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR FROM EMP;
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
       MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
       MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
    FROM EMP;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'화요일') FROM DUAL;
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON') AS MON,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY') AS DY,
       TO_CHAR(SYSDATE, 'DAY') AS DAY
    FROM DUAL;
SELECT SYSDATE,
       TO_CHAR(SYSDATE,'MM') AS MM,       
       TO_CHAR(SYSDATE,'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KR,
       TO_CHAR(SYSDATE,'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
       TO_CHAR(SYSDATE,'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_ENG,
       TO_CHAR(SYSDATE,'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MONTH_KR,
       TO_CHAR(SYSDATE,'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
       TO_CHAR(SYSDATE,'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MONTH_ENG
    FROM DUAL;
SELECT SYSDATE,
       TO_CHAR(SYSDATE,'DD') AS DD,
       TO_CHAR(SYSDATE,'DY', 'NLS_DATE_LANGUAGE = KOREAN') AS DY_KR,
       TO_CHAR(SYSDATE,'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DY_JPN,
       TO_CHAR(SYSDATE,'DY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DY_ENG,
       TO_CHAR(SYSDATE,'DAY', 'NLS_DATE_LANGUAGE = KOREAN') AS DAY_KR,
       TO_CHAR(SYSDATE,'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DAY_JPN,
       TO_CHAR(SYSDATE,'DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DAY_ENG
    FROM DUAL;

SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
       TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
       TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
    FROM DUAL;

SELECT TO_NUMBER('1,300','9,999') - TO_NUMBER('1,500','9,999') FROM DUAL;

SELECT TO_DATE('2018-07-14','YYYY-MM-DD') AS TODATE1,
       TO_DATE('20180714','YYYY-MM-DD') AS TODATE2
    FROM DUAL;
    
SELECT HIREDATE FROM EMP;
SELECT * FROM EMP WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');


SELECT ENAME AS 사원명, JOB AS 담당업무, HIREDATE AS 입사일 
  FROM EMP
  WHERE HIREDATE BETWEEN '1981/02/20' AND '1981/05/01' ;
  
SELECT ENAME AS 사원명 FROM EMP WHERE ENAME LIKE '__R%';

SELECT ENAME AS 사원명 FROM EMP WHERE ENAME LIKE '%A%' AND ENAME LIKE '%E%';

SELECT SUBSTR(HIREDATE,1,4) AS 입사연도, SUBSTR(HIREDATE,6,2) AS 입사한달 FROM EMP;

SELECT ENAME AS 사원명 FROM EMP WHERE SUBSTR(HIREDATE,7,1)=4;

SELECT * FROM EMP WHERE MOD(EMPNO,2)=0;


SELECT ENAME, SAL, COMM, NVL(COMM,0), SAL+NVL(COMM,0) FROM EMP;
SELECT ENAME, SAL, COMM, NVL2(COMM,'O','X') FROM EMP;
SELECT ENAME, SAL, COMM, NVL2(COMM,1*10,2*20) FROM EMP;