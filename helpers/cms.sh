#!/bin/bash

dirsearch_file="${1}"
# lsof -f -- /box/falafel/scans/tcp_80_http_dirsearch_.txt

while :
do
    if [[ `lsof -f -- "${dirsearch_file}"` ]]
    then

        cur_dirs=$(cat "${dirsearch_file}")
        echo "${cur_dirs}"

        ## cms checks here #########################################################################
        if [[ "${cur_dirs}" == *"wordpress"* ]] || [[ "${cur_dirs}" == *"/wp"* ]] || [[ "${cur_dirs}" == *"Wordpress"* ]]
        then
          target=$(cat "${dirsearch_file}" |egrep 'http.*(wordpress|wp|wp-content)/'|awk '{print $3}'|head -n1)
          wpscan --api-token Z7k3m9sAFib0ZHqto8LqNUsJazvKF2VDYh1AyS18wjw --url "${target}" -e vp,vt,tt,cb,dbe,u,m -f cli-no-color 2>&1 | tee "{scandir}/{protocol}_{port}_{scheme}_wpscan.txt"
        fi

        ############################################################################################
    else
        break
    fi
    sleep 1
done
echo "done"
