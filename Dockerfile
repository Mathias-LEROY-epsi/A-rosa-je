# Use an official Node.js runtime as the base image
FROM node:14 AS build-stage

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install the app dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the Vue.js app
RUN npm run build

# Use a lightweight HTTP server to serve the built app
FROM nginx:stable-alpine AS production-stage

# Copy the built app from the previous build stage to the Nginx web server
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port 80 for the Nginx web server
EXPOSE 80

# Start the Nginx web server
CMD ["nginx", "-g", "daemon off;"]