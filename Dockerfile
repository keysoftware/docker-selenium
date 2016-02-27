# Debian: Selenium + Firefox + Google Chrome Beta + XVFB

FROM java:openjdk-8

ENV SELENIUM_VERSION 2.49.1

RUN wget http://goo.gl/rQhaxb -O /opt/selenium-server-standalone-${SELENIUM_VERSION}.jar

RUN echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list; \
    apt-get update && apt-get install -y --force-yes firefox; \
    chmod -R +x /opt/firefox/

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -; \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list; \
    apt-get update && apt-get install -y google-chrome-beta;\
    chmod -R +x /opt/google/

RUN apt-get update && apt-get install -y xvfb
    
ADD run.sh /bin/

EXPOSE 4444

ENTRYPOINT ["sh", "/bin/run.sh"]

CMD []
