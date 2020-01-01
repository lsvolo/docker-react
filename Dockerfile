# Use an existing docker image as a base
FROM node:alpine as builder

WORKDIR '/app'

# Download and install dependency
COPY package.json .
RUN npm install
COPY . .

# Tell the image what to do when it starts as a container
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
