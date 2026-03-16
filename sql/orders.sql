use dodram_db;

-- =============================================
-- 주문 테이블
-- =============================================
CREATE TABLE orders (
    order_num         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_date        DATE            NOT NULL,
    order_state       VARCHAR(30)     NOT NULL DEFAULT 'PAYMENT_PENDING',
    orderer_name      VARCHAR(30)     NOT NULL,
    orderer_phone     VARCHAR(20)     NOT NULL,
    orderer_email     VARCHAR(50)     NOT NULL,
    receiver_name     VARCHAR(30)     NOT NULL,
    receiver_phone    VARCHAR(20)     NOT NULL,
    receiver_address  VARCHAR(300)    NOT NULL,
    created_at        DATETIME        DEFAULT CURRENT_TIMESTAMP,
    updated_at        DATETIME        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================
-- 주문 항목 테이블
-- =============================================
CREATE TABLE order_items (
    item_id       BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_num     BIGINT UNSIGNED NOT NULL,
    product_num   BIGINT UNSIGNED NOT NULL,
    quantity      INT UNSIGNED    NOT NULL DEFAULT 1,
    unit_price    INT UNSIGNED    NOT NULL DEFAULT 0,

    FOREIGN KEY (order_num)   REFERENCES orders(order_num) ON DELETE CASCADE,
    FOREIGN KEY (product_num) REFERENCES products(product_num)
);

-- =============================================
-- 샘플 데이터: 주문
-- =============================================
INSERT INTO orders (order_num, order_date, order_state, orderer_name, orderer_phone, orderer_email, receiver_name, receiver_phone, receiver_address) VALUES
(1001, '2026-01-10', 'DELIVERED',            '정문주', '010-1234-5678', 'kahyou222@gmail.com', '정문주',   '010-1234-5678', '서울특별시 강남구 테헤란로 123, 4층 401호'),
(1002, '2026-01-12', 'DELIVERED',            '조휘일', '010-9876-5432', 'whyeil@naver.com',    '조휘일',   '010-9876-5432', '경기도 성남시 분당구 판교역로 235, 7층'),
(1003, '2026-01-15', 'CANCELLED',            '이름4',  '010-2222-3333', 'user4@jfs.rf.gd',     '이름4',    '010-2222-3333', '부산광역시 해운대구 우동 센텀중앙로 48, 12층'),
(1004, '2026-01-18', 'SHIPPING_IN_PROGRESS', '정문주', '010-1234-5678', 'kahyou222@gmail.com', '김민수',   '010-5555-7777', '대전광역시 유성구 대학로 99, 과학기술원 기숙사 B동 305호'),
(1005, '2026-01-20', 'PREPARING_PRODUCT',    '름이5',  '010-4444-8888', 'user5@jfs.rf.gd',     '박영희',   '010-6666-9999', '인천광역시 연수구 송도과학로 32, 송도타워 15층'),
(1006, '2026-01-22', 'PAYMENT_PENDING',      '이름6',  '010-3333-1111', 'user6@jfs.rf.gd',     '이름6',    '010-3333-1111', '대구광역시 수성구 들안로 67, 수성아파트 102동 803호'),
(1007, '2026-01-25', 'SHIPPING_PENDING',     '조휘일', '010-9876-5432', 'whyeil@naver.com',    '조부모님', '010-7777-2222', '전라남도 순천시 장천로 51, 순천만아파트 3동 201호'),
(1008, '2026-01-28', 'RETURN_REQUESTED',     '름이7',  '010-8888-4444', 'user7@jfs.rf.gd',     '름이7',    '010-8888-4444', '경기도 고양시 일산동구 중앙로 1036, 웨스턴돔 B1층'),
(1009, '2026-02-01', 'CANCEL_REQUESTED',     '이름8',  '010-1111-5555', 'user8@jfs.rf.gd',     '이름8',    '010-1111-5555', '울산광역시 남구 삼산로 282, 삼산타운 5동 1501호'),
(1010, '2026-02-05', 'DELIVERED',            '정문주', '010-1234-5678', 'kahyou222@gmail.com', '정문주',   '010-1234-5678', '서울특별시 강남구 테헤란로 123, 4층 401호');

-- =============================================
-- 샘플 데이터: 주문 항목
-- =============================================
INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1001, 1000001664, 2, 16000),
(1001, 1000000565, 1, 18500);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1002, 1000000565, 1, 18500);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1003, 1000001661, 1, 17000),
(1003, 1000001660, 2, 15000),
(1003, 1000001137, 1, 8900);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1004, 1000001660, 1, 15000);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1005, 1000001137, 2, 8900),
(1005, 1000000515, 1, 31500);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1006, 1000000515, 1, 31500);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1007, 1000001851, 1, 75000);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1008, 1000000158, 1, 70000),
(1008, 1000001664, 3, 16000);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1009, 1, 5, 20400);

INSERT INTO order_items (order_num, product_num, quantity, unit_price) VALUES
(1010, 1000001664, 1, 16000),
(1010, 1000001661, 1, 17000),
(1010, 1000001660, 1, 15000),
(1010, 1000001137, 1, 8900);

-- =============================================
-- 유틸리티 쿼리
-- =============================================

-- 전체 주문 조회
SELECT * FROM orders ORDER BY order_num;

-- 주문별 합계 조회
SELECT o.order_num, o.order_date, o.order_state,
       SUM(oi.quantity) AS total_quantity,
       SUM(oi.quantity * oi.unit_price) AS total_amount
  FROM orders o
  JOIN order_items oi ON o.order_num = oi.order_num
 GROUP BY o.order_num
 ORDER BY o.order_num;

-- 테이블 삭제 (순서 주의)
-- DROP TABLE order_items;
-- DROP TABLE orders;
