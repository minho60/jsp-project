-- =============================================
-- dodram_db 설치용 SQL
-- =============================================
-- 설치 순서 (FK 의존성 기반):
--   1. member.sql - 회원 테이블 (members)
--   2. product.sql - 상품 테이블 (categories, products, product_images)
--   3. orders.sql - 주문 테이블 (orders, order_items)
--   4. event.sql - 이벤트 테이블 (event)
--   5. faq.sql - FAQ 테이블 (faq)
--   6. qa.sql - 1:1 문의 테이블 (qa)
-- =============================================

USE dodram_db;

-- ############################################
-- # STEP 1. member.sql
-- # 회원 테이블 (members)
-- ############################################

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

-- ############################################
-- # STEP 2. product.sql
-- # 상품 테이블 (categories, products, product_images)
-- ############################################

-- =============================================
-- 카테고리 테이블
-- =============================================
CREATE TABLE categories (
    category_num  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(50)  NOT NULL,
    description   VARCHAR(200) DEFAULT '',
    icon          VARCHAR(10)  DEFAULT '',
    created_at    DATETIME     DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 상품 테이블
-- =============================================
CREATE TABLE products (
    product_num     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_num    INT UNSIGNED    NOT NULL,
    name            VARCHAR(100)    NOT NULL,
    description     TEXT            DEFAULT NULL,
    price           INT UNSIGNED    NOT NULL DEFAULT 0,
    status          VARCHAR(20)     NOT NULL DEFAULT 'ACTIVE',
    thumbnail_image MEDIUMTEXT      DEFAULT NULL,
    origin          VARCHAR(50)     DEFAULT '',
    weight          INT UNSIGNED    NOT NULL DEFAULT 0,
    created_at      DATETIME        DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (category_num) REFERENCES categories(category_num)
);

-- =============================================
-- 상품 상세 이미지 테이블
-- =============================================
CREATE TABLE product_images (
    image_id      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_num   BIGINT UNSIGNED NOT NULL,
    image_path    MEDIUMTEXT      NOT NULL,
    sort_order    INT UNSIGNED    NOT NULL DEFAULT 0,
    created_at    DATETIME        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (product_num) REFERENCES products(product_num) ON DELETE CASCADE
);

-- =============================================
-- 샘플 데이터: 카테고리
-- =============================================
INSERT INTO categories (category_num, name, description, icon, created_at) VALUES
(1, '한돈',   '신선한 국내산 돼지고기', '🥩', '2025-01-01 00:00:00'),
(2, '한우',   '신선한 국내산 한우',     '🥓', '2025-01-01 00:00:00'),
(3, '테스트', '테스트',                 '🚀', '2025-01-01 00:00:00'),
(5, '선물세트', '',                     '🎁', '2025-01-10 00:00:00');

-- category_num 4가 비어있으므로 AUTO_INCREMENT 조정 불필요 (직접 번호 지정)

-- =============================================
-- 샘플 데이터: 상품
-- =============================================

-- [카테고리 3: 테스트]
INSERT INTO products (product_num, category_num, name, description, price, status, thumbnail_image, origin, weight, created_at, updated_at) VALUES
(1, 3, '테스트', '테스트', 20400, 'INACTIVE', '/img/test.gif', '국내산', 400, '2025-01-15 09:00:00', '2025-01-15 09:00:00');

-- [카테고리 1: 한돈]
INSERT INTO products (product_num, category_num, name, description, price, status, thumbnail_image, origin, weight, created_at, updated_at) VALUES
(1000001664, 1, '도드람한돈 목심 에어프라이어용 500g',  '에어프라이어로 간편하게 조리 가능한 도드람한돈 프리미엄 목심.', 16000, 'ACTIVE', '/img/product/1000001664_main_04.jpg',  '국내산(돼지고기)', 500, '2026-02-06 14:00:00', '2026-02-06 14:00:00'),
(1000000565, 1, '도드람한돈 칼집구이용 삼겹살 500g',    '칼집을 넣어 부드럽고 맛있게 구워지는 도드람한돈 삼겹살.',       18500, 'ACTIVE', '/img/product/1000000565_main_069.jpg', '국내산(돼지고기)', 500, '2026-02-06 14:00:00', '2026-02-06 14:00:00'),
(1000001661, 1, '도드람한돈 목심바비큐용 500g',         '바비큐에 최적화된 두툼한 도드람한돈 목심.',                     17000, 'ACTIVE', '/img/product/1000001661_main_082.jpg', '국내산(돼지고기)', 500, '2026-02-06 14:00:00', '2026-02-06 14:00:00'),
(1000001660, 1, '도드람한돈 삼겹살 바비큐용 500g',      '야외 바비큐에 꼭 맞는 프리미엄 도드람한돈 삼겹살.',             15000, 'ACTIVE', '/img/product/1000001660_main_06.jpg',  '국내산(돼지고기)', 500, '2026-02-06 14:00:00', '2026-02-06 14:00:00'),
(1000001137, 1, '도드람한돈 토시살(칼집) 400g',         '칼집이 들어간 부드러운 도드람한돈 토시살. 구이용 최적.',         8900, 'ACTIVE', '/img/product/1000001137_main_067.jpg', '국내산(돼지고기)', 400, '2026-02-06 14:00:00', '2026-02-06 14:00:00');

-- [카테고리 2: 한우]
INSERT INTO products (product_num, category_num, name, description, price, status, thumbnail_image, origin, weight, created_at, updated_at) VALUES
(1000000515, 2, '한우 등심 300g',  '마블링 풍부한 프리미엄 한우 등심. 구이용 최적.', 31500, 'ACTIVE',       '/img/product/1000000515_main.jpg', '국내산(한우)', 300, '2026-02-06 14:30:00', '2026-02-06 14:30:00'),
(1000000514, 2, '한우 불고기 300g', '부드럽고 달콤한 한우 불고기용.',                  14100, 'DISCONTINUED', NULL,                               '국내산(한우)', 300, '2026-02-06 14:30:00', '2026-02-06 14:30:00'),
(1000000513, 2, '한우 채끝 300g',  '풍미 깊은 프리미엄 한우 채끝. 스테이크용 최적.',   36000, 'DISCONTINUED', NULL,                               '국내산(한우)', 300, '2026-02-06 14:30:00', '2026-02-06 14:30:00'),
(1000000512, 2, '한우 국거리 300g', '깊은 육수가 우러나는 한우 국거리용.',              12600, 'DISCONTINUED', NULL,                               '국내산(한우)', 300, '2026-02-06 14:30:00', '2026-02-06 14:30:00');

-- [카테고리 5: 선물세트]
INSERT INTO products (product_num, category_num, name, description, price, status, thumbnail_image, origin, weight, created_at, updated_at) VALUES
(1000001851, 5, '도드람한돈 4구 삼목세트',     '삼겹살과 목심이 함께 구성된 프리미엄 선물세트.',       75000, 'ACTIVE', '/img/product/1000001851_main.png', '국내산(돼지고기)', 2000, '2026-02-06 15:00:00', '2026-02-06 15:00:00'),
(1000000158, 5, '도드람한돈 으뜸구이세트2호',  '구이용으로 최적화된 도드람한돈 프리미엄 선물세트.',     70000, 'ACTIVE', '/img/product/1000000158_main.png', '국내산(돼지고기)', 1600, '2026-02-06 15:00:00', '2026-02-06 15:00:00');

-- =============================================
-- 샘플 데이터: 상품 상세 이미지
-- =============================================

-- 테스트 상품 (product_num = 1) : 상세 이미지 2장
INSERT INTO product_images (product_num, image_path, sort_order) VALUES
(1, '/img/test.gif', 1),
(1, '/img/test.gif', 2);

-- 한돈 상품들 : 상세 이미지 각 1장
INSERT INTO product_images (product_num, image_path, sort_order) VALUES
(1000001664, '/img/product/6692560fe610a50de8da40bb5c6f8cff_144342.png', 1),
(1000000565, '/img/product/3f8e7d2f132144127fd9b42e10e36bdd_134024.png', 1),
(1000001661, '/img/product/5304b775a41b3538f78dea57d1998cf1_143935.png', 1),
(1000001660, '/img/product/f12986c60ed5927d63f854b22ab61e3f_143906.png', 1),
(1000001137, '/img/product/9d7a15029bbb0f15d51b9ec60fb560db_143815.png', 1);

-- 한우 등심 (product_num = 1000000515) : 상세 이미지 1장
INSERT INTO product_images (product_num, image_path, sort_order) VALUES
(1000000515, '/img/product/1000000515_detail.png', 1);

-- 한우 불고기/채끝/국거리 (DISCONTINUED) : 상세 이미지 없음

-- 선물세트 상품들 : 상세 이미지 각 1장
INSERT INTO product_images (product_num, image_path, sort_order) VALUES
(1000001851, '/img/product/1000001851_detail.png', 1),
(1000000158, '/img/product/1000000158_detail.png', 1);

-- ############################################
-- # STEP 3. orders.sql
-- # 주문 테이블 (orders, order_items)
-- ############################################

-- =============================================
-- 주문 테이블
-- =============================================
CREATE TABLE orders (
    order_num         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_num          BIGINT UNSIGNED NULL,            -- NULL이면 비회원 주문
    order_date        DATE            NOT NULL,
    order_state       VARCHAR(30)     NOT NULL DEFAULT 'PAYMENT_PENDING',
    orderer_name      VARCHAR(30)     NOT NULL,
    orderer_phone     VARCHAR(20)     NOT NULL,
    orderer_email     VARCHAR(50)     NOT NULL,
    receiver_name     VARCHAR(30)     NOT NULL,
    receiver_phone    VARCHAR(20)     NOT NULL,
    receiver_address  VARCHAR(300)    NOT NULL,
    created_at        DATETIME        DEFAULT CURRENT_TIMESTAMP,
    updated_at        DATETIME        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_num) REFERENCES members(user_num) ON DELETE SET NULL
);

