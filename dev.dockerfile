FROM mcr.microsoft.com/dotnet/core/sdk 

LABEL author = "nithin_manuel"

ENV ASPNETCORE_URLS=http://*:5000
ENV DOTNET_USE_POLLING_FILE_WATCHER=1
ENV ASPNETCORE_ENVIORNMENT=development

WORKDIR /app

ENTRYPOINT [ "/bin/bash", "-c", "dotnet restore && dotnet watch run" ]

# build the image using 
# sudo docker build -t nithin_manuel/aspdotnetapp:1.0 -f dev.dockerfile .
# the -t image_name can chnage it 1:0 is the version , version is needed otherwise it will allways considered as latest 
# to run the image using 
# sudo docker run -p 8081:5000 -v $(pwd):/app nithin_manuel/aspdotnetapp:1.0 
# sudo docker run -p 8081:5000 -v $(pwd):/app nithin_manuel/aspdotnetapp:2.0
#a_project