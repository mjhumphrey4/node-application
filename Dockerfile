 FROM node:18-alpine as builder
 ENV NODE_ENV="production"

 # Copy app's source code to the /app directory
 COPY . /app

 # The application's directory will be the working directory
 WORKDIR /app

 # Install Node.js dependencies defined in '/app/package.json'
 RUN npm install
 FROM node:18-alpine
 ENV NODE_ENV="production"
 COPY --from=builder /app /app
 WORKDIR /app
 ENV PORT 8080
 EXPOSE 8080

 # Start the application
 CMD ["npm", "start"]
