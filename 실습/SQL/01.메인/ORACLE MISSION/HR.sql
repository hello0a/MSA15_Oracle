-- 1. 시스템 계정 접속
conn system/123456;
-- 2. ALL_USERS 에서 HR 계정 조회
SELECT user_id, username
FROM ALL_USERS
WHERE username = 'HR'
;
-- 3. employees 테이블 구조를 조회하는 명령
desc employees;
-- * employees 테이블의 employee_id, first_name 조회
SELECT employee_id, first_name
FROM employees;
-- 4. employees 테이블에서 사원번호, 이름, 성, 이메일, 전화번호, 입사일자, 급여로 조회
-- AS (alias) :출력되는 컬럼명에 별명을 짓는 명령어
-- * 생략가능
-- AS 사원번호      : 별칭 그대로 작성
-- AS "사원 번호"   : 띄어쓰기가 있으면 ""로 감싸서 작성
-- AS '사원 번호'   : (에러)
SELECT employee_id AS "사원 번호"
,first_name AS 이름
,last_name AS 성
,email AS 이메일
,phone_number 전화번호
,hire_date AS 입사일자
,salary 급여
FROM employees;
-- 모든 컬럼(속성) 조회 : (*) 에스터리크
SELECT *
FROM employees;
-- 5. employees JOB_ID 중복 없이 조회하기
SELECT DISTINCT job_id
FROM employees;
--------------------------------------------------------------------------------
-- WHERE (조건) : ~는, ~인
-- 6. 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM EMPLOYEES
WHERE SALARY > 6000;
-- 7. 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM EMPLOYEES
WHERE SALARY = 10000;
-- ORDER (정렬) BY + 필드 + DESC (내림차순)/ASC (오름차순)/생략 (오름차순 기본값)  
-- 8. 테이블 employees의 모든 속성들을 SALARY 를 기준으로 내림차순 정렬하고,
-- FIRST_NAME 을 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성하시오.
SELECT *
-- SELECT first_name, salary : 해당 필드만 확인
FROM employees
ORDER BY salary DESC, first_name ASC;
-- OR : ~이거나, 또는
-- 9. 테이블 EMPLOYEES 의 JOB_ID 가 'FI_ACCOUNT' 이거나(조건1) 'IT_PROG' 인(조건2)
-- 사원의 모든 칼럼을 조회하는 SQL 문 작성하시오.
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT'
OR job_id = 'IT_PROG'
;
-- IN : 같은 필드 내 있는 데이터 출력
-- 10. 9번과 동일 (단, 조건 : IN 키워드 사용하여 SQL 쿼리 완성하시오.)
SELECT *
FROM EMPLOYEES
WHERE job_id IN ('FI_ACCOUNT', 'IF_PROG')
;
-- NOT IN : 같은 필드 내 있는 키워드가 아닌 것 출력
-- 11. 테이블 EMPLOYEES 의 JOB_ID 가 'FI_ACCOUNT' 이거나(조건1) 'IT_PROG' 아닌(조건2)
-- 사원의 모든 칼럼을 조회하는 SQL 문 작성하시오.
SELECT *
FROM EMPLOYEES
WHERE job_id NOT IN ('FI_ACCOUNT', 'IF_PROG')
;
-- AND : 조건에 해당하는 필드 내 모든 키워드를 출력
-- 12. 테이블 EMPLOYEES 의 JOB_ID가 'IT_PROG' 이면서 SALARY 가 6000 이상인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
AND salary >= 6000
;
-- LIKE '%' : 빈 문자열, 1글자 이상의 문자열 대체
-- LIKE '_' : 1글자 대체
-- 13. 테이블 EMPLOYEES 의 FIRST_NAME이 'S' 로 시작하는
-- 사원의 모든 컬럼을 조회하는 SQL문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE 'S%';
-- 14. 테이블 EMPLOYEES 의 FIRST_NAME 이 's'로 끝나는
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '%s';
-- 15. 테이블 EMPLOYEES 의 FIRST_NAME 에 's' 가 포함되는
-- 사원의 모든 컬럼을 조회하는 SQL문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '%s%';
-- 16. 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 1) LIKE 키워드 사용
SELECT *
FROM employees
WHERE first_name LIKE '_____'; -- 언더바 5개
-- 2) LENGTH()
-- * LENGTH(컬럼명) : 글자 수 반환하는 함수
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;
-- IS NULL : NULL 인 경우
-- 17. 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL인 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NULL;
-- IS NOT NULL : NULL 아닌 경우
-- 18. 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;
-- 19. 테이블 EMPLOYEES의 사원의 HIRE_DATE가 04년 이상인 
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 1) 문자열로 암시적 형변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= '04/01/01';
-- 2) TO_DATE 함수로 형식에 맞춰 문자를 날짜로 변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD');
-- 20. 테이블 EMPLOYEES 의 사원의 HIRE_DATE 가 04년도부터 05년도인(AND)
-- 모든 컬럼을 조회하는 SQL문을 작성하시오.
-- 1) 문자열로 암시적 형변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= '04/01/01'
AND hire_date <= '05/12/31'
;
-- 2) TO_DATE 함수로 형식에 맞춰 문자를 날짜로 변환하여 조회
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD')
AND hire_date <= TO_DATE('05/12/31', 'YY/MM/DD')
;
-- 3) BETWEEN AND 연산으로 조회(~에서 ~까지)
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('04/01/01', 'YY/MM/DD')
AND TO_DATE('05/12/31', 'YY/MM/DD')
;
-----------------------------------------------------------------------------------------------
-- CEIL(인자) : 인자보다 크거나 같은 정수 중 제일 작은 수를 반환하는 정수
-- dual : 산술 연산, 함수 결과 등 확인해볼 수 있는 임시 테이블
-- 21. 12.45, -12.45보다 크거나 같은 정수 중 제일 작은 수를 계산하능 SQL 문을 각각 작성하시오.
SELECT CEIL(12.45), CEIL(-12.45)
FROM dual;
-- 22. 12.55, -12.55보다 작거나 같은 정수 중 제일 큰 수를 계산하능 SQL 문을 각각 작성하시오.
SELECT FLOOR(12.55), FLOOR(-12.55)
FROM dual;
-- ROUND(값, 자리수) : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- 23. 
-- -- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오.
SELECT ROUND(0.54, 0) FROM dual;
-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오.
SELECT ROUND(0.54, 1) FROM dual;
-- 125.67 을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;
-- 125.67 을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;
-- MOD(A, B) : A를 B로 나눈 나머지를 구하는 함수
-- 24. 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL 문을 작성하시오.
-- 3을 8로 나눈 나머지
SELECT MOD(3, 8) FROM dual;
-- 30을 4로 나눈 나머지
SELECT MOD(30, 4) FROM dual;
-- POWER(A, B) : A의 B 제곱을 구하는 함수
-- 25. 각 소문제에 제시된 두 수를 이용하여 제곱수를 구하는 SQL문 작성하시오.
-- 2의 10 제곱
SELECT POWER(2, 10)
FROM dual;
-- 2의 31 제곱
SELECT POWER(2, 31)
FROM dual;
-- SQRT( A ) : A의 제곱근을 구하는 함수 / A는 양의 정수와 실수만 사용 가능
-- 26. 각 소문제에 제시된 두 수를 이요하여 제곱근을 구하는 SQL문 작성하시오.
-- 2의 제곱근을 구하시오.
SELECT SQRT(2)
FROM dual;
-- 100의 제곱근을 구하시오.
SELECT SQRT(100)
FROM dual;
-- TRUNC(실수, 자리수) : 해당 수를 절삭하는 함수
-- 27. 각 소문제에 제시된 수를 절삭하는 SQL문 작성하시오.
-- 527425.1234 소수점 아래 첫째 자리에서 절삭
SELECT TRUNC(527425.1234, 0) FROM dual;
-- 527425.1234 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(527425.1234, 1) FROM dual;
-- 527425.1234 일의 자리에서 절삭
SELECT TRUNC(527425.1234, -1) FROM dual;
-- 527425.1234 십의 자리에서 절삭
SELECT TRUNC(527425.1234, -2) FROM dual;
-- ABS(A) : 값 A의 절대값을 구하여 변환하는 함수
-- 28. 각 소문제에 제시된 수를 이용하여 절대값을 구하는 SQL문을 작성하시오.
-- -20의 절댓값을 구하기
SELECT ABS(-20) FROM dual;
-- -12.456의 절댓값을 구하기
SELECT ABS(-12.456) FROM dual;
-----------------------------------------------------------------------
-- UPPER : 대문자로  변환
-- LOWER : 소문자로 변환
-- INITCAP : 단어를 기준으로 첫글자를 대문자로 변환
-- 참고 : 원문을 보내주고, 클라이언트 측에서 변환하는 경우도 있음
-- 29. 예시 문자열을 대문자, 소문자, 첫글자만 대문자로 변환하는 SQL 문 작성하시오
-- 원문 : 'AlOhA WoRlD~!'
SELECT 'AlOhA WoRlD~!' AS 원문
,UPPER ('AlOhA WoRlD~!') AS 대문자
,LOWER ('AlOhA WoRlD~!') AS 소문자
,INITCAP('AlOhA WoRlD~!') AS "첫 글자만 대문자"
FROM dual;
-- LENGTH : 글자 수 반환
-- LENGTHB : 바이트 수 반환
-- 주의 : 영문(1byte)로 똑같은 처리 / 한글(3byte) 처리로 글자 수와 바이트 수가 다름
-- 30. 문자열의 글자 수와 바이트 수를 출력하는 SQL문 작성하시오.
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;
SELECT LENGTH('알로하 월드') AS "글자 수"
,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;
-- CONCAT (함수) : 2개의 문자열 (그 이상x) 연결하여 반환하는 함수
-- || (기호) : 2개 이상 문자열은 기호가 더 간결함
-- 31. 각각 함수와 기호를 이용하여 두 문자열을 병합하여(연결) 출력하는 SQL문 작성하시오.
SELECT CONCAT('ALOHA', 'WORLD') AS 함수로
, 'ALOHA' || 'WORLD' AS 기호
FROM dual;
-- SUMSTR (문자열, 시작번호, 글자수) : 시작번호부터 지정한 글자 수만큼의 문자열 추출 후 반환
-- SUMSTRB (문자열, 시작번호, 바이트수) : 시작번호부터 지정한 바이트 수만큼의 문자열 추출 후 반환
-- 주의 : 영문과 한글 BYTE 차이가 있으므로 바이트 출력은 차이 있음
-- 32. 주어진 문자열의 일부만 출력하는 SQL문 작성하시오.
-- 'www.alohaclass.kr'
SELECT SUBSTR('www.alohaclass.kr', 1, 3) AS "1"
,SUBSTR('www.alohaclass.kr', 5, 10) AS "2"
,SUBSTR('www.alohaclass.kr', -2, 2) AS "3"
FROM dual;
SELECT SUBSTRB('www.alohaclass.kr', 1, 3) AS "1"
,SUBSTRB('www.alohaclass.kr', 5, 10) AS "2"
,SUBSTRB('www.alohaclass.kr', -2, 2) AS "3"
FROM dual;
SELECT SUBSTR('www.알로하클래스.com', 1, 3) AS "1"
,SUBSTR('www.알로하클래스.com', 5, 6) AS "2"
,SUBSTR('www.알로하클래스.com', -3, 3) AS "3"
FROM dual;
SELECT SUBSTRB('www.알로하클래스.com', 1, 3) AS "1"
,SUBSTRB('www.알로하클래스.com', 5, 18) AS "2"
,SUBSTRB('www.알로하클래스.com', -3, 3) AS "3"
FROM dual;
-- INSTR (문자열, 문자, 시작번호, 순서) : 지정한 시작번호부터, 문자를 찾아서, 지정한 순서에서 있는, 문자의 위치 반환
-- INSTRB (문자열, 문자, 시작번호, 순서) : 지정한 시작번호부터, 문자를 찾아서, 지정한 순서에서 있는, 문자의 위치, 바이트 반환
-- 33. 문자열에서 특정 문자의 위치를 구하는 SQL 문을 작성하시오.
-- 'ALOHA WORLD'
SELECT INSTR('ALOHA WORLD', 'A', 1, 1) AS "1번째 A"
,INSTR('ALOHA WORLD', 'A', 1, 2) AS "2번째 A"
,INSTR('ALOHA WORLD', 'A', 1, 3) AS "3번째 A"
,INSTR('ALOHA WORLD', 'A', 1, 4) AS "4번째 A"
FROM dual;
-- LPAD(문자열, 칸, 문자) : 왼쪽 빈공간을, 특정문자로 채우는 함수
-- RPAD(문자열, 칸, 문자) : 오른쪽 빈공간을, 특정문자로 채우는 함수
-- 34. 문자열을 왼쪽/오른쪽에 출력하고 빈공간을 특정 문자로 채우는 SQL문 작성하시오.
SELECT LPAD('ALOHACLASS', 20, '#') AS 왼쪽
,RPAD('ALOHACLASS', 20, '#') AS 오른쪽
FROM dual;
-- EX) 주민등록번호 뒷자리 첫자리를 제외한 나머지 문장을 *로 마스킹하시오.
SELECT RPAD( SUBSTR('020905-3123456', 1, 8), 14, '*' ) 주민번호
FROM dual;
------------------------------------------------------------------------------------------
-- TO_CHAR( 데이터, '날짜/숫자 형식' )
-- : 특정 데이터를 문자열 형식으로 변환하는 함수
-- 35. 테이블 EMPLOYEES 의 FIRST_NAME 과 HIRE_DATE 를 검색하되 
-- 날짜 형식을 지정한 SQL 문을 작성하시오.
-- (HIRE_DATE 입사일자를 날짜형식을 지정하여 출력하시오.)
-- 형식 : 2024-03-04 (월) 12:34:56
SELECT first_name AS 이름
,TO_CHAR(hire_date, 'YYYY-MM-DD (DY) HH:MI:SS' ) AS 입사일자
,hire_date
FROM employees;
-- 36. 테이블 EMPLOYEES 의 FIRST_NAME 과 SALARY 를 검색하되
-- 날짜 형식을 지정하는 SQL문을 작성하시오.
-- (SALARY 급여를 통화형식으로 지정하여 출력하시오.)
SELECT first_name AS 이름
,TO_CHAR(salary, '$999,999,999' ) AS 급여
,salary
FROM employees;
-- TO_DATE( 데이터 ) : 문자형 데이터를 날짜형 데이터로 변환하는 함수
-- 37. 문자형으로 주어진 데이터를 날짜형 데이터로 변환하는 SQL문 작성하시오.
SELECT '20251114' 문자
,TO_DATE('20251114','YYYYMMDD') AS 날짜1
,TO_DATE('2025/11/14','YYYY/MM/DD') AS 날짜2
,TO_DATE('2025-11-14','YYYY-MM-DD') AS 날짜3
,TO_DATE('2025.11.14','YYYY.MM.DD') AS 날짜4
FROM dual;
-- TO_NUMBER( 데이터 ) : 문자형 데이터를 숫자형 데이터로 변환하는 함수
-- 38. 문자형으로 주어진 데이터를 숫자형 데이터로 변환하는 SQL 문 작성하시오.
-- 주의! 숫자만 있어야 함(기호 같은 것x)
SELECT '1,200,000' 문자
,TO_NUMBER('1,200,000','999,999,999') AS 숫자
FROM dual;
--------------------------------------------------------------------------------
-- sysdate : 현재 날짜/시간 정보를 가지고 있는 키워드
-- 39. 현재 날짜를 반환하는 SQL문 작성하시오.
-- (어제, 오늘, 내일 을 출력하시오.)
-- 2023/05/22 - YYYY/MM/DD 형식으로 출력
-- 날짜 데이터 --> 문자 데이터 변환
SELECT sysdate FROM dual;
SELECT sysdate-1 AS 어제
,sysdate AS 오늘
,sysdate+1 AS 내일
FROM dual;
-- MONTHS_BETWEEN (날짜1, 날짜2) : 날짜1부터 날짜2 사이의 개월 수반환
-- 주의! --   (단, A > B 즉, A가 더 최근 날짜로 지정해야 양수로 반환)
-- TRUNC : 날짜 데이터를 절삭하여 반환하는 함수
-- 40. 입사일자와 오늘 날짜를 계산하여 근무달수와 근속연수를 구하는 SQL 작성하시오.
SELECT first_name 이름
,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
,TO_CHAR(sysdate, 'YYYY.MM.DD') 오늘
,TRUNC ( MONTHS_BETWEEN( sysdate, hire_date ) ) || '개월' 근무달수
,TRUNC ( MONTHS_BETWEEN( sysdate, hire_date ) / 12) || '년' 근속연수
FROM employees;
-- ADD_MONTHS( 날짜, 개월 수 ) : 지정한 날짜로부터 해당 개월 수를 후의 날짜 반환
-- 41. 오늘 날짜와 6개월 후의 날짜를 출력하는 SQL 문 작성하시오.
SELECT sysdate 오늘
,ADD_MONTHS(sysdate, 6) "6개월 후"
,ADD_MONTHS(sysdate, -6) "6개월 전"
FROM dual;
SELECT '2025/10/20' 개강
,ADD_MONTHS('2025/10/20', 6) 종강
FROM dual;
-- NEXT_DAY  : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일 월 화 수 목 금 토
-- 1  2  3  4  5 6  7
-- 42. 오늘 날짜와 오늘 이후 돌아오는 토요일의 날짜를 출력하는 SQL 문 작성하시오
SELECT sysdate 오늘
, NEXT_DAY( sysdate, 7) "다음 토요일"
FROM dual;
-- 월초 : TRUNC( 날짜, 'MM' )
-- 월말 : LAST_DAY( 날짜 )
/*
      날짜 데이터 : XXXXXXX.YYYYYYYY
      1970년1월1일 00시00분00초00ms
      지난 일자를 정수로 계산, 시간 정보는 소수부분으로 계산
      TRUNC( XXXXXXX.YYYYYYYY ) --> XXXXXXX
      정수 부분인 년월일만 남는다.
      마찬가지로, 월 단위를 기준으로 절삭하면 월초를 구할 수 있다.
*/
-- 43. 오늘 날짜와 월초, 월말 일자를 구하는 SQL 문 작성하시오.
SELECT TRUNC( sysdate, 'MM' ) 월초
,sysdate 오늘
,LAST_DAY( sysdate ) 월말
FROM dual;
-- DISTINCT : 중복 없이 조회
-- NVL( 값, 대체할 값 ) : 해당 값이 NULL 이면 지정된 값으로 변환하는 함수
-- 44. 테이블 employees 의 COMMISSION_PCT를 중복없이 검색하되, 
-- NULL이면 0으로 조회하고 내림차순으로 정렬하는 SQL문을 작성하시오.
SELECT DISTINCT NVL(COMMISSION_PCT, 0)
FROM employees
-- SELECT 옆에 지정한 컬럼을 사용하지 않으면 오류!
-- 주의! ORDER BY 의 정렬기준 컬럼은, SELECT 에서 선택한 컬럼만 사용 가능
-- ORDER BY COMMISSION_PCT DESC
ORDER BY NVL(COMMISSION_PCT, 0) DESC
;
-- 코드가 너무 길다? 별칭을 줘라!
SELECT DISTINCT NVL(COMMISSION_PCT, 0) "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC
;
/*
  SELECT 컬럼
  FROM 테이블
  WHERE 조건
  GROUP BY 그룹기준
  ORDER BY 정렬기준

  * SELEFT 실행순서
  - FROM ➡️ WHERE ➡️ GROUP BY ➡️ HAVING ➡️ SELECT ➡️ ORDER BY
  1. 테이블을 선택한다
  2. 조건에 맞는 데이터를 선택한다
  3. 그룹기준을 지정한다
  4. 그룹별로 그룹조건에 맞는 데이터를 선택한다
  5. 조회할 컬럼을 선택한다
  6. 조회된 결과를 정렬기준에 따라 정렬
*/
-- * NVL2( 값, NULL 아닐 때 값, NULL 일 때 값 )
-- * NULL 과 값을 연산한 결과는 NULL!
-- 45. 테이블 EMPLOYEES의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여
-- SQL 문 작성하시오. (최종급여를 기준으로 내림차순 정렬)
-- * 최종급여 = 급여 + (급여 * 커미션)
 SELECT first_name 이름
 ,salary 급여
 ,commission_pct
 ,commission_pct 커미션
 ,(salary + ( salary * commission_pct)) 최종급여
 FROM employees
 ;
