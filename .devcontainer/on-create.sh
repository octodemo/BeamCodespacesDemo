cd "$1"
dotnet restore
cd Beam.Server
dotnet tool restore
dotnet ef database update 
dotnet dev-certs https