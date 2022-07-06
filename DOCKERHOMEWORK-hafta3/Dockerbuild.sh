


#!/bin/sh
#
# dockerbuild.sh
#
#
#
# @author      Yasadiye emektar <info@ysdy.com>
# ------------------------------------------------------------------------------

# NOT:
# Bu script Docker gerektirir.

# EXAMPLE USAGE:
# CVSPATH=proje VENDOR=satıcıadı PROJECT=projeninadı MAKETARGET=buildall ./dockerbuild.sh

# Satıcı ve projenin adını alıyoruz.
: ${CVSPATH:=project}
: ${VENDOR:=vendor}
: ${PROJECT:=project}

: ${MAKETARGET:=buildall}

# Docker görüntüsünün adı 
DOCKERDEV=${VENDOR}/dev_${PROJECT}

# temek ortam oluşturuluyor ve local olarak önbelleğe alınıyor
docker build -t ${DOCKERDEV} ./resources/DockerDev/

# projenin kök yolunu tanımlıyoruzz
PRJPATH=/root/src/${CVSPATH}/${PROJECT}

# Prpjeyi oluşturmak ve test etmek için geçici bir dockerfile oluşturuyoruz
# NOT: RUN komutunun çıkış durumu daha sonra döndürülmek üzere saklanır,
#       yani hata durumunda bu betiği durmadan devam ettirebiliriz.
cat > Dockerfile <<- EOM
FROM ${DOCKERDEV}
RUN mkdir -p ${PRJPATH}
ADD ./ ${PRJPATH}
WORKDIR ${PRJPATH}
RUN make ${MAKETARGET} || (echo \$? > target/make.exit)
EOM

# Geçici Docker görüntüsünü adını tanımlıyoruz
DOCKER_IMAGE_NAME=${VENDOR}/build_${PROJECT}

# Docker görüntüsü oluşturuluyor.
docker build --no-cache -t ${DOCKER_IMAGE_NAME} .

# Yeni oluşturulan Docker görüntüsü kullanılarak bir container oluşturuluyor.
CONTAINER_ID=$(docker run -d ${DOCKER_IMAGE_NAME})

# tüm derleme yapılarını ana bilgisayara kopyalama
docker cp ${CONTAINER_ID}:"${PRJPATH}/target" ./

# Geçici container ve resim kaldırılır.
docker rm -f ${CONTAINER_ID} || true
docker rmi -f ${DOCKER_IMAGE_NAME} || true