-- 기존 DB에 컬럼 추가 시:
-- ALTER TABLE orders ADD COLUMN user_num BIGINT UNSIGNED NULL AFTER order_num;
-- ALTER TABLE orders ADD CONSTRAINT fk_orders_member FOREIGN KEY (user_num) REFERENCES members(user_num) ON DELETE SET NULL;

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
(1010, '2026-02-05', 'DELIVERED',            '정문주', '010-1234-5678', 'kahyou222@gmail.com', '정문주',   '010-1234-5678', '서울특별시 강남구 테헤란로 123, 4층 401호');

-- 회원 주문 (user_num = 1)
INSERT INTO orders (order_num, user_num, order_date, order_state, orderer_name, orderer_phone, orderer_email, receiver_name, receiver_phone, receiver_address) VALUES
(1009, 1, '2026-02-01', 'CANCEL_REQUESTED', '이름8', '010-1111-5555', 'user8@jfs.rf.gd', '이름8', '010-1111-5555', '울산광역시 남구 삼산로 282, 삼산타운 5동 1501호');

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

-- ############################################
-- # STEP 4. event.sql
-- # 이벤트 테이블 (event)
-- ############################################

CREATE TABLE event (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tab VARCHAR(20) NOT NULL,         -- ongoing / ended 등
    title VARCHAR(255) NOT NULL,      -- 이벤트 제목
    img VARCHAR(255) NOT NULL,        -- 이미지 파일명
    alt VARCHAR(100),                  -- 이미지 alt
    date VARCHAR(50),                  -- 이벤트 기간
    content TEXT,                       -- 상세 내용
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
	view_count INT DEFAULT 0
);
INSERT INTO event(tab,title,img,alt,date,content) VALUES
('ended','선물하셨나요? 도드람몰이 선물드립니다!','banner.jpg','선물','2026.01.05 00:00 ~ 2026.01.31 00:00','<p>도드람몰에서 선물 증정 이벤트 진행 중!</p>'),
('ended','유튜브속 도드람, 시원한 특가','b21576fbb2bba006203.jpg','유튜브','2025.08.06 00:00 ~ 2025.08.19 00:00','<p>도드람 유튜브 특가 상품을 확인하세요.</p>'),
('ended','[사은품 증정] 이건 받아야해! 여름 보냉백','1eeb1168e71f20534dad5740dbbe9573.jpg','보냉팩','2025.07.29 00:00 ~ 2025.08.31 00:00','<p>여름 보냉백 사은품 증정 이벤트!</p>'),
('ended','도드람 복날 보양식 할인 이벤트','ed5d89e0ff60b039b5b063446086685a.jpg','복날','2025.07.17 00:00 ~ 2025.07.30 00:00','<p>복날 한돈 보양식 할인 행사</p>'),
('ended','🔥 도드람 캠핑마켓 OPEN 🔥','aa59fefbe152eb9c87f2547a0e86a6db.jpg','캠핑마켓','2025.07.01 00:00 ~ 2025.07.09 00:00','<p>캠핑마켓 오픈! 다양한 상품 특가 판매</p>'),
('ended','🐽 삼겹살데이 할인행사 🐽','1758c8a5caff67f92701095f0160158b.png','삼겹살데이','2025.02.24 00:00 ~ 2025.03.09 00:00','<p>삼겹살데이 맞이 한돈 할인 이벤트</p>'),
('ended','💗도드람 창립34주년 기념 할인행사💗','a4a0f38abfabae8c951.png','창립34주년','2024.10.07 00:00 ~ 2024.10.20 00:00','<p>도드람 창립 34주년 기념 할인 행사!</p>'),
('ended','🌴GO SURFYY FIND DODRAM🌴','64bb8f4db07f8c14a0be547dfccd8557.jpg','피서','2024.06.21 00:00 ~ 2024.06.30 23:59','<p>여름 피서 이벤트, 한돈 특가 상품!</p>'),
('ended','도드람 캔돈 어택!','e29263183bc61354ed41ecbc83a91c37_172511.jpg','캔돈','2024.06.11 00:00 ~ 2024.06.16 23:59','<p>도드람 캔돈 이벤트 진행</p>'),
('ended','[EVENT] 도드람 유튜브 빅꿀잼 퀴즈 이벤트','e5fc2567e9ae2b26b9c4d24a78edafad.jpg','유튜브퀴즈','2024.05.10 00:00 ~ 2024.05.15 23:59','<p>유튜브 퀴즈 이벤트! 경품 증정</p>'),
('ended','가정의 달 선물네컷 추천!','65aefc273ade8cc4b610c67311200ae8.jpg','가정의달','2024.05.07 00:00 ~ 2024.05.31 23:59','<p>가정의 달 선물 추천 이벤트</p>'),
('ended','SSG랜더스필드의 도드람 스카이박스 가는거 어때요?','7e073f4e2e04730f911552e5a87b4abb_140735.jpg','스카이박스','2024.04.26 00:00 ~ 2024.05.06 00:00','<p>SSG 랜더스필드 스카이박스 이벤트 안내</p>'),
('ended','도드람한돈 벚꽃 에디션 출시','8c04003e48d5a949662.png','벚꽃에디션','2024.03.24 00:00 ~ 2024.04.30 00:00','<p>벚꽃 에디션 출시 기념 이벤트</p>'),
('ended','肉월에는 고기반찬','4bde6c63dee14c9c.png','고기반찬','2021.06.07 00:00 ~ 2021.06.21 23:59','<p>肉월 맞이 고기반찬 특가 이벤트</p>'),
('ended','특수부위 3종 금주특가','4d02603a5f350f11.png','특수부위','2021.05.11 00:00 ~ 2021.05.18 23:59','<p>특수부위 3종 금주특가 행사</p>'),
('ended','도드람몰 연말 랭킹쇼! 인기상품 총 결산 할인','9b7736919ed74f22.png','연말랭킹','2020.12.07 00:00 ~ 2020.12.31 00:00','<p>연말 랭킹쇼, 인기상품 총 결산 할인 이벤트</p>');

