FROM bitnami/kubectl:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install apache2-utils
