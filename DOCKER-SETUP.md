# Docker 배포 설정 가이드

## 서버 구조

```
서버 (Oracle Cloud Ubuntu)
│
├── ~/nginx-proxy/          ← 별도 프로젝트로 관리
│   ├── docker-compose.yml
│   └── conf.d/
│       └── dodram.conf
│
└── ~/dodram-jsp/           ← 이 프로젝트 (GitHub Actions 자동 배포)
    ├── docker-compose.yml
    ├── Dockerfile
    └── .env
```

---

## 사전 준비 (서버에서 1회만 실행)

### 1. 기존 MySQL 데이터 백업
```bash
mysqldump -u root -p dodram_db > ~/dodram_db_backup.sql
```

### 2. Docker 설치
```bash
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER

# 로그아웃 후 다시 로그인
exit
```

### 3. 공유 Docker 네트워크 생성
```bash
docker network create nginx-proxy
```

### 4. Nginx 프록시 세팅 (별도 프로젝트)
```bash
mkdir -p ~/nginx-proxy/conf.d

cat > ~/nginx-proxy/docker-compose.yml << 'EOF'
services:
  nginx:
    image: nginx:alpine
    container_name: nginx-proxy
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./conf.d:/etc/nginx/conf.d:ro
    networks:
      - nginx-proxy
    restart: unless-stopped

networks:
  nginx-proxy:
    external: true
EOF

cat > ~/nginx-proxy/conf.d/dodram.conf << 'EOF'
server {
    listen 80;
    server_name _;

    client_max_body_size 20M;

    location / {
        proxy_pass         http://dodram-tomcat:8080;
        proxy_set_header   Host              $host;
        proxy_set_header   X-Real-IP         $remote_addr;
        proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
EOF

cd ~/nginx-proxy
docker compose up -d
```

### 5. .env 파일 작성
```bash
mkdir -p ~/dodram-jsp
cd ~/dodram-jsp

cat > .env << 'EOF'
DB_ROOT_PASSWORD=여기에_루트비밀번호
DB_NAME=dodram_db
DB_USER=여기에_DB유저명
DB_PASSWORD=여기에_DB비밀번호
EOF
```

### 6. 기존 서비스 중지
```bash
sudo systemctl stop tomcat
sudo systemctl stop mysql
sudo systemctl disable tomcat
sudo systemctl disable mysql
```

### 7. Git Push (배포는 자동)
```bash
# 로컬(PC)에서 실행
git checkout -b docker
git add .
git commit -m "ci: Docker 배포 구성 추가"
git push origin docker
```

### 8. 배포 확인
```bash
docker compose -f ~/nginx-proxy/docker-compose.yml ps
docker compose -f ~/dodram-jsp/docker-compose.yml ps
```

### 9. 기존 DB 데이터 복원
```bash
docker exec -i dodram-mysql mysql -u root -p'루트비밀번호' dodram_db < ~/dodram_db_backup.sql
```

---

## 접속 정보

| 서비스 | 접속 주소 |
|--------|----------|
| 웹사이트 | http://서버IP/ |
| phpMyAdmin | http://서버IP:8081/ |

---

## 유용한 명령어

```bash
# 프로젝트 로그
cd ~/dodram-jsp && docker compose logs -f tomcat

# 프로젝트 재시작
cd ~/dodram-jsp && docker compose restart

# Nginx 로그
cd ~/nginx-proxy && docker compose logs -f

# Nginx 설정 reload
docker exec nginx-proxy nginx -s reload
```
