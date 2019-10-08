FROM docker.toomba.nl/toomba-labs/commandbox:master

# FusionReactor settings
ENV FR_ENABLE "false"
ENV FR_LICENSEKEY ""
ENV FR_PORT "8088"
ENV BOX_INSTALL "false"

COPY . ${APP_DIR}

# FusionReactor port
EXPOSE ${FR_PORT}

RUN cd ${APP_DIR} \
    && box install \
    && rm -rf box.json