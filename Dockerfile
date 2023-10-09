FROM node:18

WORKDIR /app

COPY package.json .

RUN npm ci

COPY . .

CMD [ "node", "build/index.js" ]