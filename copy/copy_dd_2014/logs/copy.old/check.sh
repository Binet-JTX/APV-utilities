cat $1 | awk '{print $1}' | diff -q - ~/apv.sha256sum && echo $1 >> ../ok.txt || echo $1
