# Use Tomcat official image
FROM tomcat:10.1.14-jdk11

# Remove default web apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file to Tomcat
COPY target/maven-web-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080


CMD ["catalina.sh", "run"]
