FROM alpine
RUN apk add --no-cache perl
COPY cowsay /usr/local/bin/cowsay
COPY *.cow /usr/local/share/cows/
COPY docker.cow /usr/local/share/cows/default.cow
RUN sed -i 's/\r$//' /usr/local/bin/cowsay
RUN chmod +x usr/local/bin/cowsay
ENTRYPOINT ["/usr/local/bin/cowsay"]
