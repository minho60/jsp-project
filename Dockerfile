# ============================================================
# Stage 1: Build — WAR 파일 생성
# ============================================================
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /build

# Tomcat 9 Servlet API (컴파일용)
RUN mkdir -p /tmp/tomcat-lib && \
    curl -sL "https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar" \
      -o /tmp/tomcat-lib/javax.servlet-api-4.0.1.jar && \
    curl -sL "https://repo1.maven.org/maven2/javax/servlet/jsp/javax.servlet.jsp-api/2.3.3/javax.servlet.jsp-api-2.3.3.jar" \
      -o /tmp/tomcat-lib/javax.servlet.jsp-api-2.3.3.jar

# 소스 복사
COPY src/ src/

# Java 컴파일
RUN mkdir -p classes && \
    CP=$(find src/main/webapp/WEB-INF/lib -name '*.jar' | tr '\n' ':') && \
    CP="${CP}$(find /tmp/tomcat-lib -name '*.jar' | tr '\n' ':')" && \
    find src/main/java -name '*.java' > /tmp/sources.txt && \
    javac -encoding UTF-8 -d classes -cp "$CP" @/tmp/sources.txt

# WAR 디렉토리 구성
RUN mkdir -p /war && \
    cp -r src/main/webapp/* /war/ && \
    mkdir -p /war/WEB-INF/classes && \
    cp -r classes/* /war/WEB-INF/classes/

# ============================================================
# Stage 2: Runtime — Tomcat 9 + JDK 17
# ============================================================
FROM tomcat:9-jdk17-temurin

# 기본 ROOT 앱 제거
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# 빌드 결과물을 ROOT로 배포
COPY --from=builder /war /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

CMD ["catalina.sh", "run"]
