# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
#COPY *.sln .
#COPY Adrian.Koszowski.Service1/Adrian.Koszowski.Service1.csproj ./Adrian.Koszowski.Service1/
#COPY Adrian.Koszowski.Service2/Adrian.Koszowski.Service2.csproj ./Adrian.Koszowski.Service2/
#COPY Adrian.Koszowski.Service3/Adrian.Koszowski.Service3.csproj ./Adrian.Koszowski.Service3/

#COPY Adrian.Koszowski.Service1.Tests/Adrian.Koszowski.Service1.Tests.csproj ./Adrian.Koszowski.Service1.Tests/
#COPY Adrian.Koszowski.Service2.Tests/Adrian.Koszowski.Service2.Tests.csproj ./Adrian.Koszowski.Service2.Tests/
#COPY Adrian.Koszowski.Service3.Tests/Adrian.Koszowski.Service3.Tests.csproj ./Adrian.Koszowski.Service3.Tests/

# copy everything else and build app
#COPY Adrian.Koszowski.Service1.Tests/ ./Adrian.Koszowski.Service1.Tests/
#COPY Adrian.Koszowski.Service2.Tests/ ./Adrian.Koszowski.Service2.Tests/
#COPY Adrian.Koszowski.Service3.Tests/ ./Adrian.Koszowski.Service3.Tests/

#RUN dotnet restore

COPY . ./
RUN dotnet publish Adrian_Koszowski_Allegro -c Release -o out

# Build runtime image
#FROM mcr.microsoft.com/dotnet/aspnet:6.0
#FROM mcr.microsoft.com/dotnet/sdk:6.0
#WORKDIR /app
#RUN mkdir /app
#COPY --from=build-env /app/out ./app
#ENTRYPOINT ["dotnet", "aspnetapp.dll"]


FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /app
COPY --from=build-env /app/Adrian_Koszowski_Allegro/out .

ENTRYPOINT ["dotnet", "Adrian_Koszowski_Allegro.dll"]