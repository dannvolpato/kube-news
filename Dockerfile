FROM node:19.5.0-slim
WORKDIR /app
COPY ./src/package*.json ./
RUN npm install
COPY ./src ./
EXPOSE 8080
ENTRYPOINT ["node", "server.js"]