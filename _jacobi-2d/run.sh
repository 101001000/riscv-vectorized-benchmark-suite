#!/bin/bash

echo " "
echo "----------------------------------------------------------------------------------"
echo "JACOBI-2D"
echo "----------------------------------------------------------------------------------"
echo " "

app_name="jacobi-2d"

while true; do
    echo -n "do you want to run on spike, qemu or nosim [spike qemu gem5 nosim]: "
    read sim
    if [ $sim == "spike" ]; then
		simulator="$RISCV/bin/spike --isa=rv64gcv pk"
		break
	elif [ $sim == "qemu" ]; then
		#simulator="$RISCV/bin/qemu-riscv64 -L $RISCV/sysroot"
		echo "qemu is not working for jacobi-2d. Try with a diferent option: "
        continue
	elif [ $sim == "gem5" ]; then
		simulator="$GEM5/build/RISCV/gem5.opt $GEM5/configs/deprecated/example/se.py"
		break
    elif [ $sim == "nosim" ]; then
		simulator=""
		break
    else
    	echo "Input not valid, try again."
        continue
    fi
done

while true; do
    echo -n "do you want to run the serial or vectorized version [serial vector]: "
    read version
    if [[ $version == "serial" ]]  || [[ $version == "vector" ]] || [[ $version == "auto" ]]; then
        break
    else
    	echo "Input not valid, try again."
        continue
    fi
done


while true; do
    echo -n "select the simulation size [tiny small medium large]: "
    read simsize
    if [ $simsize == "tiny" ]; then
		app_args="32 2 output/output_${version}_$simsize.txt"
		break
	elif [ $simsize == "small" ]; then
		app_args="128 10 output/output_${version}_$simsize.txt"
		break
	elif [ $simsize == "medium" ]; then
		app_args="256 100 output/output_${version}_$simsize.txt"
		break
	elif [ $simsize == "large" ]; then
		app_args="256 2000 output/output_${version}_$simsize.txt"
		break
    else
    	echo "Input not valid, try again."
        continue
    fi
done

echo "[RIVEC]---------------------------------------------------------------------- ----"
echo "[RIVEC]                          RUNNING JACOBI-2D 								"
echo "[RIVEC]---------------------------------------------------------------------------"

echo "command: $simulator bin/${app_name}_${version}.exe $app_args"
echo "----------------------------------------------------------------------------------"
mkdir output
echo " " > output/output_${version}_$simsize.txt
if [ $sim == "gem5" ]; then
	$simulator  --cmd="bin/${app_name}_${version}.exe" --options="$app_args"
else
	$simulator bin/${app_name}_${version}.exe $app_args
fi

echo "[RIVEC]---------------------------------------------------------------------- ----"
echo "[RIVEC]                          DONE 											"
echo "[RIVEC]---------------------------------------------------------------------------"