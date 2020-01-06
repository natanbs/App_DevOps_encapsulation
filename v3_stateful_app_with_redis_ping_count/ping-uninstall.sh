for i in `docker ps -a |grep ping | sed 's/^.*tcp//g'`; do docker stop $i; docker rm $i;done
for i in `docker images | egrep 'flask|redis' | awk '{print $3}'`; do docker rmi $i; done