-- null인 사람 모두 null로 나옴
-- 해결방법
 SELECT first_name 이름
 ,salary 급여
 ,commission_pct
 ,NVL(commission_pct, 0) 커미션
 ,NVL2(commission_pct, salary + ( salary * commission_pct), salary) 최종급여
-- commission_pct null 나와도 최종급여 출력
 FROM employees
 ;
  SELECT first_name 이름
 ,salary 급여
 ,commission_pct
 ,NVL(commission_pct, 0) 커미션
 ,salary + NVL2(commission_pct, ( salary * commission_pct), 0) 최종급여
 FROM employees
 ;
-- * COALESCE(인자 여러 개) : 인자들 중 NULL 이 아닌 첫번째 값 반환
-- EMPLOYEES 테이블에서 직원의 이메일이 NULL 이면, 전화번호(PHONE_NUMBER)를,
-- 전화번호도 NULL 이면, 이름 (FIRST_NAME) 을 출력하시오.
 SELECT employee_id
 , COALESCE(email, phone_number, first_name) 연락처
 FROM employees;
-- * LNNVL : 조건식의 결과 TRUE -> FALSE / NULL, FALSE -> TRUE 반환
-- EMPLOYEES 테이블에서 커미션이 0.2 이상이 아닌 직원을 조회하시오.
SELECT employees_id, commission_pct
FROM employees
WHERE LNNVL(commission_pct >= 0.2)
;
-- 차이점 : LNNVL 아닌 경우 0.2 이상인 경우에 해당
-- 만약 부등호를 < 로 바꾼다면 NULL 은 제외 (조건에 해당되지 않는다고 판단)
-- 즉, (단, 커미션이 없는 직원도 포함) 이 붙는다면 NULL 이 포함되어야 함
-- 즉, 단순 계산이라면 부등호만 사용해도 되지만, NULL 이 포함되어 있디먄 LNNVL 필요
SELECT employees_id, commission_pct
FROM employees
WHERE commission_pct >= 0.2
-- 엥 오류남.. 다시 영상보고 확인해봐..
;
-- * NULLIF
-- EMPLOYEES 테이블의 커미션이 있는 사원만 출력하시오.
-- (최종 급여와 급여가 같으면 : 커미션 없음)
-- (최종 급여와 급여가 다르있 : 커미션 없음)
SELECT first_name
,(salary + (salary*commission_pct)) 최종급여
FROM employees
WHERE NULLIF( (salary + (salary*commission_pct)), salary ) IS NOT NULL
;
--------------------------------------------------------------------------
-- DECODE (컬럼명, 조건값1, 반환값1, 조건값2, 반환값2, ...)
-- : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤의 반환값을 출력하는 함수
-- 46. 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 SQL문 작성하시오.
-- (사원의 이름과 부서명을 출력하시오.)
-- 사원 테이블  : department_id (부서번호)
SELECT first_name 이름
,department_id 부서번호
,DECODE( department_id, 10, 'Administration',
20, 'Marketing',
30, 'Purchasing',
40, 'HUman Resources',
50, 'Shipping',
60, 'IT',
'부서없음'
) 부서
FROM employees;
SELECT *
FROM departments
;
-- CASE문 : 특정 조건에 따라 반환할 데이터를 설정하는 조건문
-- 47. 46번과 동일
SELECT first_name 이름
,department_id 부서번호
,CASE 
WHEN department_id = 10 THEN 'Administration'
WHEN department_id = 20 THEN 'Marketing'
WHEN department_id = 30 THEN 'Purchasing'
WHEN department_id = 40 THEN 'Human Resources'
WHEN department_id = 50 THEN 'Shipping'
WHEN department_id = 60 THEN 'IT'
ELSE '부서없음'
END 부서
FROM employees;
-- GREATEST / LEAST
-- employees 테이블에서 사원의
-- 최종 급여, 급여, 보너스25% 중 가장 큰 값과
-- 최종 급여, 급여, 보너스25% 중 가장 작은 값을 출력하시오
SELECT first_name
  ,GREATEST((salary + (salary*NVL(commission_pct, 0))), salary, (salary + (salary*0.25))) 최대
  ,LEAST((salary + (salary*NVL(commission_pct, 0))), salary, (salary + (salary*0.25))) 최소
