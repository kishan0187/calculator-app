# Use Java 21 JDK base image
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy Java source files from Maven structure
COPY src/main/java/com/example/calculator/*.java src/main/java/com/example/calculator/
COPY src/test/java/com/example/calculator/*.java src/test/java/com/example/calculator/

# Copy the JUnit console launcher jar
COPY junit-platform-console-standalone-1.10.2.jar .

# Compile all Java files; -d out puts .class files under /app/out
RUN mkdir -p out && \
    javac -cp junit-platform-console-standalone-1.10.2.jar \
         -d out \
         src/main/java/com/example/calculator/*.java \
         src/test/java/com/example/calculator/*.java

# Run JUnit 5 tests using the console launcher, scanning all classes in /app/out
CMD ["java", "-jar", "junit-platform-console-standalone-1.10.2.jar", "--class-path", "out", "--scan-class-path"]
