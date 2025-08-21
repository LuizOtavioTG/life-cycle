FROM node:16 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install --legacy-peer-deps
RUN npm install @types/node@16 --save-dev
RUN npm install -g @angular/cli@15.1.0

COPY . .

RUN ng build --configuration production 


FROM nginx:alpine

COPY --from=build /app/dist/life-cycle    /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY mime.types /etc/nginx/mime.types

EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
