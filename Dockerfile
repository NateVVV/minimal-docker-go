FROM golang:1.19-alpine AS build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY *.go ./
RUN go build -o build/hello-world

FROM scratch AS prod
WORKDIR /app
COPY --from=build /app/build/hello-world .
CMD ["./hello-world"]