FROM employees;
-------------------------------------------------------------------

-- 48. 
-- 쉬는 시간 틈틈히 정리
-- 64번까지
-------------------------------------------------------------------
-- CHECK : 
-- 65. MS_STUDENT 테이블의 성별(gender) 속성에 대하여,
-- ('여', '남', '기타') 값만 입력가능하도록 제약조건을 추가하시오.
-- 쉬는 시간에 알로하 만들기 ms_student도...?(있는건가없음.. 데이터 안나옴..)
-- 일단 코드 작성하기..
ALTER TABLE MS_STUDENT
MODIFY GENDER CHECK (GENDER IN ('여','남','기타'));

ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_GENDER_CHECK
CHECK (GENDER IN ('여','남','기타'));

SELECT * FROM MS_STUDENT;

UPDATE MS_STUDENT
-- SET GENDER = '?' (범위 안에 있는 데이터가 아님)
-- 오류 (ORA-02290) : 체크 제약조건이 위배되었습니다. 
-- 도메인 무결성 보장
-- CHECK 조건으로 지정한 값이 아닌 다른 값을 입력/수정하는 경우
-- 데이터가 적용되지 않도록 제약합니다.
SET GENDER = '여'
WHERE ST_NO = '20240001';
--
-- 66~69.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블을 테이블 정의서에 따라 생성해보세요.
-- 첫번째 (ATTRIBUTE) 두번쨰 (DATE TYPE) 세번째 (NOT NULL) 네번째 (KEY / PRI, UNI) 다섯번째(DEFAULT / sysdate) 마지막 (DESCRIPTION)
CREATE TABLE MS_USER (
    USER_NO   NUMBER        NOT NULL PRIMARY KEY, -- SEQUENCE 시퀀스 (1번부터 증가하는 값 넣기)
    USER_ID   VARCHAR2(100) NOT NULL UNIQUE,
    USER_PW   VARCHAR2(200) NOT NULL,
    USER_NAME VARCHAR2(200) NOT NULL,
    BIRTH     DATE          NOT NULL,
    TEL       VARCHAR2(20)  UNIQUE,
    ADDRESS   VARCHAR2(200) NULL,
    REG_DATE  DATE  DEFAULT sysdate NOT NULL,
    UPD_DATE  DATE  DEFAULT sysdate NOT NULL
);

