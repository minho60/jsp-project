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

-- 샘플 데이터
INSERT INTO members (user_num, id, pw, name, phone, email, created_at) VALUES
(1, 'admin', '$2a$10$18PghUg2n2PnniPlvkU8Y.LDY9itC55JtMscv9wL66SyJoXejf63W', '정문주', '01011110000', 'kahyou222@gmail.com', '2026-03-13 15:28:09');

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