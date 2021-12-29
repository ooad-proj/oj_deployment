FROM ubuntu

RUN apt-get update \
	&& apt-get install -y openjdk-11-jre-headless \
	&& apt-get install -y openjdk-11-jdk-headless \
	&& apt-get install -y python3.8 \
	&& apt-get install -y libseccomp-dev libseccomp2 seccomp

COPY judge-server /usr/local/

WORKDIR /usr/local/judge-server/sandbox

CMD ["java", "-jar", "oj_judge_server.jar"]

EXPOSE 5672 15672