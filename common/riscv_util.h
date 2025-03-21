/*************************************************************************
*GET_TIME
*returns a long int representing the time
*************************************************************************/

#include <time.h>
#include <sys/time.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdbool.h>

static long long get_time() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (tv.tv_sec * 1000000) + tv.tv_usec;
}

static float elapsed_time(long long start_time, long long end_time) {
    float elapsed_ms = (float)(end_time - start_time) / (1000.0f * 1000.0f);
    return elapsed_ms;
}

static float elapsed_time(long long start_time, long long end_time, bool print) {
    float elapsed_ms = (float)(end_time - start_time) / (1000.0f * 1000.0f);
    if(print){
        char path[2048];
        ssize_t count = readlink("/proc/self/exe", path, sizeof(path) - 1);

        if (count != -1) {
            path[count] = '\0';
        } else {
            strcpy(path, "unknown_exe");
        }

        char *exe_name = strrchr(path, '/');
        if (!exe_name) {
            exe_name = path; 
        } else {
            exe_name++; 
        }  

        FILE *file = fopen("../results.csv", "a");
        if (file) {
            fprintf(file, "%s,%.6f\n", exe_name, elapsed_ms);
            fclose(file);
        }
    }
    return elapsed_ms;
}

/*************************************************************************
*Instruction Count
*returns the number of instructions executed
*************************************************************************/
static unsigned long get_inst_count()
{
    unsigned long instr;
    asm volatile ("rdinstret %[instr]"
                : [instr]"=r"(instr));
    return instr;
}

static unsigned long get_cycles_count()
{
    unsigned long cycles;
    asm volatile ("rdcycle %[cycles]"
                : [cycles]"=r"(cycles));
    return cycles;
}

/*************************************************************************/