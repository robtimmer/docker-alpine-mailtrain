FROM robtimmer/alpine-nodejs
MAINTAINER rob@robtimmer.com

# Environment variables
ARG MAILTRAIN_VERSION=1.14.0
ENV NODE_ENV=production

# Download and extract Mailtrain
RUN \
  set -ex && apk add --no-cache curl && \
  cd /tmp && \
  curl -fSL https://github.com/andris9/mailtrain/archive/v${MAILTRAIN_VERSION}.tar.gz -o mailtrain.tar.gz && \
  tar xzf mailtrain.tar.gz && \
  mkdir /opt && \
  mkdir /opt/mailtrain && \
  mv mailtrain-${MAILTRAIN_VERSION}/*  /opt/mailtrain

# Configuration volume
VOLUME ["/opt/mailtrain/config"]

# Set the working directory
WORKDIR /opt/mailtrain

# Install NPM dependencies
RUN npm install --no-progress --production

# Start Mailtrain
ENTRYPOINT ["npm", "start"]