-- ############################################
-- # STEP 5. faq.sql
-- # FAQ 테이블 (faq)
-- ############################################

CREATE TABLE faq (
    qaNum INT AUTO_INCREMENT PRIMARY KEY,      -- 글 번호 (자동 증가)
    type VARCHAR(50) NOT NULL,                  -- 카테고리 (예: "결제/배송")
    question TEXT NOT NULL,             -- 질문 제목
    answer TEXT,                                -- 답변 내용
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성일
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 수정일
);
INSERT INTO faq (type, question, answer) VALUES
('결제/배송', '30만원 이상 결제 시 공인인증서 인증이 왜 필요한가요?', '○ 공인인증서 결제 안내 - 2005년 11월 1일부터 금융감독원의 전자상거래 안정성 강화 정책에 따라 30만원 이상의 모든 신용카드 결제 시에 공인인증서 사용이 의무화 되었습니다. - 이에 30만원 이상 결제 시 공인인증서로 서명을 하셔야 합니다. 약간 불편하실 수 있겠지만 안전한 결제를 위해 공인인증서 확인 후 이용 부탁드리겠습니다.'),
('결제/배송', '3배송비는 어떻게 되나요? ', '○ 배송안내 - 배송비는 한 주문건당 2,500원입니다. - 실결제 3만원 이상일 경우 무료배송으로 적용 - 한진택배를 통해 배송을 진행하고 있습니다.'),
('결제/배송', '결제 방법에는 어떤 종류가 있나요?', '○ 도드람몰의 결제 수단은 이렇습니다. - PC: 카드결제, 실시간 계좌이체, 핸드폰 소액결제, 네이버페이 간편결제, 페이코 간편결제, 휴대폰 결제 - 모바일: 카드결제, 실시간 계좌이체, 핸드폰 소액결제, 네이버페이 간편결제, 페이코 간편결제, 휴대폰 결제 도드람몰은 LG U플러스 PG를 이용하고 있습니다. PG 사의 사정에 따라 결제 방법은 변동될 수 있습니다. 또한 도드람몰 운영 정책에 따라 결제 수단은 변경될 수 있습니다.'),
('결제/배송', '배송 휴무는 언제인가요?', '○ 도드람몰 배송 휴무일 안내 - 택배(한진택배) 휴무일로 주말(토요일, 일요일), 공휴일, 명절(추석, 설) - 교통체증이 극심한 주말이나 공휴일 명절기간에는 배송이 어려울 수 있습니다.'),
('회원가입/정보', '주문이 되지 않는데, 이유를 알고 싶습니다.', '○ 주문이 어려울 때의 조치 방법을 안내드립니다. - 모바일의 경우 앱, 웹을 종료 후 재로그인해주세요.(모바일 환경보다는 컴퓨터가 원활할 수 있습니다. 컴퓨터로 접속 부탁드립니다.) - 공용 PC의 경우 방화벽이 높게 설정되었을 경우 결제가 어려울 수 있으며, 결제에 필요한 모든 컨텐츠 사용 및 프로그램은 허용해주셔야 합니다.) ○ 재로그인, 재접속 이후에도 동일한 문제가 발생하실 경우, 고객지원실(070-4905-4058)로 연락주시거나, 홈페이지 좌측 상단의 [고객센터]-[1:1상담]에 글 남겨주시면 영업시간 내에 신속한 답변 드리겠습니다.'),
('결제/배송', '3주문하면 언제 배송받을 수 있나요?', '○ 배송안내 - 택배배송의 경우 오전 7시까지 결제 완료하신 주문건은 당일 발송하여 다음날 배송 받으실 수 있습니다. - 오전 7시 이후 결제건은 익일 발송되어 다다음날 배송 받으시게 됩니다.(주말 및 공휴일은 배송휴무입니다.) 예) 월 오전 7시 이전 결재 : 화요일 배송 월 오전 7시 이후 결재 : 수요일 배송'),
('결제/배송', '결제 내역을 문자나 메일로 받아볼 수 있나요?', '○ 주문내역 알림 - 주문내역은 고객님의 회원정보에 기재된 휴대폰번호를 기반으로 카카오톡 알림 또는 문자메시지, 이메일로 발송드립니다. (카카오톡 알림 수신거부 또는 메일 수신거부 시 결제내역이 전송되지 않을 수 있습니다.)'),
('회원가입/정보', '적립금/쿠폰 적용은 어떻게 하나요?', '적립금/쿠폰 적용 1. 쿠폰 : 주문단계 -> 쿠폰 조회 및 적용 클릭 -> 사용하려는 쿠폰 선택 2. 적립금 : 주문단계 -> 적립금적용 -> 보유 적립금 확인 후, 원하시는 금액 입력 (한 주문건에 적립금과 쿠폰은 동시에 사용할 수 없습니다.) (적립금은 1원단위로 사용이 가능합니다.) (쿠폰별로 사용법 및 조건이 다를 수 있으니 사용법 문의는 1:1문의에 남겨주세요.) (한 주문건에 쿠폰은 한 장만 사용이 가능합니다.)'),
('회원가입/정보', '회원가입은 무료인가요?', '네. 그렇습니다! 도드람몰은 무료 회원가입 후 이용할 수 있습니다. 회원가입 후 다양한 상품을 만나보세요!'),
('기타', '구매후기는 어떻게 등록하나요? 후기적립금은 얼마인가요?', '마이페이지 -> 주문목록/배송조회 -> 해당 주문건 클릭 -> 원하시는 상품 후기작성 클릭 후 작성하시면 됩니다. - 후기작성은 상품 수령일 09시 이후부터 작성이 가능합니다. (미구매 상품 작성불가, 배송전 상품 작성불가) - 상품 배송완료일로 부터 30일동안 후기 작성가능. 30일 경과시 후기작성이 불가합니다. - 일반후기는 50원 사진후기는 100원의 적립금이 지급되며, 매월 베스트후기 20명을 추첨하여 적립금 5,000원을 지급하고 있습니다. - 정책에 따라 일부 카테고리 상품은 후기 작성 적립금 지급이 되지 않을 수 있습니다. - 근거없는 비망 및 욕설이 기재되어 있을 경우 삭제됩니다. - 타인의 주관적인 의견으로 인하여 상품의 기능이나 효과 등에 오해가 있을 수 있는 상품평은 삭제될 수 있습니다. * 교환/환불 등의 신속한 조치가 필요한 사항은 1:1게시판 또는 카카오톡 문의접수 바랍니다. * 카카오톡 문의 접수 방법 * 1. 플러스친구에서 "도드람몰"을 검색해주세요.'),
('회원가입/정보', '주문 후 주문정보(배송지, 메모, 출입방법 등)변경하려고 하는데 어떻게 해야하나요?', '주문 후 배송정보 변경은 배송일 전날 오전 11시전까지 1:1게시판으로 수정내용을 남겨주셔야 합니다. 오전 11시 이후에는 배송이 시작된 이후이므로 수정이 어렵습니다.'),
('기타', '인터넷으로 신선육을 사도 될까요?', '도드람몰은 도드람양돈농협이 직영하는 공식 쇼핑몰로 도드람한돈의 경우 당일주문-당일 공장가공을 원칙으로 하고 있습니다. 다른 상품의 경우에도 직영하는 하나로마트에서 발송 당일에 픽업하여 포장하고 있습니다. 포장의 경우 DPS(Digital Picking System)을 도입하여 주문한 내역을 빠짐없이 포장하기 위한 노력을 지속하고 있으며 최대한 제품을 신선하게 배송해 드리기 위해, 주문당일 오전 11시까지 주문한 경우, 롯데택배(현대택배) 시스템을 통해 다음날 저녁 11시까지 제품을 배송해 드리는 시스템으로 운영되고 있습니다. 혹여라도, 수령한 제품에 문제가 발생할 경우를 대비해, "고객만족보장제도"를 운영하고 있으며, 1:1문의 게시판에 사진(사진으로 확인할 수 있는 경우) 및 불편사항을 접수해 주시면, 환불, 교환도 진행하고 있습니다. "여기까지 오셨으면 고객만족의 책임은 우리가 한다"라는 신념으로 좋은 제품을 선택하고, 검수하며 문제발생시 고객님의 편에서 조치를 드리고 있으니, 안심하고 이용해 주시기 바랍니다.'),
('결제/배송', '상품 주문은 어떻게 하나요?', '구매를 원하시는 상품을 장바구니에 담으신 후, 결제하기 버튼을 클릭하시면 됩니다.'),
('회원가입/정보', '홈페이지 우측 상단 [로그인] 버튼 클릭 -> 로그인 화면 오른쪽 옆 [아이디 찾기] [비밀번호찾기]를 통해 확인이 가능하며, 임시 비밀번호의 경우 회원가입시 등록한 메일주소로 발송이 됩니다. 가입시 기재한 메일 주소가 기억나지 않으시거나 오류가 발생하는 경우, 고객지원실(1899-2236)로 연락을 주시면 신속하게 답변 드리겠습니다. 다만, 고객센터로 연락을 주셔도 고객님의 개인정보보호를 위해 기존에 사용하시던 비밀번호는 안내가 불가하며, 개인정보 확인 후 비밀번호 초기화를 도와드립니다.', ''),
('결제/배송', '현금영수증 발행을 취소하고 싶어요.', '# 현금영수증 발행취소 안내 - 고객의 요청에 의해 발급된 현금영수증은 국세청 승인후엔 변경 불가합니다. - 단, 국세청 승인 전일경우는 변경이나 취소가 가능합니다. [1:1문의] 또는 고객지원실(1899-2236)로 문의 바랍니다.'),
('마일리지 적립', '적립금을 쌓으려면 어떻게 해야 하나요?', '도드람몰의 적립금은 주문결제, 후기 작성, 이벤트 참여 시 지급됩니다. 주문결제 적립금은 주문 시 실결제금액에 각 고객등급별 적립율을 곱한 금액으로 지급됩니다. 일반후기는 50원 적립금이 지급됩니다. 적립금 지급은 후기 작성 후 영업일 기준 2~3일 내에 지급됩니다. 그 외 각종 이벤트 참여를 통해 적립금 지급이 가능하오니 자세한 사항은 홈페이지 우측 이벤트탭에서 확인해주세요.'),
('기타', '상품 문의는 어떻게 하나요?', '상품에 대한 문의는 해당 상품의 하단 상품문의 게시판에 작성을 해주시면 영업일 기준 1~2일내에 직접 답변을 드리고 있습니다. # 참고사항 -교환/환불/배송/쿠폰사용 등에 관한 문의는 1:1문의 게시판을 이용해주세요.'),
('교환/반품/환불', '교환 시 별도 배송비가 부과되나요?', '▶ 교환 시 배송비 부과경우 1. 고객님이 부담하는 경우(단순변심,오주문 등) - 상품에 이상이 없거나 상품의 특성적인 부분인 경우 - 단순 변심에 의해 교환 및 반품하는 경우 - 옵션 및 상품을 잘못 선택하여 잘못 주문했을 경우 ※ 가공식품 및 일부 비식품류에 한해서만 반품이 가능하며, 교환에 제반되는 배송비(편도 또는 왕복)는 고객님께서 부담하셔야 합니다. ※ 변심에 의한 교환 시 배송비 금액 : 5,000원 (편도 2,500원 왕복 배송비) 2. 교환 시 배송비를 판매자가 부담하는 경우 (판매자 과실 등) - 수령한 상품이 불량인 경우 - 수령한 상품이 파손된 경우 - 상품이 상품상세정보와 다른 경우 - 주문한 상품과 다른 상품이 배송된 경우 등'),
('회원가입/정보', '회원 정보를 변경하려면 어떻게 해야 하나요?', '도드람몰 로그인 -> 홈페이지 우측 상단 -> 마이페이지 -> 회원정보 에서 회원정보 변경이 가능합니다. (아이디는 변경이 불가하며 모바일에서 접속시 화면 상단 -> 마이페이지에서 변경이 가능합니다) 회원정보 수정은 배송정보 수정이 아닌 회원정보 수정이므로, 만일 회원정보 수정 시점에 배송중인 상품이 있다면 배송정보에는 반영되지 않으며, 배송정보 변경을 원하실 경우에는 배송일 전날 오전 11시전까지 1:1게시판에 주문번호와 함께 내용을 남겨주시면 반영이 가능합니다.');


