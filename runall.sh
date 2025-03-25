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

SYCLAPPS=(
  "axpy"
  "matmul"
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
    echo -e "nosim\nvector\nlarge" | ./run.sh

    echo "   - Ejecutando en modo serial..."
    echo -e "nosim\nserial\nlarge" | ./run.sh

    echo "   - Ejecutando en modo auto..."
    echo -e "nosim\nauto\nlarge" | ./run.sh

    cd "$CURRENT_DIR" || exit
    echo ""
done

for app in "${SYCLAPPS[@]}"; do
    echo ">>> Aplicación: $app"
    cd "_${app}" || { echo "No se encuentra _$app"; continue; }

    echo "   - Ejecutando en modo sycl-serial..."
    echo -e "nosim\nsycl-serial\nlarge" | ./run.sh

    cd "$CURRENT_DIR" || exit
    echo ""
done
