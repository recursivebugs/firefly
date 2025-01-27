# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# Copy the welcome page HTML to the NGINX default directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
