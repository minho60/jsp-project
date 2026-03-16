-- DB 생성
CREATE DATABASE dodram_db
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

-- 사용자 생성
CREATE USER 'dodram_app'@'%' IDENTIFIED BY '비밀번호';

-- 사용자 권한 부여
GRANT ALL PRIVILEGES ON dodram_db.* TO 'dodram_app'@'%';

-- 권한 적용
FLUSH PRIVILEGES;

-- DB 선택
use dodram_db;

-- DB 삭제
DROP DATABASE dodram_db;

-- 사용자 삭제
DROP USER 'dodram_app'@'%';