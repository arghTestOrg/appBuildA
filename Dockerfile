# Use an official OpenJDK 21 runtime as a parent image
FROM eclipse-temurin:21-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Annotation
LABEL org.opencontainers.image.source = "https://github.com/arghTestOrg/appBuildA"

# Copy the jar file from the target directory to the container
COPY target/*.jar app.jar

# Create a file inside the container with a description of the app
RUN echo "This is a Spring Boot CRUD application that connects to MongoDB and provides a basic customer management system." > wizexercise.txt

# Expose port 8080 to the outside world
EXPOSE 8080

# Run the jar file - chk options to add for remote debugging
ENTRYPOINT ["java", "-jar", "app.jar"]