INSERT INTO faq (type, question, answer) VALUES
('교환/반품/환불', '반품 시 배송비는 누가 부담하나요?', '▶ 반품 시 배송비 안내 1. 고객 부담: 단순 변심, 오주문 등 고객 과실일 경우 2. 판매자 부담: 상품 불량, 파손, 오배송 등 판매자 과실일 경우, 배송비는 판매자가 부담합니다.'),
('교환/반품/환불', '환불은 언제 되나요?', '환불은 상품이 반품 처리 완료된 후 3~5영업일 이내 결제수단으로 환불됩니다. 단, 카드사의 사정에 따라 영업일 기준 5~7일 소요될 수 있습니다.'),
('교환/반품/환불', '교환/반품이 불가한 경우가 있나요?', '다음과 같은 경우 교환/반품이 불가합니다. 1. 포장을 개봉하여 상품 가치가 훼손된 경우 2. 가공식품의 경우, 조리 또는 세척 후 3. 고객님의 부주의로 상품이 훼손된 경우 4. 반품기간(배송완료일 기준 7일)이 지난 경우'),
('배송/주문', '주문 후 배송 조회는 어떻게 하나요?', '마이페이지 -> 주문목록/배송조회 -> 해당 주문건 클릭 -> 배송조회 버튼을 클릭하시면 현재 배송 상황을 확인할 수 있습니다.'),
('배송/주문', '주문을 취소하고 싶어요.', '주문 취소는 배송 준비 중 상태에서만 가능하며, 배송 시작 후에는 반품 절차를 통해 처리하셔야 합니다. 취소는 마이페이지 또는 고객센터를 통해 가능합니다.'),
('회원가입/정보', '아이디/비밀번호를 분실했어요.', '홈페이지 우측 상단 [로그인] 클릭 -> [아이디 찾기] 또는 [비밀번호 찾기]를 이용하세요. 임시 비밀번호는 가입 시 등록한 메일 주소로 발송됩니다. 메일 주소 확인이 어려우면 고객센터로 연락 바랍니다.'),
('결제/배송', '결제 완료 후 주문 내용을 수정하고 싶어요.', '결제 완료 후 주문 정보 변경은 배송 시작 전까지 가능합니다. 배송 시작 후에는 1:1 문의를 통해 반품/교환 절차로 처리해야 합니다.'),
('결제/배송', '현금영수증 발급 방법이 궁금해요.', '주문 시 결제 단계에서 현금영수증 발급을 선택할 수 있습니다. 발급 후에는 국세청 승인 전까지 변경/취소가 가능합니다.'),
('마일리지 적립', '적립금 사용은 어떻게 하나요?', '적립금은 결제 단계에서 사용 가능합니다. 단, 일부 쿠폰과 적립금은 동시에 적용되지 않을 수 있으며, 최소 사용 금액이 정해져 있을 수 있습니다.'),
('기타', '상품 후기 작성은 어떻게 하나요?', '마이페이지 -> 주문목록/배송조회 -> 해당 주문건 클릭 -> 상품 후기 작성 클릭 후 작성 가능합니다. 일반후기 50원, 사진후기 100원의 적립금이 지급됩니다.'),
('기타', '상품 문의는 어디에 남기나요?', '상품 하단 상품문의 게시판에 글 작성 시 영업일 기준 1~2일 내 답변드립니다. 교환/환불/배송 관련 문의는 1:1 문의 게시판을 이용해주세요.'),
('회원가입/정보', '회원 등급 혜택은 무엇이 있나요?', '회원 등급은 구매 실적에 따라 달라지며, 각 등급별 할인율, 적립금 지급률, 전용 이벤트 참여 기회가 제공됩니다.'),
('결제/배송', '결제 오류가 발생했어요.', '결제 오류 시 브라우저 캐시 삭제 후 재시도, 다른 결제 수단 사용, 고객센터 문의 등을 통해 문제를 해결할 수 있습니다.'),
('배송/주문', '배송지를 변경하고 싶어요.', '배송지 변경은 배송 시작 전까지 마이페이지 또는 1:1 문의로 신청 가능합니다. 배송 출발 후에는 변경이 불가합니다.'),
('교환/반품/환불', '상품 불량 시 교환/환불 절차는?', '상품 불량 시 1:1 문의로 접수 -> 사진 확인 후 교환 또는 환불 처리. 배송비는 판매자 부담.'),
('회원가입/정보', '탈퇴 후 재가입이 가능한가요?', '회원 탈퇴 후 7일 경과 시 재가입 가능하며, 기존 아이디는 재사용할 수 없습니다.'),
('마일리지 적립', '적립금 소멸 기한이 있나요?', '적립금은 지급일로부터 1년간 사용 가능하며, 기간 경과 시 자동 소멸됩니다.'),
('기타', '포인트/쿠폰과 적립금은 함께 사용 가능한가요?', '쿠폰과 적립금은 일부 상품에서만 동시에 사용 가능하며, 결제 단계에서 적용 가능 여부를 확인할 수 있습니다.'),
('기타', '주문 시 상품 옵션을 변경할 수 있나요?', '주문 완료 전까지는 옵션 변경 가능, 주문 완료 후에는 배송 전이라도 변경이 불가하며, 필요 시 1:1 문의를 통해 반품/재주문 처리 가능합니다.'),
('기타', '회원 문의 시 어떤 정보를 제공해야 하나요?', '주문번호, 회원 아이디, 문의 내용 등을 제공하시면 신속한 처리가 가능합니다.'),
('기타', '배송 지연 시 어떻게 확인하나요?', '마이페이지 -> 주문목록/배송조회에서 현재 배송 상태를 확인할 수 있습니다. 배송 지연 시 고객센터 안내를 통해 추가 정보를 제공받을 수 있습니다.'),
('결제/배송', '결제 수단 변경은 가능한가요?', '결제 진행 전에는 변경 가능하며, 결제 완료 후에는 취소 후 재결제를 통해서만 변경 가능합니다.'),
('교환/반품/환불', '반품 처리 후 환불 방법은?', '반품 완료 후 결제수단으로 자동 환불되며, 카드사의 경우 5~7영업일 소요될 수 있습니다.'),
('기타', '상품 재입고 알림은 어떻게 받나요?', '상품 상세 페이지에서 재입고 알림 신청 시 이메일 또는 SMS로 알림을 받으실 수 있습니다.');

