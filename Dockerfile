# 1. Use Debian Slim to stay within Render's 512MB RAM
FROM node:22-bookworm-slim

# 2. Install essential build tools for AI components
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 3. Copy your project files
COPY package*.json ./

# 4. Install only production dependencies
RUN npm install --omit=dev

# 5. Copy the rest of your files
COPY . .

# 6. Render requires port 10000 for web services
EXPOSE 10000

# 7. FIXED COMMAND: Prevents "Module Not Found" and "Out of Memory"
CMD ["sh", "-c", "npx --node-options='--max-old-space-size=350' openclaw start --port ${PORT:-10000}"]
