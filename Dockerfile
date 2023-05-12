# Multi-step docker build

# as builder will refer to this config as the builder phase
FROM node:16-alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

# this will create a build dir in current folder and will be copied to /app inside container

# run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# no need to run anything, nginx will auto start when container starts and serve html files specified above

