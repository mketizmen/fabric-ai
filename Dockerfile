FROM golang:1.24-alpine
WORKDIR /app
RUN apk update && \
    apk upgrade && \
    apk add git curl libc6-compat && \
    git clone https://github.com/danielmiessler/fabric && \
    mv fabric/patterns patterns && \
    rm -rf fabric
RUN curl -L https://github.com/danielmiessler/fabric/releases/latest/download/fabric-linux-amd64 > fabric && chmod +x fabric
RUN mkdir -p .config/fabric && \
    ls -la .config/fabric/

ENV PATTERNS_LOADER_GIT_REPO_URL=https://github.com/danielmiessler/fabric.git
ENV PATTERNS_LOADER_GIT_REPO_PATTERNS_FOLDER=/app/patterns
ENV PROMPT_STRATEGIES_GIT_REPO_URL=https://github.com/danielmiessler/fabric.git
ENV PROMPT_STRATEGIES_GIT_REPO_STRATEGIES_FOLDER=/app/strategies

EXPOSE 8080
	
ENTRYPOINT ["/app/fabric"]
CMD ["--serve"]
