# 🐷 도드람몰 (dodram-jsp)

도드람몰 쇼핑몰 클론 프로젝트 — **JSP/Servlet** 기반 풀스택 웹 애플리케이션

## 📋 프로젝트 개요

[도드람몰(dodrammall.com)](https://dodrammall.com)을 모티브로 한 쇼핑몰 및 관리자 페이지를 JSP/Servlet으로 구현한 프로젝트입니다.
쇼핑몰 메인, 상품 목록/상세, 회원가입/로그인, 마이페이지, 장바구니/주문, 고객센터 등 주요 기능과 관리자 대시보드를 포함합니다.

## 🛠 기술 스택

| 영역 | 기술 |
|------|------|
| **Language** | Java 17 |
| **Web** | JSP, Servlet (Tomcat 9 / javax) |
| **Database** | MySQL |
| **ORM / DB 접근** | JDBC (커스텀 유틸리티) |
| **라이브러리** | JSTL 1.2.5, Gson, Lombok, jBCrypt, MySQL Connector/J |
| **Frontend** | HTML, CSS, JavaScript, jQuery |
| **IDE** | Eclipse |
| **CI/CD** | GitHub Actions → Oracle Cloud (Ubuntu + Tomcat) |

## 📁 프로젝트 구조

```
dodram-jsp/
├── .github/workflows/
│   └── deploy.yml              # GitHub Actions 자동 배포
├── sql/
│   └── member.sql              # DB 스키마 (members 테이블)
├── src/main/
│   ├── java/
│   │   ├── admin/
│   │   │   ├── AdminConstants.java       # 관리자 공통 상수
│   │   │   ├── dao/                      # 데이터 접근 계층
│   │   │   │   ├── CategoryDAO.java
│   │   │   │   ├── InquiryDAO.java
│   │   │   │   ├── OrderDAO.java
│   │   │   │   ├── ProductDAO.java
│   │   │   │   └── UserDAO.java
│   │   │   ├── dto/                      # 데이터 전송 객체
│   │   │   │   ├── CategoryDTO.java
│   │   │   │   ├── InquiryDTO.java
│   │   │   │   ├── OrderDTO.java
│   │   │   │   ├── OrderItemDTO.java
│   │   │   │   ├── ProductDTO.java
│   │   │   │   └── UserDTO.java
│   │   │   ├── filter/                   # 관리자 인증 필터
│   │   │   ├── servlet/                  # 관리자 서블릿 (12개)
│   │   │   └── util/                     # 관리자 유틸리티
│   │   ├── filter/
│   │   │   └── CleanUrlFilter.java       # 클린 URL 필터
│   │   └── util/
│   │       ├── DBConfig.java             # DB 설정 (env / properties)
│   │       ├── DBConnectionMgr.java      # 커넥션 관리
│   │       ├── DBUtil.java               # DB 유틸리티
│   │       ├── JsonUtil.java             # JSON 유틸리티
│   │       ├── RowMapper.java            # ResultSet 매핑 인터페이스
│   │       ├── SQLConsumer.java          # SQL 소비자 인터페이스
│   │       └── SQLTransaction.java       # 트랜잭션 인터페이스
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── admin/                    # 관리자 JSP 뷰
│       │   ├── includes/                 # 공통 JSP 프래그먼트 (header, footer 등)
│       │   └── lib/                      # JAR 라이브러리
│       ├── assets/
│       │   ├── css/                      # 스타일시트
│       │   ├── js/                       # 자바스크립트
│       │   ├── img/                      # 이미지 리소스
│       │   └── admin/                    # 관리자 정적 리소스
│       ├── index.jsp                     # 메인 페이지
│       ├── about.jsp                     # 소개 페이지
│       ├── member/                       # 회원 (로그인, 회원가입, 마이페이지 등)
│       ├── product/                      # 상품 (목록, 상세)
│       ├── orders/                       # 주문 (장바구니, 주문, 결제)
│       └── service/                      # 고객센터 (이용약관, 이용안내, 공지사항)
└── cloud-setup.md                        # 클라우드 서버 설정 가이드
```

## 🚀 시작하기

### 사전 요구사항

- **JDK** 17 이상
- **Apache Tomcat** 9.x
- **MySQL** 8.x
- **Eclipse** (또는 IntelliJ 등 Java IDE)

### 1. 프로젝트 클론

```bash
git clone https://github.com/kahyou22/dodram-jsp.git
```

### 2. 데이터베이스 설정

MySQL에서 데이터베이스를 생성하고 스키마를 적용합니다.

```sql
CREATE DATABASE dodram_db;
```

```bash
mysql -u root -p dodram_db < sql/member.sql
```

### 3. DB 접속 정보 설정

`src/main/java/local.env.example`을 복사하여 `local.env`를 생성하고, 본인의 DB 정보를 입력합니다.

```properties
JDBC_URL=jdbc:mysql://localhost:3306/dodram_db?serverTimezone=UTC&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true
JDBC_USERNAME=본인아이디
JDBC_PASSWORD=본인비밀번호
```

> **참고**: 운영 환경에서는 `local.env` 대신 시스템 환경변수(`JDBC_URL`, `JDBC_USERNAME`, `JDBC_PASSWORD`)를 사용합니다.  
> DB 설정은 `환경변수` → `local.env` 순서로 우선적용됩니다.

### 4. Tomcat에서 실행

Eclipse에서 프로젝트를 Tomcat 서버에 추가하고 실행합니다.

```
http://localhost:8080/dodram-jsp
```

## 📖 주요 페이지

### 🛒 쇼핑몰

| 페이지 | 경로 | 설명 |
|--------|------|------|
| 메인 | `/` | 추천상품, 선물세트, 도드람소식 등 |
| 소개 | `/about` | 브랜드 소개 |
| 상품 목록 | `/product/product_list_*` | 카테고리별 상품 목록 (7개 카테고리) |
| 상품 상세 | `/product/product_*` | 상품 상세 정보 |
| 로그인 | `/member/login` | 회원 로그인 |
| 회원가입 | `/member/register` | 신규 회원가입 |
| 마이페이지 | `/member/mypage` | 주문내역, 쿠폰, 적립금, 위시리스트 등 |
| 장바구니 | `/orders/cart` | 장바구니 |
| 주문 | `/orders/new_order` | 주문/결제 |
| 이용안내 | `/service/guide` | 이용안내 |
| 이용약관 | `/service/agreement` | 이용약관 |

### ⚙️ 관리자 페이지

| 페이지 | 경로 | 설명 |
|--------|------|------|
| 로그인 | `/admin/signin` | 관리자 로그인 |
| 대시보드 | `/admin/main` | 관리자 메인 |
| 회원 관리 | `/admin/users` | 회원 목록/상세 |
| 상품 관리 | `/admin/products` | 상품 CRUD |
| 주문 관리 | `/admin/orders` | 주문 목록/상세 |
| 문의 관리 | `/admin/inquiries` | 1:1 문의 관리 |

## 🔐 인증 & 보안

- **관리자 세션**: `DD_ADMIN_AUTH` 키로 쇼핑몰 사용자 세션과 분리
- **세션 타임아웃**: 30분
- **비밀번호 암호화**: jBCrypt를 이용한 해싱
- **세션 고정 공격 방지**: 로그인 시 세션 재생성

## ☁️ 배포 (CI/CD)

GitHub Actions를 통해 `main` 브랜치에 push 시 자동 배포됩니다.

**배포 흐름:**

```
Push to main → GitHub Actions → Java 컴파일 → WAR 패키징 → SCP 전송 → Tomcat 재시작
```

### GitHub Secrets 설정

| Secret | 설명 |
|--------|------|
| `OCI_SSH_PRIVATE_KEY` | Oracle Cloud 서버 SSH 프라이빗 키 |
| `OCI_HOST` | 서버 호스트 주소 |
| `OCI_USER` | SSH 접속 사용자명 |

### 서버 환경

- **OS**: Ubuntu 24.04 LTS (Oracle Cloud)
- **WAS**: Apache Tomcat 9.0.115 (`/opt/tomcat`)
- **DB 환경변수**: Tomcat systemd 서비스 파일에 설정 ([상세 가이드](CLOUD-SETUP.md))

## 📄 라이선스

이 프로젝트는 학습 목적으로 제작되었습니다.
