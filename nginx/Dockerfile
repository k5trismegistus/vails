FROM nginx
RUN apt-get update && \
    apt-get install -y apt-utils \
                       locales && \
    sed -i -e 's/# ja_JP.UTF-8/ja_JP.UTF-8/g' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8
RUN mkdir public
ENV LANG ja_JP.UTF-8
ENV LC_TIME C
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./rails.conf /etc/nginx/conf.d/default.conf
