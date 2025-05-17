FROM node:22-alpine

WORKDIR /usr/src/app

RUN npm install -g pnpm

COPY package.json ./
COPY pnpm-lock.yaml ./
RUN pnpm install

COPY tsconfig.* ./
COPY *.ts ./
COPY src ./src

RUN npm run build

EXPOSE $PORT

CMD [ "npm", "start" ]
