FROM ubuntu:16.04
MAINTAINER Matthew Baltrusitis <matthew@baltrusitis.com>

ENV DEBIAN_FRONTEND="noninteractive"

ENV APP_DIR=/opt/uns
ENV CONFIGS=/opt/unsdata

RUN mkdir -p "${CONFIGS}" "${APP_DIR}" \
    && apt-get -qy update \
    && apt-get install -qy --fix-missing \
        git \
				python \
				python-pip \
			  python-openssl \
		&& cd "${APP_DIR}" \
    && git clone https://github.com/Mirabis/usntssearch.git

ADD ["config.default.ini", "/opt/unsdata/custom_params.ini"]

RUN ln -s /opt/unsdata/custom_params.ini "${APP_DIR}"/usntssearch/NZBmegasearch/

VOLUME ["${CONFIGS}"]
EXPOSE 5000

WORKDIR /opt/uns/usntssearch

CMD ["python", "NZBmegasearch/mega2.py"]

