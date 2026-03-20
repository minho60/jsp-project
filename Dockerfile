# 1. Build Stage: Gradle을 사용하여 WAR 파일 생성
FROM gradle:8.5-jdk17 AS build
WORKDIR /app

# 빌드 캐시 효율을 위해 설정 파일들을 먼저 복사
# 파일이 없을 경우를 대비해 와일드카드(*)를 사용합니다.
COPY build.gradle* settings.gradle* /app/
COPY src /app/src

# 순수 JSP/Servlet 프로젝트를 WAR로 빌드 (테스트는 제외)
# 만약 권한 문제가 발생하면 RUN chmod +x gradlew 를 추가할 수 있습니다.
RUN gradle clean war -x test --no-daemon

# 2. Run Stage: 톰캣에 빌드된 WAR 배포
FROM tomcat:9.0-jdk17-corretto
WORKDIR /usr/local/tomcat

# 톰캣 기본 제공 앱(기본 메인화면 등) 삭제 (보안 및 경로 충돌 방지)
RUN rm -rf webapps/*

# 빌드 단계에서 생성된 .war 파일을 톰캣의 ROOT.war로 복사
# 이렇게 하면 접속 시 주소 뒤에 파일명 없이 바로 (/) 접속 가능합니다.
COPY --from=build /app/build/libs/*.war webapps/ROOT.war

# 환경 설정
ENV TZ=Asia/Seoul

# 톰캣의 기본 포트 8080 노출
EXPOSE 8080

# 톰캣 실행
CMD ["catalina.sh", "run"]