CREATE TABLE MS_BOARD (
  BOARD_NO NUMBER        NOT NULL PRIMARY KEY, 
  TITLE    VARCHAR2(200) NOT NULL,
  CONTENT  CLOB          NOT NULL,
  WRITER   VARCHAR2(100) NOT NULL,
  HIT      NUMBER        NOT NULL,
  LIKE_CNT NUMBER        NOT NULL,
  DEL_YN   CHAR(2)       NULL,
  DEL_DATE DATE          NULL,
  REG_DATE DATE DEFAULT sysdate NOT NULL, 
  UPD_DATE DATE DEFAULT sysdate NOT NULL
);

CREATE TABLE MS_FILE (
  FILE_NO   NUMBER         NOT NULL PRIMARY KEY,
  BOARD_NO  NUMBER         NOT NULL,
  FILE_NAME VARCHAR2(2000) NOT NULL,
  FILE_DATA BLOB           NOT NULL,
  REG_DATE  DATE DEFAULT sysdate NOT NULL, 
  UPD_DATE  DATE DEFAULT sysdate NOT NULL
);

CREATE TABLE MS_REPLY (
  REPLY_NO NUMBER         NOT NULL PRIMARY KEY,
  BOARD_NO NUMBER         NOT NULL,
  CONTENT  VARCHAR2(2000) NOT NULL,
  WRITER   VARCHAR2(100)  NOT NULL,
  DEL_YN   CHAR(2)        NULL,
  DEL_DATE DATE           NULL,
  REG_DATE DATE DEFAULT sysdate NOT NULL, 
  UPD_DATE DATE DEFAULT sysdate NOT NULL
);
------------------------------------------------------------------------------
-- 72. 테이블 MS_BOARD 에서 WRITER 속성을 아래 같이 데이터 타입을 변경하고,
-- 테이블 MS_USER 의 USER_NO를 참조하는 외래키로 지정하는 SQL 작성하시오.

