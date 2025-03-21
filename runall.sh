#!/bin/bash
CURRENT_DIR=$(pwd)

# Lista de aplicaciones
APPS=(
  "axpy"
  "blackscholes"
  "canneal"
  "jacobi-2d"
  "lavaMD"
  "matmul"
  "spmv"
  "swaptions"
  "streamcluster"
  "somier"
  "particlefilter"
  "pathfinder"
)

echo "-------------------------------------------------------------------"
echo "RiVec Benchmark Suite - Full Run"
echo "(Ejecuta cada benchmark en modo 'vector' y 'serial' con 'large')"
echo "-------------------------------------------------------------------"
echo ""

for app in "${APPS[@]}"; do
    echo ">>> Aplicación: $app"
    cd "_${app}" || { echo "No se encuentra _$app"; continue; }

    echo "   - Ejecutando en modo vector..."
    # Emulamos las respuestas a los 'read' dentro de run.sh:
    #  1) 'vector'  (para el modo)
    #  2) 'large'   (para el tamaño de simulación)
    echo -e "nosim\nvector\nlarge" | ./run.sh

    echo "   - Ejecutando en modo serial..."
    echo -e "nosim\nserial\nlarge" | ./run.sh

    cd "$CURRENT_DIR" || exit
    echo ""
done
