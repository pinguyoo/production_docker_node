#syntax=docker/dockerfile:experimental

FROM node:16.14.2-alpine3.15 as builder

RUN apk add --no-cache --verbose && corepack enable
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN yarn install && yarn workspaces focus --production --all

FROM node:16.14.2-alpine3.15
LABEL maintainer NAME
ENV NODE_ENV production
WORKDIR /usr/src/app
RUN apk add --no-cache --verbose bash su-exec
COPY --from=builder /usr/src/app/node_modules node_modules
COPY --from=builder /usr/src/app/entrypoint.sh /usr/local/bin/entrypoint.sh