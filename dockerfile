# Use Node.js 20.9.0 base image
FROM node:20.9.0-alpine

# Install additional dependencies for alpine
RUN apk add --no-cache bash curl git

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock (or package-lock.json) if present
COPY package*.json ./

# Install dependencies (including dev dependencies for TypeScript compilation)
RUN yarn install

# Copy the rest of your application code
COPY . .

# Install TypeScript globally (if not included in your dev dependencies)
RUN npm install -g typescript

# Compile TypeScript to JavaScript
RUN yarn build

# Remove dev dependencies (optional if they shouldn't be in the final image)
RUN yarn prune --production

# Expose the port your app runs on (modify if different)
EXPOSE 3000

# Start the application (modify based on how you run your app)
CMD ["yarn", "start"]
