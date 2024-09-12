# Use Node.js 20.9.0 base image
FROM node:20.9.0-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) if present
COPY package*.json ./

RUN npm install -g yarn
# Install dependencies (including dev dependencies for TypeScript compilation)
RUN yarn install

# Copy the rest of your application code
COPY . .

# Install TypeScript globally
RUN npm install -g typescript

# Compile TypeScript to JavaScript
RUN npm run build

# Remove dev dependencies (optional if they shouldn't be in the final image)
RUN npm prune --production

# Expose the port your app runs on (modify if different)
EXPOSE 3000

# Start the application (modify based on how you run your app)
CMD ["npm", "start"]

