FROM ubuntu:20.04

ARG UNAME=testuser
ARG GNAME=testgroup
ARG UID=1000
ARG GID=1001
ARG TZ=America/New_York
ARG PYFA_VERSION="v2.40.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -q -y install libgtk-3-dev python3 python3-dev pkg-config curl python3-pip
RUN pip3 install pathlib2


RUN curl -L https://github.com/pyfa-org/Pyfa/archive/refs/tags/${PYFA_VERSION}.tar.gz -o /pyfa.tar.gz
RUN mkdir -p /usr/share/pyfa
RUN tar xf /pyfa.tar.gz -C /usr/share/pyfa --strip-components=1
RUN rm pyfa.tar.gz

RUN pip3 install -r /usr/share/pyfa/requirements.txt

RUN /usr/bin/python3 /usr/share/pyfa/db_update.py

RUN mkdir -p /usr/local/bin
COPY pyfa /usr/local/bin/pyfa
RUN chmod a+x /usr/local/bin/pyfa

RUN apt-get -q -y install locales locales-all language-pack-en
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure locales

RUN groupadd -g ${GID} ${GNAME}
RUN useradd -ms /bin/bash -u ${UID} -g ${GID} ${UNAME}
USER ${UNAME}:${GNAME}

CMD ["/usr/bin/sh", "-c", "/usr/local/bin/pyfa"]

RUN echo "Finished building dockerized pyfa for ${UNAME}($UID):${GNAME}($GID) TZ=${TZ} PYFA_VERSION=${PYFA_VERSION}"
