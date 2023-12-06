# Setup environment
1. install java 11
2. install docker, docker-compose
3. install maven

# Getting Started
1. go to folder eflower-backend, ensure this folder contains docker-compose.yml
2. run command: docker-compose up
3. go to database eflower and drop all tables
4. run mvn clean install. it should return 'BUILD SUCCESS'
5. run command: java -jar eflower-1.0.0.jar
6. go to http://localhost:8080/eflower/swagger-ui.html to check API details