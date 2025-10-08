#!/bin/bash
set -e

# CONFIGURACIÓN
FUENTE_REPO="$(pwd)"
HTML_REPO="../_site_jekyll"
RAMA="main"
MENSAJE="Actualización automática del sitio desde web_jekyll_asir"

# Construir el sitio con Jekyll
echo "enerando sitio Jekyll..."
bundle exec jekyll serve

# Copiar los archivos generados al otro repositorio
echo "Sincronizando contenido con el repositorio _site_jekyll..."
rsync -av --delete "$FUENTE_REPO/_site/" "$HTML_REPO/"

# Subir los cambios al repositorio _site_jekyll
cd "$FUENTE_REPO"
echo "Subiendo cambios al repositorio remoto..."
git add .
git commit -m "$MENSAJE" || echo "o hay cambios para commitear."
git push origin "$RAMA"

# Volver al repositorio fuente
cd "$FUENTE_REPO"
echo "Despliegue completado correctamente."
