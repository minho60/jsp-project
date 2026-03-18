use dodram_db;

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

-- =============================================
-- 전체 조회
-- =============================================
SELECT * FROM qa ORDER BY qa_num;

-- =============================================
-- 문의번호로 조회
-- =============================================
SELECT qa_num, type, title, content, user_num,
       guest_name, guest_password, guest_email,
       status, answer, answered_at, created_at, updated_at
  FROM qa WHERE qa_num = ?;

-- =============================================
-- 전체 문의 목록 (관리자용, 회원/비회원 모두 표시)
-- =============================================
SELECT q.qa_num, q.type, q.title, q.status, q.created_at,
       CASE WHEN q.user_num IS NOT NULL THEN m.id        ELSE q.guest_name  END AS writer_name,
       CASE WHEN q.user_num IS NOT NULL THEN m.email     ELSE q.guest_email END AS writer_email,
       CASE WHEN q.user_num IS NOT NULL THEN '회원'      ELSE '비회원'      END AS writer_type
  FROM qa q
  LEFT JOIN members m ON q.user_num = m.user_num
 ORDER BY q.created_at DESC;

-- =============================================
-- 회원 문의 등록
-- =============================================
INSERT INTO qa (type, title, content, user_num)
VALUES (?, ?, ?, ?);

-- =============================================
-- 비회원 문의 등록
-- =============================================
INSERT INTO qa (type, title, content, guest_name, guest_password, guest_email)
VALUES (?, ?, ?, ?, ?, ?);
-- guest_password는 Java에서 BCrypt.hashpw(rawPw, BCrypt.gensalt()) 후 전달

-- =============================================
-- 답변 등록/수정
-- =============================================
UPDATE qa SET answer = ?, status = 'ANSWERED', answered_at = NOW() WHERE qa_num = ?;

-- =============================================
-- 문의 상태별 건수 (대시보드용)
-- =============================================
SELECT status, COUNT(*) AS cnt FROM qa GROUP BY status;

-- =============================================
-- 답변대기 건수
-- =============================================
SELECT COUNT(*) AS waiting_count FROM qa WHERE status = 'WAITING';

-- =============================================
-- 문의 삭제
-- =============================================
DELETE FROM qa WHERE qa_num = ?;

-- =============================================
-- 테이블 삭제
-- =============================================
-- DROP TABLE qa;
