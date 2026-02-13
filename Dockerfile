# Use a standard Debian-based Node image (NOT Alpine)
FROM node:22-bookworm

# Install the build tools OpenClaw needs to compile AI components
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy your package.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your code
COPY . .

# Start OpenClaw
CMD ["npx", "openclaw", "start"]
