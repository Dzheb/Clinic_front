# образ node
FROM node:12.2.0-alpine

# рабочая папка
WORKDIR /app

# добавление `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# установка зависимостей
COPY package.json /app/package.json
RUN npm install
RUN npm install @vue/cli

# start
CMD ["npm", "run", "serve"]
