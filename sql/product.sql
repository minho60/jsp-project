use dodram_db;

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

-- =============================================
-- 유틸리티 쿼리
-- =============================================

-- 전체 카테고리 조회
SELECT * FROM categories;

-- 전체 상품 조회
SELECT * FROM products;

-- 카테고리별 상품 조회
SELECT p.*, c.name AS category_name
  FROM products p
  JOIN categories c ON p.category_num = c.category_num
 ORDER BY c.category_num, p.product_num;

-- 상품 + 상세 이미지 조회
SELECT p.product_num, p.name, pi.image_path, pi.sort_order
  FROM products p
  LEFT JOIN product_images pi ON p.product_num = pi.product_num
 ORDER BY p.product_num, pi.sort_order;

-- 테이블 삭제 (순서 주의: FK 의존성 역순)
-- DROP TABLE product_images;
-- DROP TABLE products;
-- DROP TABLE categories;
