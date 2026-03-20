# 톰캣 9.0 (JDK 17 포함) 이미지 사용
FROM tomcat:9.0-jdk17-corretto

# 1. 기존 톰캣 기본 앱 삭제 (ROOT 경로 충솔 방지)
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. 프로젝트의 웹 자원 복사
# 이클립스 프로젝트 구조에 따라 'WebContent' 또는 'webapp'으로 수정하세요.
# 폴더 내부의 모든 내용(WEB-INF, index.jsp 등)을 톰캣 ROOT로 복사합니다.
COPY ./WebContent /usr/local/tomcat/webapps/ROOT

# 3. (선택 사항) 만약 소스 컴파일 결과물이 다른 곳에 있다면 추가 복사
# 보통 이클립스는 빌드된 .class 파일을 WebContent/WEB-INF/classes 에 넣습니다.
# 만약 별도의 build/classes 폴더에 생성된다면 아래 주석을 해제하세요.
# COPY ./build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# 4. 시간대 설정 (한국 시간)
ENV TZ=Asia/Seoul

# 톰캣 기본 포트
EXPOSE 8080

# 톰캣 실행 명령어
CMD ["catalina.sh", "run"]