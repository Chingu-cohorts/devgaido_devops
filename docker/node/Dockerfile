FROM mhart/alpine-node:6.10
# FROM mhart/alpine-node:6
RUN apk update \
  && apk add curl git bash binutils tar \
  && rm -rf /var/cache/apk/* \
  && /bin/bash \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && apk del curl tar binutils \
  && git clone https://github.com/Chingu-cohorts/devgaido.git
  
#ADD . ./devgaido

WORKDIR /devgaido

ENV PATH /root/.yarn/bin:$PATH
ENV PORT 8080
ENV AUTH0_CLIENT_ID L90m0rEGvEWnCkQOBYE3U30J6m68HDIb
ENV AUTH0_DOMAIN devgaido.auth0.com
ENV AUTH0_CLIENT_SECRET p1EmwSaGtMd-8o_q7XU4nayvO7aNmuh58nIfij5tXpyU8zq9ACT0WOTVGfEb3Tf8
ENV AUTH0_CALLBACK_URL http://localhost/callback
ENV MONGODB_URI mongodb://mongo/devgaido

RUN yarn && yarn build

ENV NODE_ENV production

EXPOSE 8080
CMD ["node", "./dist/server"]