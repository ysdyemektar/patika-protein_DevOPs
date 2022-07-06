date=$(date +%d-%m%Y)
time=$(date +"%T)
backup="/mnt"


for user in $(cat /etc/passwd | grep '/home' |cut -d: -f1)
do
tar -cvf ${backup}_${date}.tar.gz /home/${user}
m5sum ${backup}/${user}_${date}_${time}.tar.gz >> ${backup}/${user}_${date}_${time}.tar.gz.md5.txt
done