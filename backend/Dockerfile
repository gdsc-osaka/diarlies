FROM node:22-alpine

ARG FIRE_SA
ARG GEMINI_API_KEY
ARG GOOGLE_MAPS_API_KEY

WORKDIR /usr/src/app

RUN npm install -g pnpm

COPY package.json ./
COPY pnpm-lock.yaml ./
RUN pnpm install

COPY tsconfig.* ./
COPY *.ts ./
COPY src ./src

COPY .scripts ./.scripts
RUN chmod +x ./.scripts/env.sh
RUN .scripts/env.sh

RUN npm run build

EXPOSE $PORT

CMD [ "npm", "start" ]
