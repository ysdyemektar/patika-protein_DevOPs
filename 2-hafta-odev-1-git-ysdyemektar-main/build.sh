

#!/bin/sh

###############
# Authors: yasadiye emektar 
# Date: 04.05.2022
# ./build.sh or bash build.sh
#
##############


# Anadalda olup olmadığımızı öğrnemek için kontrol ediliyor.
CURRENTBRANCH=$(git status | awk 'NR==1{print $3}');
 
 #Eğer master da değilse echo ile yazdırıyorum.
if [ ! "$CURRENTBRANCH"=="master" ]; then
    echo -e "Not on master - cannot proceed, please change to master by using:\ngit checkout master"
    exit 1
fi

set -e 
# Kullanıcı git reposunda değil
if ! git branch > /dev/nul 2>&1
then 
     echo "E: '$(basename ${PWD}' -Not a Git respository."
     exit 1
 fi
 
 echo "P: Checking out all remote branches ...."
 
 #Geçerli şubeyi hatırla
  _CURRENT_BRANCH in $(git branch  | awk '/^\* / {print $2 } ')"
 
 #Tüm uzak şubeyi kontrol et
 
 for _REMOTE_BRANCH in $(git branch -r | awk '/^\* / {print $2 } ')"
 do 
 
    MY _BRANCH="$(echo ${_REMOTE_BRANCH} | cut -d/ -f 2-)"
      
      if [ "$MY_BRANCH}" != "HEAD" ]
      then
          if ! git branch | grep -q "${MY_BRANCH}$"
          then
                git checkout -b ${MY_BRANCH} ${_REMOTE_BRANCH}
                
                 fi 
                 
            fi
     done
     
     
     #mevcut şubeye geri dönmek
     
     if[ "${git branch | awk '/^\* / { print $2}')" != "${_CURRENT_BRANCH}" ]
     then
       git checkout ${_CURRENT_BRANCH}
       fi
       
       #warrning
       if [ "$_CURRENT_BRANCH"=="master" ]; then
       echo -e "Your working on branch"
       exit 1
       
       
       
      
       # yeni branch 
       git checkout -b mynewBranch
       


# Arşivleme 
if [ -d "dist" ]; then
  cd dist
  tar -zcf ../MY_BRANCH.tar.gz . || :
  cd ..
else
  tar -zcf MY_BRANCH.tar.gz --exclude=".git" --exclude=MY_BRANCH.tar.gz . || :
fi