# Image
FROM tomcat:9-jdk8-corretto⁠

# Copy War file
COPY /home/ubuntu/workspace/Game-of-Life/gameoflife-web/target/gameoflife.war /usr/local/tomcat/webapps

# Port
EXPOSE 8080

# Didn't provide any CMD, i want to use Base Image CMD
