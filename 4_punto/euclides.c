#include <stdio.h>
#include <time.h>
#include <stdlib.h>

long long gcd(long long a, long long b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

int main() {
    long long pairs[][2] = {
        {48, 18},
        {100, 75},
        {1071, 462},
        {1000000, 999999},
        {123456789, 987654321},
        {999999937, 999999893}
    };
    int n = 6;

    printf("%-25s %-25s %-10s %-15s\n", "a", "b", "GCD", "Tiempo (ns)");
    printf("%-25s %-25s %-10s %-15s\n", "---", "---", "---", "-----------");

    for (int i = 0; i < n; i++) {
        long long a = pairs[i][0];
        long long b = pairs[i][1];

        struct timespec start, end;
        clock_gettime(CLOCK_MONOTONIC, &start);

        long long result = 0;
        for (int j = 0; j < 1000000; j++) {
            result = gcd(a, b);
        }

        clock_gettime(CLOCK_MONOTONIC, &end);
        double avg_ns = ((end.tv_sec - start.tv_sec) * 1e9 +
                         (end.tv_nsec - start.tv_nsec)) / 1000000.0;

        printf("%-25lld %-25lld %-10lld %-15.3f\n", a, b, result, avg_ns);
    }

    printf("\n--- Prueba de estres: 10,000,000 pares aleatorios ---\n");
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    long long sum = 0;
    srand(42);
    for (int i = 0; i < 10000000; i++) {
        long long a = (long long)rand() % 1000000 + 1;
        long long b = (long long)rand() % 1000000 + 1;
        sum += gcd(a, b);
    }

    clock_gettime(CLOCK_MONOTONIC, &end);
    long long elapsed_ms = (end.tv_sec - start.tv_sec) * 1000LL +
                           (end.tv_nsec - start.tv_nsec) / 1000000;

    printf("Suma total de GCDs : %lld\n", sum);
    printf("Tiempo total       : %lld ms\n", elapsed_ms);
    printf("Promedio por llamada: %.3f ns\n",
           (double)(elapsed_ms * 1000000) / 10000000.0);

    return 0;
}
