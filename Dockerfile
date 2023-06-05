FROM golang:1.20.4-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download 

COPY *.go ./
RUN go build -o /helloworld

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /helloworld /helloworld

USER nonroot:nonroot

ENTRYPOINT ["/helloworld"]