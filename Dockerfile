FROM node:16-alpine as todo-client-app-build
WORKDIR /client
COPY package*.json README.md ./
RUN npm install
COPY ./public ./public
COPY ./src ./src
ENV REACT_APP_baseAPIURL=http://localhost:5000
ENV SKIP_PREFLIGHT_CHECK=true
ENV PORT=80
RUN npm run build

FROM nginx:latest
LABEL maintainer="Abdullah"
COPY --from=todo-client-app-build /client/build/ /usr/share/nginx/html
EXPOSE 80