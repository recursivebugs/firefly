# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# RUN echo "X5O!P%@AP[4\\PZX54(P^)7CC)7}\$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!\$H+H*" > /tmp/eicar.com

# (Optional) Install anything you need inside the container
RUN apk update && apk add --no-cache curl

# Create a random file so each build has a new digest
RUN echo $RANDOM > /tmp/random-build-file

# Copy the welcome page HTML to the NGINX default directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
