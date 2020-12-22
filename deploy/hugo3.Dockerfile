FROM registry.gitlab.com/pages/hugo/hugo_extended:latest
#WORKDIR /deploy
RUN apk add --update --no-cache git
RUN apk add --update npm &&\
    pwd && \
    ls /workspace &&\
    npm install /
#WORKDIR /src
ENTRYPOINT /usr/bin/hugo