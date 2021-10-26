FROM registry.redhat.io/ubi8/dotnet-50 AS build
WORKDIR /src
COPY ["TestOpenShiftWebAPI/TestOpenShiftWebAPI.csproj", "TestOpenShiftWebAPI/"]
USER root
RUN dotnet restore "TestOpenShiftWebAPI/TestOpenShiftWebAPI.csproj"
COPY . .
WORKDIR "/src/TestOpenShiftWebAPI"
RUN dotnet publish "TestOpenShiftWebAPI.csproj" -c Release -o /app/publish


FROM registry.redhat.io/ubi8/dotnet-50-runtime:5.0-27 AS base
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "TestOpenShiftWebAPI.dll"]