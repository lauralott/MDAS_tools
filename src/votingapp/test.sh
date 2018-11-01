greetins="hello mdas,$1,$2,$3"
#if cp ./hola hola; then
 #   echo "RESULT $?"
#else 
 #   echo "RESULT $?"
#fi
set -e
cp ./hola hola || true

echo $greetins