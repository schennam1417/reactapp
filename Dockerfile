# Step 1: Build the React application
FROM node:22.9.0 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the app files
COPY . .

# Build the app
RUN npm run build

# Step 2: Serve the application with NGINX
FROM nginx:alpine

# Copy the build output to NGINX's HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port that NGINX will run on
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
