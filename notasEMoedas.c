#include <stdio.h>

#define QTD 6

int calculaNota(float* valor, int x);
int calculaMoeda(float* valor, float x);
void printNota(int n, float x);
void printMoeda(int n, float x);

float notas[] = {100, 50, 20, 10, 5, 2};
float moedas[] = {1, 0.5, 0.25, 0.1, 0.05, 0.01};

int main(void) {
    float valor;
    printf("Insira o valor: ");
    scanf("%f", &valor);

    printf("\nNOTAS:\n");
    for(int i = 0; i < QTD; i++) {
        printNota(calculaNota(&valor, notas[i]), notas[i]);
    }
    
    printf("\nMOEDAS:\n");
    for(int i = 0; i < QTD; i++) {
        printMoeda(calculaMoeda(&valor, moedas[i]), moedas[i]);
    }
    
    return 0;
}

int calculaNota(float* valor, int x) {
    int cont = 0;
    while(*valor >= x) {
        *valor = *valor - x;
        cont++;
    }
    return cont;
}

int calculaMoeda(float* valor, float x) {
    int cont = 0;
    while(*valor >= x) {
        *valor = *valor - x;
        cont++;
    }
    return cont;
}

void printNota(int n, float x) {
    printf("%d nota(s) de R$ %.2f\n", n, x);
}

void printMoeda(int n, float x) {
    printf("%d moeda(s) de R$ %.2f\n", n, x);
}
