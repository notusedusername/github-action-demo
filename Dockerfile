FROM openjdk:21 AS build

COPY . /workspace

WORKDIR /workspace

RUN ./gradlew --no-daemon :build

FROM --platform=linux/arm64 eclipse-temurin:21-alpine

COPY --from=build /workspace/build/libs/demo-*.jar /app/app.jar

WORKDIR app

ENTRYPOINT ["java", "-jar", "app.jar"]