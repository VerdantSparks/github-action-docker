# Stage 1
FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS builder
# copy csproj and restore as distinct layers

# copy and build everything else
WORKDIR /source
COPY . .
RUN dotnet publish github-action-docker.csproj -c Release -r linux-x64 -o /app

# Stage 2
FROM mcr.microsoft.com/dotnet/core/aspnet:3.0
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["./github-action-docker"]
