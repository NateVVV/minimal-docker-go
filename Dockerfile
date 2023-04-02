FROM golang:1.19-alpine AS build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY *.go ./
RUN go build -o build/hello-world
RUN adduser -D noroot

FROM scratch AS prod
WORKDIR /app
COPY --from=build /app/build/hello-world .
COPY --from=build /etc/passwd /etc/passwd
USER noroot
CMD ["./hello-world"]
