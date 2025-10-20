; --- Seção de Dados (Memória) ---
; Precisamos de um pequeno espaço na memória para preparar o caractere que será impresso.
section .bss
    digito_para_imprimir resb 2  ; Reserva 2 bytes: 1 para o dígito, 1 para a quebra de linha

; --- Seção de Código Executável ---
section .text
global _start

_start:
    ; Passo 1: Inicializar nosso contador. Usaremos o registrador CX, que é comum para loops.
    MOV CX, 5       ; Ponto de partida da contagem.

; Passo 2: Definir o início do nosso loop com uma etiqueta (label).
loop_inicio:
    ; Passo 3: Converter o número atual (em CX) para um caractere de texto (ASCII).
    ; A syscall só imprime texto, não números binários.
    MOV AL, CL        ; Copia o contador (5, 4, 3...) para um registrador menor (AL).
    ADD AL, '0'       ; Converte o valor numérico para seu caractere ASCII.
                      ; Ex: 5 (número) + 48 (valor de '0') = 53 (código de '5').

    ; Passo 4: Guardar o caractere na memória para a impressão.
    MOV [digito_para_imprimir], AL ; Coloca o caractere ('5', '4'...) no nosso espaço de memória.
    MOV byte [digito_para_imprimir + 1], 10 ; Adiciona uma quebra de linha (ASCII 10) depois do dígito.

    ; Passo 5: Chamar o sistema para escrever o caractere na tela.
    MOV RAX, 1        ; syscall 1 = sys_write (escrever)
    MOV RDI, 1        ; stdout (saída padrão, a tela)
    MOV RSI, digito_para_imprimir ; O endereço do que queremos imprimir
    MOV RDX, 2        ; O tamanho (2 bytes: o dígito + a quebra de linha)
    SYSCALL           ; Executa a impressão!

    ; Passo 6: Decrementar o contador.
    DEC CX            ; Subtrai 1 de CX.

    ; Passo 7: Verificar se a contagem já terminou.
    CMP CX, 0         ; Compara o valor atual de CX com 0.
    JGE loop_inicio   ; JGE = Jump if Greater or Equal (Pule se for Maior ou Igual).
                      ; Enquanto CX for 0 ou mais, volta para o início do loop.

; fim: O loop termina quando CX se torna -1. O programa então continua para cá.
fim:
    ; Passo 8: Finalizar o programa de forma limpa.
    MOV RAX, 60       ; syscall 60 = sys_exit (sair)
    XOR RDI, RDI      ; Código de saída 0 (sucesso)
    SYSCALL