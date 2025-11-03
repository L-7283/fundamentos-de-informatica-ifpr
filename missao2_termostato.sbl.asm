; --- Missão 2: O Termostato Inteligente ---
; Traduzido para Assembly x86 (NASM)

section .data
    ; Temperatura atual. Mude este valor para testar!
    ; Valores para testar:
    ;   28 -> Saída 1 (Ar-condicionado)
    ;   15 -> Saída -1 (Aquecedor)
    ;   22 -> Saída 0 (Confortável)
    temperatura dw 28

section .text
    global _start

_start:
    ; Carrega a temperatura atual no registrador AX.
    mov ax, [temperatura]

    ; --- Etapa 1: Verificar se precisa ligar o ar-condicionado (temp > 25) ---
    ; Em vez de SUB, usamos CMP para comparar sem alterar o valor em AX.
    ; CMP AX, 25 é como fazer (AX - 25) e ajustar as flags.
    cmp ax, 25
    
    ; Se AX for maior que 25, pula para a seção de ligar o ar-condicionado.
    ; JG (Jump if Greater) é o equivalente a verificar se o resultado da subtração
    ; seria positivo (e não zero).
    jg ligar_ac

    ; Se não pulou, a temperatura é <= 25. O programa continua para a próxima verificação.

    ; --- Etapa 2: Verificar se precisa ligar o aquecedor (temp < 20) ---
    ; A lógica do seu pseudo-código (20 - temp) é equivalente a perguntar "a temperatura é menor que 20?".
    cmp ax, 20

    ; Se AX for menor que 20, pula para a seção de ligar o aquecedor.
    ; JL (Jump if Less) é o equivalente a verificar se o resultado de (AX - 20) seria negativo.
    jl ligar_aquecedor

    ; Se não pulou aqui, significa que a temp não é > 25 e não é < 20.
    ; Portanto, está entre 20 e 25, inclusive.

    ; --- Etapa 3: Temperatura confortável ---
confortavel:
    mov eax, 0      ; Carrega 0 em EAX (Desligado).
    jmp fim         ; Pula para o final do programa.

ligar_ac:
    mov eax, 1      ; Carrega 1 em EAX (Ligar Ar-Condicionado).
    jmp fim         ; Pula para o final do programa.

ligar_aquecedor:
    mov eax, -1     ; Carrega -1 em EAX (Ligar Aquecedor).
                    ; EAX é um registrador de 32 bits, então ele pode
                    ; guardar valores negativos sem problemas.

fim:
    ; HLT -> Finaliza o programa de forma controlada.
    mov ebx, eax    ; A syscall de 'exit' no Linux espera o código de saída em EBX.
    mov eax, 1      ; Código da syscall 'exit'.
    int 0x80        ; Chama o sistema operacional para terminar.