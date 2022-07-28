ARG VARIANT=17-bullseye

FROM mcr.microsoft.com/vscode/devcontainers/java:${VARIANT} AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/vscode/devcontainers/java:${VARIANT} AS build
WORKDIR /src
COPY . .
RUN ./mvnw package

FROM base AS final
WORKDIR /app
COPY --from=build /src/target .

ENTRYPOINT ["java","-jar","app-0.0.1-SNAPSHOT.jar"]