-- 1) 데이터 타입 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입;
ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;

-- 외래키 지정
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY (외래키컬럼) REFERENCES 참조테이블(기본키);

-- MS_BOARD(WRITER) ----> MS_USER(USER_NO)
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO);

-- 2) 외래키 지정 : MS_FILE ( BOARD_NO ) ----> MS_BOARD (BOARD_NO)
-- MS_FILE 테이블의 BOARD_NO 를 외래키로 지정하여
-- MS_BOARD 테이블의 BOARD_NO 를 참조하도록 지정
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 3) 외래키 : MS_REPLY (BOARD_NO)  ---->  MS_BOARD (BOARD_NO)
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 제약조건 삭제
-- ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE MS_BOARD DROP CONSTRAINT MS_BOARD_WRITER_FK;
ALTER TABLE MS_FILE DROP CONSTRAINT MS_FILE_BOARD_NO_FK;
ALTER TABLE MS_REPLY DROP CONSTRAINT MS_REPLY_BOARD_NO_FK;

-- 73. MS_USER 테이블에 속성을 추가하시오.
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

-- 이후 작성 못함.

-- 74. MS_USER 의 GENDER 속성이 ('여', '남', '기타') 값만 갖도록 제약조건을 추가하시오.
-- CHECK 제약조건 추가
ALTER TABLE MS_USER
ADD CONSTRAINT MS_USER_GENDER_CHECK
CHECK (GENDER IN ('여', '남', '기타'));

