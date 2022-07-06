
#herhangi bir hata varsa komut dosyası çalışması durur.
set -e

# Docker image
IMAGE="taniarascia/takenote"

# docker etiketi kullanılacak git etiketlerini içeren git sürümü
GIT_VERSION=$(git describe --always --abbrev --tags --long)

#yeni docker görüntüsü oluşturup dockerhub'a aktarma
echo "Building and tagging new Docker image: ${IMAGE}:${GIT_VERSION}"

docker build --build-arg DEMO=true CLIENT_ID=${CLIENT_ID} -t ${IMAGE}:${GIT_VERSION} .
docker tag ${IMAGE}:${GIT_VERSION} ${IMAGE}:latest

# Docker hub'da oturum açma 
echo "Logging into Docker and pushing ${IMAGE}:${GIT_VERSION}"

echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
docker push ${IMAGE}:${GIT_VERSION}
docker push ${IMAGE}:latest



echo "Authorizing DigitalOcean"

doctl auth init -t "${DO_ACCESS_TOKEN}"

# SSH anahtarı kodu çözülüyor
echo ${DO_SSH_KEY} | base64 -d > deploy_key
chmod 600 deploy_key

# Droplet'te oturum açın, şu anda çalışan kapsayıcıyı durdurun ve aradından yenisini başlatalım
echo "Stopping container name current and starting ${IMAGE}:${GIT_VERSION}"

doctl compute ssh ${DROPLET} --ssh-key-path deploy_key --ssh-command "docker pull ${IMAGE}:${GIT_VERSION} && 
docker stop current && 
docker rm current && 
docker run --name=current --restart unless-stopped -e DEMO=true CLIENT_ID=${CLIENT_ID} -e CLIENT_SECRET=${CLIENT_SECRET} -d -p 80:5000 ${IMAGE}:${GIT_VERSION} &&
docker system prune -a -f &&
docker image prune -a -f"