FROM eclipse-temurin:21-jdk-jammy
VOLUME /tmp
ARG JAR_FILE=target/chat-service-discovery.jar
COPY ${JAR_FILE} chat-service-discovery.jar
ENTRYPOINT ["java","-jar","/chat-service-discovery.jar"]
