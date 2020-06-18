FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# we don't change our code anymore in production
COPY . .
RUN npm run build

# /app/build contains built app 
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
# nginx starts nginx automatically