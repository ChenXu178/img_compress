FROM alpine:3.19.1

LABEL maintainer="chenxu.mail@icloud.com"

ENV TZ="Asia/Shanghai"
ENV PGID=100
ENV PUID=1000
ENV UMASK=022
ENV JPG_QUALITY=75
ENV PNG_QUALITY=auto

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk update
RUN apk add --no-cache --update tzdata bash bash-doc bash-completion shadow runuser pngquant jpegoptim parallel util-linux coreutils

RUN mkdir -p ~/.parallel
RUN touch ~/.parallel/will-cite
RUN sed -i 's/ash/bash/g' /etc/passwd
RUN echo "${TZ}" > /etc/timezone

VOLUME /app/data
WORKDIR /app/data

COPY img_compress.sh /bin/img_compress.sh
COPY compress.sh /bin/compress.sh
COPY .bashrc /root/.bashrc

RUN chmod a+x /bin/img_compress.sh
RUN chmod a+x /bin/compress.sh

ENTRYPOINT ["tail", "-f", "/dev/null"]