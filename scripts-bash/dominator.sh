#!/bin/bash

# ==============================
# Dominator.sh — por Anderson ⚡
# Reconocimiento inicial de dominios
# ==============================

DOMINIO="$1"

if [ -z "$DOMINIO" ]; then
  echo "Uso: ./dominator.sh dominio.com"
  exit 1
fi

echo "🌐 WHOIS del dominio: $DOMINIO"
whois "$DOMINIO" | grep -E 'Domain Name|Registrar|Creation Date|Expiry Date|Name Server|Status'
echo -e "\n🧠 NSLOOKUP:"
nslookup "$DOMINIO"

echo -e "\n📡 DIG:"
echo "A record:" && dig "$DOMINIO" A +short
echo "AAAA record:" && dig "$DOMINIO" AAAA +short
echo "MX record:" && dig "$DOMINIO" MX +short
echo "NS record:" && dig "$DOMINIO" NS +short
echo "TXT record:" && dig "$DOMINIO" TXT +short
echo "CNAME record:" && dig "$DOMINIO" CNAME +short

echo -e "\n📍 DNSX:"
echo "$DOMINIO" | dnsx -a -cname -resp-only -silent

echo -e "\n🕸️ HTTPX:"
echo "$DOMINIO" | httpx -title -status-code -tech-detect -web-server -ip -location -silent

echo -e "\n✅ Finalizado: resultados básicos obtenidos de $DOMINIO"
