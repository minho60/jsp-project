# 1. Build Stage (빌드 단계)
# JDK 17이 포함된 Gradle 이미지를 사용합니다.
FROM gradle:8.5-jdk17 AS build
WORKDIR /app

# 라이브러리 의존성 캐싱을 위해 설정 파일 먼저 복사
COPY build.gradle settings.gradle ./
# 소스 코드 및 웹 리소스(WEB-INF 등) 복사
COPY src ./src

# WAR 파일 빌드 (테스트 제외)
RUN gradle clean war -x test --no-daemon

# 2. Run Stage (실행 단계)
# 톰캣 9.0과 JDK 17이 설치된 경량 이미지를 사용합니다.
FROM tomcat:9.0-jdk17-corretto
WORKDIR /usr/local/tomcat

# 기존 톰캣 기본 앱들 삭제 (선택 사항: 보안 및 깔끔한 환경을 위함)
RUN rm -rf webapps/*

# 빌드 단계에서 생성된 .war 파일을 톰캣의 ROOT.war로 복사
# 이렇게 하면 접속 시 경로 뒤에 프로젝트명을 붙이지 않고 바로 (/) 접속이 가능합니다.
COPY --from=build /app/build/libs/*.war webapps/ROOT.war

# MySQL 8.0 연결을 위한 타임존 및 환경 설정
ENV TZ=Asia/Seoul
EXPOSE 8080

# 톰캣 실행
CMD ["catalina.sh", "run"]