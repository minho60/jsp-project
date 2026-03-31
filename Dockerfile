# --- Stage 1: Build (Java 컴파일 및 WAR 생성) ---
FROM eclipse-temurin:17-jdk AS builder

# 작업 디렉토리 설정
WORKDIR /build

# 프로젝트 소스 복사
COPY . .

# 1. WEB-INF/classes 폴더 생성
# 2. Java 소스 파일 컴파일 (lib 내의 jar 파일들을 classpath에 포함)
# 3. WAR 파일로 압축
RUN mkdir -p src/main/webapp/WEB-INF/classes && \
    javac -d src/main/webapp/WEB-INF/classes \
          -cp "src/main/webapp/WEB-INF/lib/*" \
          $(find src/main/java -name "*.java") && \
    cd src/main/webapp && \
    jar -cvf ../../../ROOT.war *

# --- Stage 2: Run (Tomcat 실행) ---
FROM tomcat:9.0-jdk17-temurin-jammy

# 기본 앱 삭제 후 생성된 WAR 파일 복사
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat 포트 노출
EXPOSE 8080

CMD ["catalina.sh", "run"]