-- 75. MS_FILE 테이블에 확장자(EXT) 속성을 추가하시오.
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';

-- MERGE : 두 테이블 병합할 때 사용 
-- -> 응용 : 한 테이블 가지고 조건이 맞는 상황일 때 아래 코드 작업
-- 76. 테이블 MS_FILE 의 FILE_NAME 속성에서 확장자를 추출하여 
-- EXT 속성에 UPDATE 하는 SQL 문을 작성하시오.
MERGE INTO MS_FILE T    -- 대상 테이블 지정 MERGE
-- 사용할 테이블 지정 USING
USING ( SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F
-- 매치 조건 ON -> NO : 번호
ON ( T.FILE_NO = F.FILE_NO )
-- 조건 성립 시 실행 WHEN
WHEN MATCHED THEN
  UPDATE SET T.EXT = SUBSTR( F.FILE_NAME, INSTR (F.FILE_NAME, '.', -1) + 1) -- 파일명.PNG -> -1 맨뒤에 있는 . / +1 그 다음 PNG
  DELETE WHERE LOWER( SUBSTR( F.FILE_NAME, INSTR (F.FILE_NAME, '.', -1) + 1))
              NOT IN ('jpeg', 'jpg', 'gif', 'png', 'webp')
  -- WHEN NOT MATCHED THEN
;
---------------------------------------------------------------------
SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;

DELETE FROM MS_FILE;

-- 파일 추가
INSERT INTO MS_FILE (
    FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
  )
VALUES (1, 1, '강아지.png', '123', sysdate, sysdate, 'jpg');

INSERT INTO MS_FILE (
    FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
  )
VALUES (2, 1, '신청서.pdf', '123', sysdate, sysdate, 'pdf');

-- 게시글 추가
INSERT INTO MS_BOARD (
    BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
    DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
)
VALUES (
  1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
);

-- 유저 추가
INSERT INTO MS_USER (
    USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
    TEL, ADDRESS, REG_DATE, UPD_DATE,
    CTZ_NO, GENDER
)
VALUES (1, 'ALOHA', '123456', '김조은', TO_DATE('2003/01/01', 'YYYY/MM/DD'),
  '010-1234-1234','부평', sysdate, sysdate,
  '030101-3334444','기타');
-------------------------------------------------------------------------
-- 77. 테이블 MS_FILE 의 EXT 속성이
-- ('jpg', 'jpeg', 'gif', 'png', 'webp') 값을 갖도록 하는 제약조건을 추가하시오.
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_EXT_CHECK
CHECK ( EXT IN ('jpg', 'jpeg', 'gif', 'png','webp'));

-- 제약조건 삭제
ALTER TABLE MS_FILE
DROP CONSTRAINT MS_FILE_EXT_CHECK;

SELECT * FROM MS_FILE;

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_date, reg_date, upd_date, ext)
VALUES
(3, 1, '고양이.webp', '123', '2025/11/17', '2025/11/17', 'webp');

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_date, reg_date, upd_date, ext)
VALUES
(4, 1, '문서.pdf', '123', '2025/11/17', '2025/11/17', 'pdf');

