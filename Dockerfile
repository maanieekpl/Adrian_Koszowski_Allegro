# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app 
#
# copy csproj and restore as distinct layers
COPY *.sln .
COPY Adrian.Koszowski.Service1/*.csproj ./Adrian.Koszowski.Service1/
COPY Adrian.Koszowski.Service2/*.csproj ./Adrian.Koszowski.Service2/
COPY Adrian.Koszowski.Service3/*.csproj ./Adrian.Koszowski.Service3/

COPY Adrian.Koszowski.Service1.Tests/*.csproj ./Adrian.Koszowski.Service1.Tests/
COPY Adrian.Koszowski.Service2.Tests/*.csproj ./Adrian.Koszowski.Service2.Tests/ 
COPY Adrian.Koszowski.Service3.Tests/*.csproj ./Adrian.Koszowski.Service3.Tests/ 
#
RUN dotnet restore 
#
# copy everything else and build app
COPY Adrian.Koszowski.Service1/. ./Adrian.Koszowski.Service1/
COPY Adrian.Koszowski.Service2/. ./Adrian.Koszowski.Service2/
COPY Adrian.Koszowski.Service3/. ./Adrian.Koszowski.Service3/

COPY Adrian.Koszowski.Service1.Tests/. ./Adrian.Koszowski.Service1.Tests/
COPY Adrian.Koszowski.Service2.Tests/. ./Adrian.Koszowski.Service2.Tests/
COPY Adrian.Koszowski.Service3.Tests/. ./Adrian.Koszowski.Service3.Tests/

#
WORKDIR /app/Adrian.Koszowski.Service1
RUN dotnet publish -c Release -o out 
#
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS runtime
WORKDIR /app 
#
COPY --from=build /app/Adrian.Koszowski.Service1/out ./
ENTRYPOINT ["dotnet", "Adrian.Koszowski.Service1.dll"]