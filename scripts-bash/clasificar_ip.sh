#!/bin/bash

ip="$1"

# Extraer el primer y segundo octeto
IFS='.' read -r o1 o2 o3 o4 <<< "$ip"

# Determinar la clase
if (( o1 >= 1 && o1 <= 126 )); then
    clase="A"
elif (( o1 == 127 )); then
    clase="Loopback"
elif (( o1 >= 128 && o1 <= 191 )); then
    clase="B"
elif (( o1 >= 192 && o1 <= 223 )); then
    clase="C"
elif (( o1 >= 224 && o1 <= 239 )); then
    clase="D (Multicast)"
elif (( o1 >= 240 && o1 <= 255 )); then
    clase="E (Experimental)"
else
    clase="Desconocida"
fi

# Determinar si es privada
if [[ "$ip" == 10.* ]] || [[ "$ip" == 192.168.* ]] || \
   (( o1 == 172 && o2 >= 16 && o2 <= 31 )); then
    tipo="Privada"
else
    tipo="Pública"
fi

echo "Dirección IP: $ip"
echo "Clase: $clase"
echo "Tipo: $tipo"