-- DELETE vs TRUNCATE
-- * DELETE - 데이터 조작어(DML)
-- - 한 행 단위로 데이터를 삭제한다.
-- - WHERE 조건절을 기준으로 일부 삭제 가능.
-- - COMMIT, ROLLBACK 을 이용하여 변경사항을 
--   적용하거나 되돌릴 수 있음.
-- * TRUNCATE - 데이터 정의어(DDL)
-- - 모든 행을 삭제한다.
-- - 삭제된 데이터를 되돌릴 수 없음
-- 78.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블의
-- 모든 데이터를 삭제하는 명령어를 작성하시오.
-- DDL - TRUNCATE
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;
-- DML - DELETE
DELETE FROM MS_USER;
DELETE FROM MS_BOARD;
DELETE FROM MS_FILE;
DELETE FROM MS_REPLY;
-- 79.
-- 테이블의 속성을 삭제하시오.
-- * MS_BOARD 테이블의 WRITER 속성
-- * MS_FILE 테이블의 BOARD_NO 속성
-- * MS_REPLY 테이블의 BOARD_NO 속성
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;
-- 80.
-- 각 테이블에 속성들을 추가한 뒤, 외래키로 지정하시오.
-- 해당 외래키에 대하여 참조 테이블의 데이터 삭제 시,
-- 연결된 속성의 값도 삭제하는 옵션도 지정하시오.
-- 1) MS_BOARD 에  WRITER 속성 추가
ALTER TABLE MS_BOARD ADD  WRITER NUMBER NOT NULL;
-- WRITER 속성을 외래키로 지정
ALTER TABLE MS_BOARD
ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO)
-- 참조 테이블 데이터 삭제 시, 연쇄적으로(CASCADE) 삭제하는 옵션 지정
    ON DELETE CASCADE 
