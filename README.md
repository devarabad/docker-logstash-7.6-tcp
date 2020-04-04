# Docker Logstash 7.6 #

# README #

## Running Logstash using Docker ##

### Prerequisites ###
  - Docker Installed
  - For Windows, Shared Volumes must be enabled
    - If you are using Docker Desktop
      1. Go to Docker Dashboard
      2. Go to Resources > File Sharing
      3. Check the Drive you want to be shared

## Running Logstash using Default Image ##
1. Pull the logstash image
```
$ docker pull docker.elastic.co/logstash/logstash:7.6.1
```
2. Run the container (Using Default Configuration)
  - Default is using the FileBeat pipeline
```
$ docker run -p 9600:9600 docker.elastic.co/logstash/logstash:7.6.1
```

## Running Logstash using Modified Image (TCP input plugin installed) ##

Since the logstash image has no tcp plugins installed 
We need to create a custom image with the logstash-input-tcp installed

1. Create and build a custom image from the source image (see Dockerfile)
```
$ docker build -t logstash-tcp:7.6.1 .
```

2. Since we have installed the tcp plugin, we may need to configure the pipelines (see /pipeline/logstash.conf)
```
# Run the container (Using TCP Pipeline)
# Mac
$ docker run --rm -p 9563:9563 -it -v pipeline/:/usr/share/logstash/pipeline/ logstash-tcp:7.6.1

# Windows
$ docker run --rm -p 9563:9563 -it -v {absolute_path_of_pipeline_folder}:/usr/share/logstash/pipeline/ logstash-tcp:7.6.1
Eg.
$ docker run --rm -p 9563:9563 -it -v C:/Users/Andrew/ws/_dev/docker/logstash/pipeline:/usr/share/logstash/pipeline/ logstash-tcp:7.6.1
```

3. Send logs using the sample python program
```
$ python send-message-to-logstash.py
```

4. Logs will be written within the container under /usr/share/logstash/server/log/output.log
```
# To check, connect to the container
$ docker container ls
$ docker exec -it {container_id} /bin/bash
$ ls -lah /usr/share/logstash/server/log/
$ cat /usr/share/logstash/server/log/output.log
```

## References ##
  - Running Logstash on Docker
    https://www.elastic.co/guide/en/logstash/current/docker.html
  - Reloading the Config File
    https://www.elastic.co/guide/en/logstash/current/reloading-config.html
  - Logstash TPC Plugin
    https://www.elastic.co/guide/en/logstash/current/plugins-inputs-tcp.html
  - Working with Plugins
    https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html
  - Configuring Logstash for Docker
    https://www.elastic.co/guide/en/logstash/current/docker-config.html
  - Sample Code - Send logs to Logstash
    https://gist.github.com/jgoodall/6323951