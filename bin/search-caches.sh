#!/bin/bash

# Función para convertir kilobytes a un formato legible
convert_size() {
  local size=$1
  local units=("KB" "MB" "GB" "TB")

  for unit in "${units[@]}"; do
    if ((size < 1024)); then
      echo "$size $unit"
      return
    fi
    size=$((size / 1024))
  done
}

# Verificamos si el usuario ha proporcionado un directorio
if [ -z "$1" ]; then
  echo "Uso: $0 <directorio> [--delete]"
  exit 1
fi

# Directorio raíz proporcionado por el usuario
root_dir="$1"
total_size=0
delete_mode=false

# Verificar si se pasa la opción --delete
if [ "$2" == "--delete" ]; then
  delete_mode=true
fi

# Usamos un bucle for en lugar de while para evitar problemas de subshell
for cachedir_tag in $(find "$root_dir" -type f -name "CACHEDIR.TAG" 2>/dev/null); do
  # Obtener el directorio que contiene el archivo CACHEDIR.TAG
  dir=$(dirname "$cachedir_tag")

  # Obtener el tamaño del directorio en kilobytes
  dir_size=$(du -sk "$dir" | cut -f1)

  # Comprobar si el tamaño se ha obtenido correctamente
  if [[ -z "$dir_size" ]]; then
    echo "No se pudo obtener el tamaño de: $dir"
  else
    # Convertir el tamaño a legible y mostrarlo
    human_size=$(du -sh "$dir" | cut -f1)
    echo "Directorio con CACHEDIR.TAG: $dir"
    echo "Tamaño del directorio: $human_size ($dir_size KB)"
    echo "----------------------------------"

    # Sumar el tamaño al total
    total_size=$((total_size + dir_size))

    # Si está en modo de eliminación, eliminamos el directorio
    if [ "$delete_mode" = true ]; then
      echo "Eliminando el directorio: $dir"
      rm -rf "$dir"
    fi
  fi
done

# Mostrar el tamaño total en formato legible por humanos
echo "Tamaño total de todos los directorios:"
convert_size $total_size
