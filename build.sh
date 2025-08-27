#!/bin/bash
set -e   # Exit immediately if any command fails

# 1. Update & install dependencies
apt-get update
apt-get install -y wget apt-transport-https software-properties-common

# 2. Add Microsoft package signing key and repo
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# 3. Install .NET 9 SDK and runtime
apt-get update
apt-get install -y dotnet-sdk-9.0 dotnet-runtime-9.0

# 4. Verify installation
dotnet --list-sdks
dotnet --list-runtimes

# 5. Build the project
dotnet build

# 6. Publish the project
dotnet publish -c Release -r linux-x64 --self-contained false -o ./publish

# 7. Run the published application
dotnet ./publish/DemoHost.dll --urls "http://0.0.0.0:5000"

echo "Build & publish completed. Check the ./publish folder."
