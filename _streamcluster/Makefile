#makefile

start:
	rm bin/*.*

serial:
	${RISCV}/bin/clang++ -march=rv64g -O3 -fno-vectorize -c -o src/streamcluster_serial.o src/streamcluster.cpp
	${RISCV}/bin/clang++ -march=rv64g -O3 -fno-vectorize -o bin/streamcluster_serial.exe src/streamcluster_serial.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump  --mattr=+m,+f,+d,+a,+c -ds  bin/streamcluster_serial.exe > bin/streamcluster_serial.dump

auto:
	${RISCV}/bin/clang++ -march=rv64gcv -O3 -c -o src/streamcluster_auto.o src/streamcluster.cpp
	${RISCV}/bin/clang++ -march=rv64gcv -O3 -o bin/streamcluster_auto.exe src/streamcluster_auto.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump  --mattr=+m,+f,+d,+a,+c -ds  bin/streamcluster_auto.exe > bin/streamcluster_auto.dump

vector:
	${RISCV}/bin/clang++ -DUSE_RISCV_VECTOR -march=rv64gcv -O3 -fno-vectorize -c -o src/streamcluster.o src/streamcluster.cpp
	${RISCV}/bin/clang++ -DUSE_RISCV_VECTOR -march=rv64gcv -O3 -fno-vectorize -o bin/streamcluster_vector.exe src/*.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump  --mattr=+m,+f,+d,+a,+c,+v -ds   bin/streamcluster_vector.exe > bin/streamcluster_vector.dump

clean:
	rm bin/*.dump
	rm bin/*.exe