;
-- 예시 ) 회원 탈퇴 시 해당 회원에 대한 모든 정보가 지워지는 것
-- 즉, 참조되어 있는 데이터를 연쇄적으로 삭제

-- ** 외래키가 참조하는 참조컬럼의 데이터 삭제 시, 동작할 옵션 지정
-- ON DELETE [NO ACTION, RESTRICT, CASCADE, SET NULL]
-- * NO ACTION      :   아무 행위도 안 함.
-- * RESTRICT       :   자식 테이블의 데이터가 존재하면, 삭제 안 함.
-- * CASCADE        :   자식 테이블의 데이터도 함께 삭제 
-- * SET NULL       :   자식 테이블의 데이터를 NULL 로 지정

-- 2) MS_FILE 에 BOARD_NO 속성 추가
ALTER TABLE MS_FILE ADD  BOARD_NO NUMBER NOT NULL;
-- BOARD_NO 속성을 외래키로 지정 (+연쇄 삭제)
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
    ON DELETE CASCADE
;    
-- 3) MS_REPLY 에 BOARD_NO 속성 추가
ALTER TABLE MS_REPLY ADD  BOARD_NO NUMBER NOT NULL;
-- BOARD_NO 속성을 외래키로 지정 (+연쇄 삭제)
ALTER TABLE MS_REPLY
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
    ON DELETE CASCADE
;

-- 데이터 추가
-- 유저 추가
INSERT INTO MS_USER(
                USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
                TEL, ADDRESS, REG_DATE, UPD_DATE,
                CTZ_NO, GENDER
                )
VALUES ( 1, 'ALOHA', '123456', '김조은', TO_DATE('2003/01/01', 'YYYY/MM/DD'),
         '010-1234-1234', '부평', sysdate, sysdate,
         '030101-3334444', '기타');
-- 게시글 추가
INSERT INTO MS_BOARD (
                BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
                DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
                )
VALUES (
        1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
        );
-- 댓글 추가
INSERT INTO MS_REPLY ( REPLY_NO,  CONTENT, WRITER, DEL_YN, REG_DATE, UPD_DATE, BOARD_NO )
VALUES (1, '댓글내용', '김조은', 'N', '2024/09/05', '2024/09/05', 1);
-- 파일 추가
INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (1, 1, '강아지.png', '123', sysdate, sysdate, 'jpg' );

INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (2, 1, 'main.html', '123', sysdate, sysdate, 'jpg' );

DELETE FROM MS_USER WHERE USER_NO = 1;
-----------------------------------------------------------------------------------


