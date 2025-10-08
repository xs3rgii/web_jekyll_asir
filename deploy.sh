#!/bin/bash
set -e

FUENTE_REPO="$(pwd)"
HTML_REPO="../_site_jekyll"
RAMA="main"
MENSAJE="Actualización automática del sitio"

bundle exec jekyll build

rsync -av --delete --exclude='.git/' "$FUENTE_REPO/_site/" "$HTML_REPO/"

cd "$HTML_REPO"
git add .
git commit -m "$MENSAJE" || echo "No hay cambios que commitear."
git push origin "$RAMA"

cd "$FUENTE_REPO"
