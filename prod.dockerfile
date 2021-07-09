FROM mcr.microsoft.com/dotnet/core/aspnet AS base
WORKDIR /app 

FROM mcr.microsoft.com/dotnet/core/sdk AS build
WORKDIR /src 
COPY ["a_project.csproj", "./"]
RUN dotnet restore "./a_project.csproj"
COPY . . 
WORKDIR "/src/."
RUN dotnet build "a_project.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "a_project.csproj" -c Release -o /app

FROM base AS final 
ENV ASPDOTNETCORE_URLS=http//*:5000
EXPOSE 5000
WORKDIR /app
COPY --from=publish /app .        
ENTRYPOINT [ "dotnet", "a_project.dll" ]


# line number 8 states that the source file and the destination file is the same folder or location 
# the line 19 is tricky becasue the --from=publish /app is a single term and it is the source
# and the destination is '.'(dot) current directory here is the current directory is in line 18 WORKDIR /app 




# to build the image
#  sudo docker build -t nithin/aspdotnetprod:1.0 -f prod.dockerfile . 
# to run the image 
# sudo docker run -p 8082:5000 nithin/aspdotnetprod:1.0 
# sudo docker run -p 5000:80 nithin/aspdotnetprod:1.0 
