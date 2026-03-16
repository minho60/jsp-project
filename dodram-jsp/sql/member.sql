use dodram_db;

-- 회원 테이블
CREATE TABLE members (
    user_num BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(50) NOT NULL UNIQUE,
    pw VARCHAR(60) NOT NULL,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 회원 테이블 조회
SELECT * FROM members;

-- 아이디로 회원 조회
SELECT user_num, id, pw, name, phone, email, created_at FROM members WHERE id = ?;

-- 이메일로 회원 조회
SELECT user_num, id, pw, name, phone, email, created_at FROM members WHERE email = ?;

-- 회원 테이블 삽입
INSERT INTO members (id, pw, name, phone, email) VALUES (?, ?, ?, ?, ?);

-- 회원 테이블 삭제
DROP TABLE members;