-- ############################################
-- # STEP 6. qa.sql
-- # 1:1 문의 테이블 (qa)
-- ############################################

-- =============================================
-- 문의 유형 (7종)
-- =============================================
-- 키                | 라벨
-- ------------------+---------------------
-- MEMBER            | 회원/정보관리
-- ORDER     		 | 주문/결제
-- DELIVERY          | 배송
-- REFUND			 | 반품/환불/교환/AS
-- RECEIPT           | 영수증/증빙서류
-- EVENT     		 | 상품/이벤트
-- ETC               | 기타

-- =============================================
-- 문의 상태 (2종)
-- =============================================
-- 키                | 라벨
-- ------------------+---------------------
-- WAITING           | 답변대기
-- ANSWERED          | 답변완료

-- =============================================
-- 1:1 문의 테이블 (회원 + 비회원)
-- =============================================
CREATE TABLE qa (
    qa_num         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type           VARCHAR(20)     NOT NULL,                    -- MEMBER, ORDER, DELIVERY, REFUND, RECEIPT, EVENT, ETC
    title          VARCHAR(200)    NOT NULL,
    content        TEXT            NOT NULL,

    -- 회원
    user_num       BIGINT UNSIGNED DEFAULT NULL,                -- 회원이면 FK, 비회원이면 NULL

    -- 비회원
    guest_name     VARCHAR(30)     DEFAULT NULL,                -- 비회원 작성자명
    guest_password VARCHAR(255)    DEFAULT NULL,                -- 비회원 비밀번호 (BCrypt 해시)
    guest_email    VARCHAR(100)    DEFAULT NULL,                -- 비회원 이메일

    status         VARCHAR(20)     NOT NULL DEFAULT 'WAITING',  -- WAITING, ANSWERED
    answer         TEXT            DEFAULT NULL,                -- 관리자 답변 (없으면 NULL)
    answered_at    DATETIME        DEFAULT NULL,                -- 답변 시각 (없으면 NULL)
    created_at     DATETIME        DEFAULT CURRENT_TIMESTAMP,
    updated_at     DATETIME        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_num) REFERENCES members(user_num)
);

