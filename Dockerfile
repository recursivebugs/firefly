# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# Install any tools you might need (optional)
RUN apt-get update && apt-get install -y curl wget
RUN echo "X5O!P%@AP[4\\PZX54(P^)7CC)7}\$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!\$H+H*" > /tmp/eicar.com


# Copy the welcome page HTML to the NGINX default directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
