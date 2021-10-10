#!/bin/sh
languages=`echo "golang rust lua javascript nodejs ruby html css haskell elm" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk ps" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: "  query

if printf "$languages" | grep -qs "$selected"; then
    query=`echo $query|tr ' ' '+'`
    tmux neww bash -c "curl -s cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query|bat"
fi
