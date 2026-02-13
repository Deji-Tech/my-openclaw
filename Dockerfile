# 1. Use Debian (solves the 'glibc' and 'Alpine' errors)
FROM node:22-bookworm

# 2. Install the build tools missing in your previous logs
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 3. This copies your package.json from your linked GitHub repo
COPY package*.json ./

# 4. Install dependencies (this will now work with glibc present)
RUN npm install

# 5. Copy your remaining code
COPY . .

# 6. Configure the port Pxxl gave you
ENV PORT=4734
EXPOSE 4734

# 7. Start the bot on the correct port
CMD ["npx", "openclaw", "start", "--port", "4734"]
