# Use small Alpine Linux image
FROM node:12-alpine


#ortam değişkenlerini ayarlanıyor
ENV PORT=5000
ARG CLIENT_ID

COPY . app/

WORKDIR app/

# web paket yüklecyicilerini kontrol etme
RUN apk add --no-cache \
  autoconf \
  automake \
  bash \
  g++ \
  libc6-compat \
  libjpeg-turbo-dev \
  libpng-dev \
  make \
  nasm 
RUN npm ci --only-production --silent

#react uygulaması oluşturuluyor
RUN npm run build

# Node(düğüm) için bağlantı noktasını gösterir
EXPOSE $PORT
#düğüm sunucusunu başlat
ENTRYPOINT npm run prod