#Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

COPY . .
RUN dotnet restore "./DemoWebapp.csproj" --disable-parallel
RUN dotnet publish "./DemoWebapp.csproj" -c Release -o out --no-restore

# Serve Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "DemoWebapp.dll"]

EXPOSE 5000
