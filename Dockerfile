FROM ubuntu:14.04

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install Python
RUN apt-get install -y python-dev python-pip

# Add requirements.txt
ADD requirements.txt /webapp/

# Install uwsgi Python web server
RUN pip install uwsgi
RUN ls webapp/

# Install app requirements
RUN pip install -r /webapp/requirements.txt

# Create app directory
ADD . /webapp

# Set the default directory for our environment
ENV HOME /webapp
WORKDIR /webapp

RUN echo $PORT

#cmd for heroku. $PORT is filled by it
CMD uwsgi --http 0.0.0.0:$PORT --module app:app --processes 1 --threads 1
