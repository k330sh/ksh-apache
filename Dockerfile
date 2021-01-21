[root@server2 LABs]# mkdir apache_test
[root@server2 LABs]# cd apache_tset
-bash: cd: apache_tset: No such file or directory
[root@server2 LABs]# cd apache_test
[root@server2 apache_test]# vi test.html

<!DOCTYPE html>
<html lang="en">
<head>
        <meta charset="UTF-8">
        <title>"Hi ~ Docker!"</title>
</head>
<body>
        <h1>"Welcome to Docker World!"</h1>
</body>
</html>

[root@server2 apache_test]# vi Dockerfile_http
FROM ubuntu:14.04
MAINTAINER "lisemara <lisemara765@gmail.com>"
LABEL "purpose"="webserver practice"
RUN apt-get update
RUN apt-get install apache2 -y
ADD test.html /var/www/html
WORKDIR /var/www/html
RUN ["/bin/bash", "-c", "echo hello >> test.html"]
EXPOSE 80
CMD apachectl -D FOREGROUND

[root@server2 apache_test]# docker build -f Dockerfile_http -t my-apache:2.0 .
Successfully tagged my-apache:2.0

[root@server2 apache_test]# docker run -d -P --name myapacheserver my-apache:2.0
34063d3bd7d44b218242db2cd4855a227a678d38a03ed92bb681372ff5b87c5c

[root@server2 apache_test]# docker port my-apache:2.0
Error: No such container: my-apache:2.0
[root@server2 apache_test]# docker port myapacheserver
80/tcp -> 0.0.0.0:49153

[root@server2 apache_test]# docker image tag my-apache:2.0 lisemara/my-apache:2.0
[root@server2 apache_test]# docker images
REPOSITORY                   TAG          IMAGE ID       CREATED             SIZE
my-apache                    2.0          a46c4a841bc2   5 minutes ago       221MB
lisemara/my-apache           2.0          a46c4a841bc2   5 minutes ago       221MB
[root@server2 apache_test]# docker push lisemara/my-apache:2.0