-- =============================================
-- 샘플 데이터 (회원 문의 1건)
-- =============================================
INSERT INTO qa (type, title, content, user_num, status, answer, answered_at, created_at) VALUES
('MEMBER', '비밀번호 변경이 안됩니다',
 '마이페이지에서 비밀번호를 변경하려고 하는데\n현재 비밀번호 입력 후 새 비밀번호가 저장이 안됩니다.\n\n확인 부탁드립니다.',
 1, 'ANSWERED',
 '안녕하세요, 도드람몰입니다.\n\n비밀번호는 영문, 숫자, 특수문자를 포함한 8자 이상이어야 합니다.\n조건을 확인 후 다시 시도해 주시기 바랍니다.\n\n계속 문제가 발생하면 고객센터로 연락주세요.\n\n감사합니다.',
 DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY));

-- =============================================
-- 샘플 데이터 (비회원 문의 11건, 비밀번호: 1234)
-- guest_password: BCrypt.hashpw("1234", BCrypt.gensalt())
-- =============================================
INSERT INTO qa (type, title, content, user_num, guest_name, guest_password, guest_email, status, answer, answered_at, created_at) VALUES
-- [ORDER] 주문/결제
('ORDER', '결제 오류로 이중결제가 되었습니다',
 '카드 결제 시 오류가 발생했는데\n금액이 이중 결제된 것 같습니다.\n\n확인 부탁드립니다.\n\n카드사: 삼성카드\n결제일시: 2026-01-23 14:32',
 NULL, '김영수', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'kimys@gmail.com',
 'ANSWERED',
 '안녕하세요, 도드람몰입니다.\n\n확인 결과 이중결제 건 맞습니다.\n해당 금액은 3-5영업일 내 자동 환불됩니다.\n\n불편을 드려 죄송합니다.\n\n감사합니다.',
 DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY)),

