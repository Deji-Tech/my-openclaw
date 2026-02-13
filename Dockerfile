# 1. Use Debian Bookworm (includes glibc)
FROM node:22-bookworm

# 2. Install EVERYTHING needed for node-llama-cpp
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    cmake \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 3. Explicitly copy package.json from your repo
COPY package*.json ./

# 4. Run install with verbose logs to see if it fails again
RUN npm install --verbose

# 5. Copy the rest of your files
COPY . .

# 6. Set the Pxxl Port
ENV PORT=4734
EXPOSE 4734

# 7. Force OpenClaw to use the Pxxl port
CMD ["npx", "openclaw", "start", "--port", "4734"]
