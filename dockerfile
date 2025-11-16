# --- Stage 1: Dependency Installation ---
FROM node:20-alpine as deps
WORKDIR /app
COPY package.json package-lock.json ./
# Install only production dependencies for the final image size optimization
RUN npm install --only=production
# Install all dependencies required for the build (including Vite)
RUN npm install

# --- Stage 2: React Application Build ---
FROM node:20-alpine as builder
WORKDIR /app
COPY . .
# Copy dependencies from the first stage
COPY --from=deps /app/node_modules ./node_modules
# Execute the Vite build command (as defined in your package.json)
RUN npm run build

# --- Stage 3: Final Production Server (Nginx) ---
FROM nginx:alpine
# Copy the built static files from the 'builder' stage into Nginx's html folder
# NOTE: Vite outputs to a directory named 'dist' by default.
COPY --from=builder /app/dist /usr/share/nginx/html

# Nginx listens on port 80 by default
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
