# 톰캣 9.0 (JDK 17 포함) 이미지 사용
FROM tomcat:9.0-jdk17-corretto

# 1. 톰캣 기본 앱 삭제 (ROOT 경로 충돌 방지 및 보안)
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. 프로젝트의 웹 자원 복사
# webapp 폴더 내부의 모든 내용(WEB-INF, index.jsp 등)을 톰캣 ROOT로 복사합니다.
COPY ./webapp /usr/local/tomcat/webapps/ROOT

# 3. 시간대 설정 (한국 시간)
ENV TZ=Asia/Seoul

# 톰캣 기본 포트 노출
EXPOSE 8080

# 톰캣 실행 명령어
CMD ["catalina.sh", "run"]