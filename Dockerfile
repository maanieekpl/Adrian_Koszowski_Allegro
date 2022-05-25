# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.sln .
COPY Adrian.Koszowski.Service1/Adrian.Koszowski.Service1.csproj ./Adrian.Koszowski.Service1/
COPY Adrian.Koszowski.Service2/Adrian.Koszowski.Service2.csproj ./Adrian.Koszowski.Service2/
COPY Adrian.Koszowski.Service3/Adrian.Koszowski.Service3.csproj ./Adrian.Koszowski.Service3/

# copy everything else and build app
COPY Adrian.Koszowski.Service1/ ./Adrian.Koszowski.Service1/
COPY Adrian.Koszowski.Service2/ ./Adrian.Koszowski.Service2/
COPY Adrian.Koszowski.Service3/ ./Adrian.Koszowski.Service3/

RUN dotnet restore

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnetapp.dll"]

