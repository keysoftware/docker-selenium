# Debian: Selenium + Firefox + Google Chrome Beta + XVFB

# Pull the base image.
FROM java:openjdk-8

# Set environment variables.
ENV SELENIUM_VERSION 2.49.1

# Install Selenium.
RUN wget http://goo.gl/rQhaxb -O /opt/selenium-server-standalone-${SELENIUM_VERSION}.jar

# Install Firefox.
RUN echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list; \
    apt-get update && apt-get install -y --force-yes firefox; \
    chmod -R +x /opt/firefox/

# Install Google Chrome Beta.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -; \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list; \
    apt-get update && apt-get install -y google-chrome-beta;\
    chmod -R +x /opt/google/

# Install XVFB.
RUN apt-get update && apt-get install -y xvfb

# Clean APT.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add /bin.
ADD run.sh /bin/

# Expose ports.
EXPOSE 4444

# Configure executable.
ENTRYPOINT ["sh", "/bin/run.sh"]

# Define default command.
CMD []
