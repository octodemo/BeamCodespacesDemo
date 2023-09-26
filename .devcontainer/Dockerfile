FROM mcr.microsoft.com/dotnet/sdk:6.0-focal
RUN apt-get update && apt-get install -y gnupg2 vim
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt-get update 
#mssql tools isn't available for arm64 / aarch64
RUN if [ $(arch) != "aarch64" ]; then ACCEPT_EULA=Y apt-get install mssql-tools unixodbc-dev -y; fi