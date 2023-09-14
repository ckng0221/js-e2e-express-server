FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

EXPOSE 3000

CMD [ "node", "src/index.js" ]

# docker build . -t express-server
# docker run -d -p 3000:3000 express-server