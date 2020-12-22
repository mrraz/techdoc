FROM registry.gitlab.com/pages/hugo/hugo_extended:0.79.1
RUN apk add --update --no-cache git
RUN apk add --update npm
ENTRYPOINT /usr/bin/hugo