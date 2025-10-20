FROM almalinux:8
LABEL maintainer="QVelix <mmaxbossee@gmail.com>"

RUN dnf install -y libstdc++ ncurses-compat-libs && dnf clean all

#Install firebird
ENV FIREBIRD_RPM_URL=https://github.com/FirebirdSQL/firebird/releases/download/R2_5_9/FirebirdCS-2.5.9.27139-0.amd64.rpm
RUN curl -L "$FIREBIRD_RPM_URL" -o /tmp/firebird.rpm \
  && rpm -ivh --nodeps --replacefiles /tmp/firebird.rpm \
  && rm -f /tmp/firebird.rpm

  RUN ln -sf /dev/stdout /opt/firebird/firebird.log

VOLUME /var/lib/firebird/2.5/data
VOLUME /var/lib/firebird/2.5/backup

EXPOSE 3050

CMD ["/opt/firebird/bin/fbguard"]
