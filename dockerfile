#for production 

#build phase from dev
FROM node:alpine as builder
WORKDIR /app

COPY package.json .
RUN npm install 

COPY . .
RUN npm run build

#RUN phase 
#copy build folder to html inside container of nginx container 
FROM nginx:1.12-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
