#include <stdio.h>

int quadratic(double, double, double, double *, double *);

int main() {
    double a, b, c, root1, root2;
    int res;

    printf("\n - Programado por Joy Nelaton, Josue, Julio - Lenguaje Ensamblador NASM Version 2.14.02 \n");
    printf(" - Ecuacion Cuadratica en Assembler \n\n");

    do {
        printf("Ingresa el valor de a: ");
        res = scanf("%lf", &a);
        while(getchar() != '\n'); // Limpia el buffer de entrada
        if(res != 1) {
            printf("Entrada invalida. Vuelve a intentarlo con un número valido.\n");
        }
    } while(res != 1);

    do {
        printf("Ingresa el valor de b: ");
        res = scanf("%lf", &b);
        while(getchar() != '\n'); // Limpia el buffer de entrada
        if(res != 1) {
            printf("Entrada invalida. Vuelve a intentarlo con un número valido.\n");
        }
    } while(res != 1);

    do {
        printf("Ingresa el valor de c: ");
        res = scanf("%lf", &c);
        while(getchar() != '\n'); // Limpia el buffer de entrada
        if(res != 1) {
            printf("Entrada invalida. Vuelve a intentarlo con un número valido.\n");
        }
    } while(res != 1);

    if (quadratic(a, b, c, &root1, &root2)) {
        printf("Las Raices son: x1 = %.10g, x2 = %.10g\n", root1, root2);
    } else {
        printf("Las Raices son imaginarias\n");
    }
    return 0;
}
