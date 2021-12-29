FROM openjdk:11.0.4
ADD backend/oj_backend.jar oj_backend.jar
EXPOSE 8082 5672 6379
CMD ["java","-jar","oj_backend.jar"]