
# https://docs.cloudbees.com/docs/cloudbees-codeship/latest/basic-continuous-integration/browser-testing 
FROM node:16.10

# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt update -y
RUN apt-get install -y wget xvfb unzip libxi6 libgconf-2-4 gnupg2

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/102.0.5005.61/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# Install angular dependencies 
ENV ANGULAR_CLI_VERSION 11.2.14
RUN npm i -g @angular/cli@$ANGULAR_CLI_VERSION 

WORKDIR /app