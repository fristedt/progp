#!/bin/bash
#[A-Za-z0-9\!\#\$\%\*\/\?\|\^\{\}\`\~\&\'\+\-\=\_]+@[a-z0-9]+\.com\|org\|net\|nu\|se]] ]]

# lokal=
regex="^([A-Za-z0-9!#$%*/?|^{}\`~\&\'+\-=_]+)@([a-z0-9\.]+)\.(com|org|net|nu|se)$"

echo "BRA"
exec 3<bra.txt
while read -u3 line
do
 if [[ $line =~ $regex ]]; then
    echo "true: $line"
  else
    echo "false: $line"
  fi
done

echo -e "\nDUMT"
exec 3<dumt.txt
while read -u3 line
do
 if [[ $line =~ $regex ]]; then
    echo "true: $line"
  else
    echo "false: $line"
  fi
done
