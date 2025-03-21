#makefile

start:
	rm bin/*.*

serial:
	${RISCV}/bin/clang -march=rv64g -O3 -fno-vectorize -c -o src/particlefilter_serial.o src/particlefilter.c
	${RISCV}/bin/clang -march=rv64g -O3 -fno-vectorize -o bin/particlefilter_serial.exe src/particlefilter_serial.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump --mattr=+m,+f,+d,+a,+c -ds  bin/particlefilter_serial.exe > bin/particlefilter_serial.dump

auto:
	${RISCV}/bin/clang -march=rv64gcv -O3 -c -o src/particlefilter_auto.o src/particlefilter.c
	${RISCV}/bin/clang -march=rv64gcv -O3 -o bin/particlefilter_auto.exe src/particlefilter_auto.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump --mattr=+m,+f,+d,+a,+c -ds  bin/particlefilter_auto.exe > bin/particlefilter_auto.dump

vector:
	${RISCV}/bin/clang -march=rv64gcv -DUSE_RISCV_VECTOR -O3 -fno-vectorize -c -o src/particlefilter.o src/particlefilter.c
	${RISCV}/bin/clang -march=rv64gcv -DUSE_RISCV_VECTOR -O3 -fno-vectorize -o bin/particlefilter_vector.exe src/*.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump  --mattr=+m,+f,+d,+a,+c,+v -ds   bin/particlefilter_vector.exe > bin/particlefilter_vector.dump

clean:
	rm bin/*.dump
	rm bin/*.exe