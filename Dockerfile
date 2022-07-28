FROM openjdk:17 AS base
WORKDIR /app
EXPOSE 8080

FROM openjdk:17 AS build
WORKDIR /src
COPY . .
RUN ./mvnw package

FROM base AS final
WORKDIR /app
COPY --from=build /src/target .

ENTRYPOINT ["java","-jar","app-0.0.1-SNAPSHOT.jar"]