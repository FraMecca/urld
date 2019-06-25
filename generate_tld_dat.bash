#!/bin/bash
echo 'enum byte[string] tlds = [' > source/tlds.d 
curl https://raw.githubusercontent.com/pauldix/domainatrix/master/lib/effective_tld_names.dat \
    | sed 's/\/\/.*//g' | sed '/^$/d' | sed 's/\!//g'| sed 's/\*\.//g' | \
     sed 's/^/"/g' | sed 's/$/":0,/g' >> source/tlds.d 

echo '];' >> source/tlds.d 
