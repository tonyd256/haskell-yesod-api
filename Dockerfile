FROM thoughtbot/yesod

RUN mkdir -p /app
WORKDIR /app

COPY *.cabal ./
RUN cabal install --dependencies-only -j4 --enable-tests