('ORDER', '카드 할부 가능한가요?',
 '5만원 이상 결제 시 무이자 할부 가능한지 궁금합니다.\n\n신한카드 사용 예정입니다.',
 NULL, '이지은', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'leeje@naver.com',
 'ANSWERED',
 '안녕하세요, 도드람몰입니다.\n\n현재 5만원 이상 결제 시\n신한/삼성/현대카드는 2-3개월 무이자 할부 가능합니다.\n\n결제 시 할부 옵션에서 선택하실 수 있습니다.\n\n감사합니다.',
 DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY)),

-- [DELIVERY] 배송
('DELIVERY', '배송일 변경 요청합니다',
 '주문번호 2026012512345입니다.\n\n원래 26일 배송 예정인데, 27일로 변경 가능할까요?\n집에 아무도 없어서요.\n\n연락처: 010-9876-5432',
 NULL, '박민수', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'parkms@gmail.com',
 'WAITING', NULL, NULL, DATE_SUB(NOW(), INTERVAL 1 DAY)),

('DELIVERY', '배송 조회가 안됩니다',
 '어제 주문했는데 배송조회가 안되네요.\n\n주문번호: 2026012400123\n\n확인 부탁드립니다.',
 NULL, '최수진', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'choisj@naver.com',
 'WAITING', NULL, NULL, NOW()),

