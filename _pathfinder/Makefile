#makefile

start:
	rm -f bin/*.*

serial:
	${RISCV}/bin/clang++ -march=rv64g -O3 -o bin/pathfinder_serial.exe src/pathfinder.cpp
	${RISCV}/bin/llvm-objdump  --mattr=+m,+f,+d,+a,+c -ds  bin/pathfinder_serial.exe > bin/pathfinder_serial.dump
auto:
	${RISCV}/bin/clang++ -march=rv64gcv -O3 -o bin/pathfinder_auto.exe src/pathfinder.cpp
	${RISCV}/bin/llvm-objdump  --mattr=+m,+f,+d,+a,+c -ds  bin/pathfinder_auto.exe > bin/pathfinder_auto.dump
vector:
	${RISCV}/bin/clang++ -DUSE_RISCV_VECTOR -march=rv64gcv -O3 -I../common -o bin/pathfinder_vector.exe src/pathfinder.cpp  
	${RISCV}/bin/llvm-objdump  --mattr=+m,+f,+d,+a,+c,+v -ds   bin/pathfinder_vector.exe > bin/pathfinder_vector.dump 

clean:
	rm -f bin/*.dump; \
	rm -f bin/*.exe;
