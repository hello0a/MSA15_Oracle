-- 프로시저
-- 생성
CREATE OR REPLACE PROCEDURE pro_print
IS  -- 선언부
    V_A NUMBER := 10;
    V_B NUMBER := 20;
    V_C NUMBER;
BEGIN
    -- 실행부
    V_C := V_A + V_B;
    DBMS_OUTPUT.PUT_LINE('V_C : ' || V_C);
END;
/

-- 출력 활성화(DBMS_OUTPUT.PUT_LINE)
SET SERVEROUTPUT ON;

-- 실행
EXECUTE pro_print();

-- 프로시저 (파라미터 사용)
-- 파라미터 : 사원번호, 제목, 내용
-- board 테이블에 사원명으로 글쓰기를 하는 프로시저
-- DDL
DROP TABLE board;
CREATE TABLE board (
  no NUMBER NOT NULL PRIMARY KEY,
  title varchar2(100) NOT NULL,
  writer varchar2(100) NOT NULL,
  content varchar2(1000),
  reg_date DATE DEFAULT sysdate NOT NULL,
  upd_date DATE  DEFAULT sysdate NOT NULL,
  views NUMBER  DEFAULT 0 NOT NULL
);
-- 시퀀스
DROP SEQUENCE SEQ_BOARD;
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1                  -- 증가값
START WITH 1                    -- 시작값
MINVALUE 1                      -- 최솟값
MAXVALUE 1000000;               -- 최댓값

-- 프로시저
CREATE OR REPLACE PROCEDURE pro_emp_write
(
    --파라미터
    IN_EMP_ID IN employee.emp_id%TYPE,
    IN_TITLE IN VARCHAR2 DEFAULT '제목없음',
    IN_CONTENT IN VARCHAR2 DEFAULT '내용없음'
)
IS
    --선언부
    V_EMP_NAME employee.emp_name%TYPE;
BEGIN
    --사원명 조회
    SELECT emp_name INTO V_EMP_NAME
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    -- 글등록
    INSERT INTO board(no, title, writer, content)
    VALUES (SEQ_BOARD.nextval, IN_TITLE, V_EMP_NAME, IN_CONTENT);
END;
/

-- 프로시저 실행
EXECUTE pro_emp_write('200', '제목', '내용');
EXECUTE pro_emp_write('200');

SELECT * FROM board;
---------------------------------------------------------------

-- 프로시저 + 조건문
-- 사원의 업무 이력을 갱신하는 프로시저
CREATE OR REPLACE PROCEDURE pro_app_emp(
    -- 파라미터
    IN_EMP_ID IN employees.employee_id%TYPE, -- 사원번호
    IN_JOB_ID IN jobs.job_id%TYPE,          -- 직무ID
    IN_STD_DATE IN DATE,    -- 직무 시작일
    IN_END_DATE IN DATE    -- 직무 종료일
)
IS
    -- 선언부
    V_DEPT_ID employees.department_id%TYPE;  -- 부서번호
    V_CNT NUMBER := 0;      -- 업무이력 개수
BEGIN
    -- 실행부
    -- 1. 사원정보 조회
    SELECT department_id INTO V_DEPT_ID
    FROM employees
    WHERE employee_id = IN_EMP_ID;

    -- 사원 테이블의 JOB_ID 수정
    -- AC_MGR -> FI_MGR
    UPDATE employees
        SET job_id = IN_JOB_ID
    WHERE employee_id = IN_EMP_ID;

    -- 3. 직무이력 테이블(job_history) 갱신
    -- 현재 날짜에 포함되는 직무이력 확인 : 기존직무
    SELECT COUNT(*) INTO V_CNT
    FROM job_history
    WHERE sysdate BETWEEN start_date AND end_date
        AND employee_id = IN_EMP_ID;
    DBMS_OUTPUT.PUT_LINE('기존직무 개수 : ' || V_CNT);

    -- 해당기간에
    -- 직무 이력이 없으면, 새로 추가
    IF V_CNT = 0 THEN
        INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES (IN_EMP_ID, IN_STD_DATE, IN_END_DATE, IN_JOB_ID, V_DEPT_ID);
    -- 직무 이력이 있으면, 시작일 종료일 변경
    ELSE
        UPDATE JOB_HISTORY
            SET start_date = IN_STD_DATE
                ,end_date = IN_END_DATE
                ,job_id = IN_JOB_ID
        WHERE employee_id = IN_EMP_ID;
    END IF;
