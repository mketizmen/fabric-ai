FROM alpine:latest
WORKDIR /app
RUN apk update && \
    apk upgrade && \
    apk add git curl && \
    git clone https://github.com/danielmiessler/fabric && \
    mv fabric/patterns patterns && \
    rm -rf fabric
RUN curl -L https://github.com/danielmiessler/fabric/releases/latest/download/fabric-linux-amd64 > fabric && chmod +x fabric
RUN mkdir -p .config/fabric && \
    ls -la .config/fabric/
    
EXPOSE 8080
	
ENTRYPOINT ["/app"]
CMD ["--serve"]
