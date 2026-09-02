# Step 1: Build the React application
FROM node:20 AS builder

WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project
COPY . .

# Create production build
RUN npm run build


# Step 2: Serve the built app with Nginx
FROM nginx:alpine

# Copy built files from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Nginx uses port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]