END;
/
-- 프로시저 실행
EXECUTE pro_app_emp ('200', 'IT_PROG','2025/11/20','2026/11/20');

EXECUTE pro_app_emp ('103', 'AC_MGR','2025/11/20','2026/11/20');
EXECUTE pro_app_emp ('103', 'IT_PROG','2027/01/01','2028/12/31');
EXECUTE pro_app_emp ('103', 'SA_MAN','2028/01/01','2030/12/31');

SELECT *
FROM job_history
WHERE employee_id = 103
ORDER BY start_date ASC;

-- OUT 파라미터로 프로시저 사용하기
CREATE OR REPLACE PROCEDURE pro_out_emp (
    IN_EMP_ID IN employee.emp_id%TYPE,
    OUT_RESULT_STR OUT CLOB
)
IS
    V_EMP employee%ROWTYPE;
    -- %ROWTYPE
    -- : 해당 테이블 또는 뷰의 컬럼들을 참조타입으로 선언
BEGIN
    SELECT * INTO V_EMP
    FROM EMPLOYEE
    WHERE emp_id = IN_EMP_ID;

    OUT_RESULT_STR := V_EMP.emp_id
                        || '/' || V_EMP.emp_name
                        || '/' || V_EMP.salary;
END;
/

-- OUT 파라미터가 있는 프로시저 사용하기
DECLARE
    out_result_str CLOB;
BEGIN
    pro_out_emp('200', out_result_str);
    DBMS_OUTPUT.PUT_LINE(out_result_str);
END;
/

-- 함수는 반환값 1개
-- 프로시전 out 파라미터 여러개 반환
-- 프로시저 OUT 파라미터 2개 이상 사용하기
CREATE OR REPLACE PROCEDURE pro_out_mul(
    IN_EMP_ID IN employee.emp_id%TYPE,
    OUT_DEPT_CODE OUT employee.dept_code%TYPE,
    OUT_JOB_CODE OUT employee.job_code%TYPE
)
IS
    V_EMP employee%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP
    FROM EMPLOYEE
    WHERE emp_id = IN_EMP_ID;

    OUT_DEPT_CODE := V_EMP.dept_code;
    OUT_JOB_CODE := V_EMP.job_code;
END;
/

-- 프로시저 호출
-- 1) 파라미터가 없거나, IN 매개변수 만 : EXECUTE 프로시저명(인자1, 인자2);
-- 2) OUT 파라미터 : PL/SQL블록 안에서 호출 

-- OUT 파라미터가 있어서, 블록 안에서 호출해야함
-- EXECUTE pro_out_mul(1, 2, 3);
DECLARE
    out_dept_code employee.dept_code%TYPE;
    out_job_code employee.job_code%TYPE;
BEGIN
    pro_out_mul('200', out_dept_code, out_job_code);
    DBMS_OUTPUT.PUT_LINE(out_dept_code);
    DBMS_OUTPUT.PUT_LINE(out_job_code);
END;
/
-- 프로시저 예외처리
CREATE OR REPLACE PROCEDURE pro_print_emp (
    IN_EMP_ID IN employee.emp_id%TYPE
)
IS  
    STR_EMP_INFO CLOB;
    V_EMP employee%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    -- CHR(10) : 줄바꿈(엔터)
    STR_EMP_INFO := '사원정보' || CHR(10) ||
                    '사원명 : ' || V_EMP.emp_name || CHR(10) || 
                    '이메일 : ' || V_EMP.email || CHR(10) ||
                    '전화번호 : ' || V_EMP.phone;
    DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);
    -- 예외처리부
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            STR_EMP_INFO := '존재하지 않는 사원ID 입니다.';
            DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);
END;
/

EXECUTE pro_print_emp( '200');
-- 존재하지 않는 사원번호(예외발생)
EXECUTE pro_print_emp('9999');
