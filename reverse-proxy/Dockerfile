FROM nginx:1.29.3-alpine

RUN apk update && apk add curl bash vim && rm -rf /var/cache/apk/*
COPY --chmod=0755 entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
