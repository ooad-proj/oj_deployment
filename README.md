# OJ Deployment

### Quick Start

Make sure you have installed `docker-compose`. Then, simply run following commands:

`git clone https://github.com/ooad-proj/oj_deployment.git`

Clone this project to a suitable path that data will store there later.

`cd oj_deployment`

Entering folder.

`docker-compose up`

Launch docker-compose with offered `docker-compose.yml`.



### Customize

In `/raw` folder, we provide default docker build material. If you can not access to docker hub normally or you just want to customize, run `docker build -t wzy1935/oj-backend:v1 .` in `/raw/oj-backend` to build backend container, run `docker build -t wzy1935/judge-server:v1 .` in `/raw/oj-judge-server` to build judge server container.

If you want to use more than one judge server, simply modify `docker-compose.yml`. For example, add these code behind the original file:

```dockerfile
  judgeserver1:
    image: wzy1935/judge-server:v1
    restart: always
    depends_on:
      - "rabbitmq"
    command: ["bash", "./wait-for-it.sh", "rabbitmq:5672", "-t", "5", "--", "java", "-jar", "oj_judge_server.jar"]
```

