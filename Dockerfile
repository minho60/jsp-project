# 톰캣 9.0 (JDK 17 포함) 이미지 사용
FROM tomcat:9.0-jdk17-corretto

# 1. 기존 톰캣 기본 앱 삭제
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. 프로젝트의 웹 자원 복사 (webapp 폴더 통째로)
# 깃허브에 있는 webapp 폴더 내용을 톰캣의 ROOT 경로로 복사합니다.
COPY ./webapp /usr/local/tomcat/webapps/ROOT

# 3. 시간대 설정 (한국 시간)
ENV TZ=Asia/Seoul

# 톰캣 기본 포트
EXPOSE 8080

# 톰캣 실행 명령어
CMD ["catalina.sh", "run"]