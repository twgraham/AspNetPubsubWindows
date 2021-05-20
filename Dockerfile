FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

WORKDIR /AspNetPubsubWindows
COPY ./ .
RUN dotnet publish -c Release

FROM mcr.microsoft.com/dotnet/aspnet:5.0-windowsservercore-ltsc2019
ARG runtime=win-x64
ENV APP_DIR /var/aspnet/AspNetPubsubWindows/
WORKDIR ${APP_DIR}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]


# Add the published web application
COPY --from=build /AspNetPubsubWindows/bin/Release/net5.0/win-x64/publish $APP_DIR

# Expose ports
EXPOSE 80

ENTRYPOINT ["dotnet", "AspNetPubsubWindows.dll"]