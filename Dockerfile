# build stage
FROM node:lts-alpine as build-stage
ARG GITHUB_TOKEN
WORKDIR /app
COPY package*.json .npmrc ./
RUN echo "//npm.pkg.github.com/:_authToken=$GITHUB_TOKEN" >> .npmrc && \
    npm install --production && \
    rm -f .npmrc
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
