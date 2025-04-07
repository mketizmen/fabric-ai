FROM golang:1.24-alpine
WORKDIR /app
RUN mkdir /root/.config/ && \
    ln -s /app /root/.config/fabric
RUN apk update && \
    apk upgrade && \
    apk add git curl libc6-compat nodejs npm && \
    git clone https://github.com/danielmiessler/fabric && \
    mv fabric/patterns patterns && \
    mv fabric/strategies strategies && \
    mv fabric/web web && \
    rm -rf fabric
RUN curl -L https://github.com/danielmiessler/fabric/releases/latest/download/fabric-linux-amd64 > fabric && chmod +x fabric

RUN cd web && \ 
  npm install

ENV PATTERNS_LOADER_GIT_REPO_URL=https://github.com/danielmiessler/fabric.git
ENV PATTERNS_LOADER_GIT_REPO_PATTERNS_FOLDER=patterns
ENV PROMPT_STRATEGIES_GIT_REPO_URL=https://github.com/danielmiessler/fabric.git
ENV PROMPT_STRATEGIES_GIT_REPO_STRATEGIES_FOLDER=strategies

ENV OPENAI_API_KEY=""
ENV OPENAI_API_BASE_URL="https://api.openai.com/v1"
ENV OLLAMA_API_URL=""
ENV AZURE_API_KEY=""
ENV AZURE_API_BASE_URL=""
ENV AZURE_DEPLOYMENTS=""
ENV AZURE_API_VERSION=""
ENV GROQ_API_KEY=""
ENV GROQ_API_BASE_URL="https://api.groq.com/openai/v1"
ENV GEMINI_API_KEY=""
ENV ANTHROPIC_API_BASE_URL="https://api.anthropic.com/"
ENV ANTHROPIC_API_KEY=""
ENV SILICONCLOUD_API_KEY=""
ENV SILICONCLOUD_API_BASE_URL="https://api.siliconflow.cn/v1"
ENV OPENROUTER_API_KEY=""
ENV OPENROUTER_API_BASE_URL="https://openrouter.ai/api/v1"
ENV LM_STUDIO_API_URL=""
ENV MISTRAL_API_KEY=""
ENV MISTRAL_API_BASE_URL="https://api.mistral.ai/v1"
ENV DEEPSEEK_API_KEY=""
ENV DEEPSEEK_API_BASE_URL="https://api.deepseek.com"
ENV EXOLAB_API_BASE_URL=""
ENV EXOLAB_MODELS=""
ENV LITELLM_API_KEY=""
ENV LITELLM_API_BASE_URL=""
ENV YOUTUBE_API_KEY=""
ENV GIN_MODE=release
RUN env > .env

EXPOSE 8080
	
ENTRYPOINT ["/app/fabric"]
CMD ["--serve"]
