### Tomcat systemd 서비스 확인
```bash
# systemctl 서비스로 등록되어 있는지 확인
sudo systemctl status tomcat
```


### DB 환경변수 설정
```bash
# Tomcat 서비스 파일 편집
sudo vi /etc/systemd/system/tomcat.service
```

[Service] 섹션에 아래 내용을 추가합니다:
```bash
[Service]
Environment="JDBC_URL=jdbc:mysql://DB서버주소:3306/DB명?serverTimezone=UTC&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true"
Environment="JDBC_USERNAME=DB유저명"
Environment="JDBC_PASSWORD=DB비밀번호"
```

설정 후 반영
```bash
sudo systemctl daemon-reload
sudo systemctl restart tomcat
```