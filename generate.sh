#!/bin/bash

# Fonction de conversion des fichiers Markdown en HTML
convert_markdown_to_html() {
    for file in "$1"/*.md; do
        [ -e "$file" ] || continue
        output="${file%.md}.html"
        pandoc -s -c ./css/main.css --template=template.html -o "$output" "$file"
    done
}

# Fonction récursive pour parcourir les répertoires
process_directory() {
    for entry in "$1"/*; do
        if [ -d "$entry" ]; then
            process_directory "$entry"
        elif [ -f "$entry" ]; then
            if [[ "$entry" == *.md ]]; then
                convert_markdown_to_html "$(dirname "$entry")"
            fi
        fi
    done
}

# Dossier de base contenant les fichiers Markdown
base_dir="."

# Appel de la fonction pour le dossier de base
process_directory "$base_dir"