-- [REFUND] 반품/환불/교환/AS
('REFUND', '교환 신청합니다',
 '안녕하세요.\n\n1월 20일에 받은 목살 400g 제품인데요,\n진공포장이 풀려서 상태가 안좋습니다.\n\n교환 가능할까요?',
 NULL, '정대호', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'jungdh@gmail.com',
 'ANSWERED',
 '안녕하세요, 도드람몰입니다.\n\n불편을 드려 죄송합니다.\n교환 절차 안내드리겠습니다.\n\n수거 후 새 제품으로 재발송 예정이며,\n수거 일정은 별도 문자로 안내드리겠습니다.\n\n감사합니다.',
 DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),

('REFUND', '반품 요청드립니다',
 '변심으로 반품 요청드립니다.\n미개봉 상태이고 내일까지 수거 가능합니다.\n\n주문번호: 2026012000789',
 NULL, '한소영', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'hansy@naver.com',
 'WAITING', NULL, NULL, DATE_SUB(NOW(), INTERVAL 2 DAY)),

-- [RECEIPT] 영수증/증빙서류
('RECEIPT', '현금영수증 발급 요청',
 '1월 15일 주문건에 대해 현금영수증 발급 부탁드립니다.\n\n주문번호: 2026011500456\n사업자번호: 123-45-67890',
 NULL, '오세준', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'ohsj@company.co.kr',
 'ANSWERED',
 '안녕하세요, 도드람몰입니다.\n\n요청하신 현금영수증 발급 완료되었습니다.\n국세청 홈택스에서 확인 가능합니다.\n\n감사합니다.',
 DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),

-- [EVENT] 상품/이벤트
('EVENT', '설 선물세트 할인 이벤트 언제 하나요?',
 '작년에 설 선물세트 할인 이벤트가 있었는데\n올해도 진행하나요?\n\n미리 알려주시면 감사하겠습니다.',
 NULL, '윤미래', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'yoonmr@gmail.com',
 'WAITING', NULL, NULL, DATE_SUB(NOW(), INTERVAL 1 DAY)),

('EVENT', '냉동삼겹살 해동방법 문의',
 '냉동 삼겹살 구매했는데요,\n해동은 어떻게 하는게 좋을까요?\n\n냉장 해동이 좋은지,\n상온 해동이 좋은지 알려주세요.',
 NULL, '강태우', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'kangtw@naver.com',
 'ANSWERED',
 '안녕하세요, 도드람몰입니다.\n\n냉동 삼겹살은 냉장실에서 천천히 해동하시는 것이 좋습니다.\n(약 12-24시간 소요)\n\n급하신 경우 흐르는 물에 밀봉된 상태로 해동하시면 됩니다.\n상온 해동은 육즙 손실이 있어 추천드리지 않습니다.\n\n맛있게 드세요!',
 DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),

-- [ETC] 기타
('ETC', '도드람 공장 견학 가능한가요?',
 '아이들 체험학습으로 도드람 공장 견학이 가능한지 궁금합니다.\n\n가능하다면 예약 방법도 알려주세요.\n\n감사합니다.',
 NULL, '홍길동', '$2a$10$ck0jWZ.6ep/4CQ4Bpmuqn.68Xr8DaCYnIaB5aANMb6WXQQHzsClr6', 'hong@gmail.com',
 'WAITING', NULL, NULL, NOW());

-- ※ 비회원 비밀번호는 모두 '1234' (BCrypt 해시)
--   Java: BCrypt.checkpw("1234", BCrypt.gensalt()) → true

