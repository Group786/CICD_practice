# Stage 1: Build the application
FROM node:20-alpine as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Create a smaller production image
FROM node:20-alpine

WORKDIR /app

# Copy the necessary files from the builder stage
COPY --from=builder /app .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["node", "server.js"]
