FROM registry.gitlab.com/pages/hugo/hugo_extended:latest
RUN apk add --update --no-cache git
RUN apk add --update npm
#WORKDIR /src
ENTRYPOINT /usr/bin/hugo