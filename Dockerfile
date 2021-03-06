FROM docker.io/bitnami/minideb:buster


# Install required system packages and dependencies
RUN install_packages ca-certificates curl procps sudo unzip wget
RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/kubectl-1.13.4-0-linux-amd64-debian-10.tar.gz && \
    echo "6dbb8a52c0a709f5e979b8e143c86a4c41a69c848e14425e8953805b06e3603d  /tmp/bitnami/pkg/cache/kubectl-1.13.4-0-linux-amd64-debian-10.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/kubectl-1.13.4-0-linux-amd64-debian-10.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/kubectl-1.13.4-0-linux-amd64-debian-10.tar.gz

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install apache2-utils gnupg2 jq software-properties-common -y
RUN apt-get update && apt-get upgrade -y 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64 
RUN add-apt-repository ppa:rmescandon/yq
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install yq -y
RUN rm -r /var/lib/apt/lists /var/cache/apt/archives

RUN chmod +x /opt/bitnami/kubectl/bin/kubectl
ENV BITNAMI_APP_NAME="kubectl" \
    BITNAMI_IMAGE_VERSION="1.13.4-debian-10-r61" \
    PATH="/opt/bitnami/kubectl/bin:/bin:$PATH"latest

USER 1001
CMD [ "bash" ]
