FROM alpine:3.14 AS builder

RUN apk add --no-cache \
  bison \
  cmake \
  flex \
  g++ \
  gsl-dev \
  libexecinfo-dev \
  make

WORKDIR /src
COPY . .
RUN make

FROM alpine:3.14 AS final

RUN apk add --no-cache \
  gsl \
  libgomp \
  libstdc++
COPY --from=builder /src/bin/rd /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/rd"]
