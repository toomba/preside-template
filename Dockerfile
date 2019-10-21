FROM docker.toomba.nl/toomba-labs/commandbox:master

RUN box install

EXPOSE 8088

COPY . ${APP_DIR}