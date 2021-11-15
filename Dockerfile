# STEP1 : BUILDER IMAGE
FROM gradle:7.3.0-jdk17 as builder

WORKDIR .

COPY --chown=gradle:gradle . .

RUN ./gradlew bootJar --no-daemon

RUN echo $(ls)

#STEP RUNNER IMAGE
FROM openjdk

COPY --from=builder /home/gradle/build/libs/cs322-0.0.1-SNAPSHOT.jar .

ENTRYPOINT ["java" ,"-jar","-Dserver.port=${PORT}", "cs322-0.0.1-SNAPSHOT.jar"]