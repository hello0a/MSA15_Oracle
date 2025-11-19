-- 덤프 파일 : 팀 프로젝트 시 서로 각자 다른 데이터를 공유하는 것
-- 70. 주어진 "community.dmp" 덤프파일을 'JOEUN' 계정에
-- import 하는 명령어 작성하시오
-- 계정이 없다면, 생성하여 권한을 부여하시오.

-- 1. 계정 생성
-- C## 접두사 없이도 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- 계정 생성
CREATE USER joeun IDENTIFIED BY 123456;
-- 테이블 스페이스 지정
ALTER USER joeun DEFAULT TABLESPACE users;
-- 용량 설정
ALTER USER joeun QUOTA UNLIMITED ON users;
-- 권한 부여
GRANT DBA TO joeun;

-- 2. 덤프 파일 가져오기 (CMD에서 실행)
-- 덤프 파일 import 하기
-- imp userid=관리자계정/비밀번호 file=덤프파일 경로 fromuser=덤프소유계정 touser=임포트할계정
-- 새 파일 가져오면 cmd 입력 후 새로고침하기
imp userid=system/123456 file=C:\AYA14\Oracle\실습\SQL\03.덤프\community.dmp fromuser=joeun touser=joeun
imp userid=system/123456 file=C:\AYA14\Oracle\실습\SQL\03.덤프\joeun.dmp fromuser=joeun touser=joeun

-- 3. 덤프 파일 내보내기
-- joeun 계정의 데이터를 덤프파일로 export 하기
-- exp userid=덤프할계정/비밀번호 file='경로\덤프파일명.dmp' log='경로\로그파일명.log'
exp userid=joeun/123456 ^
file='C:\AYA14\Oracle\실습\SQL\03.덤프\joeun.dmp' ^
log='C:\AYA14\Oracle\실습\SQL\03.덤프\joeun.log'
----------------------------------------------------------------------
