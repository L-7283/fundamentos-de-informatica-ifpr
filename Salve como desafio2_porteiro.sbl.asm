; Define a seção para dados (memória)
section .bss
    resultado resb 2 ; Reserva 2 bytes: 1 para o dígito e 1 para a quebra de linha

; Define a seção de código executável
section .text
global _start

_start:
    ; --- DEFINA A IDADE PARA TESTAR AQUI ---
    MOV AX, 25     ; <<-- Mude este número para testar! (25, 18, 17, etc.)


    ; --- LÓGICA DE VERIFICAÇÃO ---

    ; Passo 1: Assumimos que o acesso é NEGADO por padrão.
    MOV byte [resultado], '0'

    ; Passo 2: Comparamos a idade com 18.
    CMP AX, 18

    ; Passo 3: Se a idade for MENOR que 18, pulamos a permissão.
    JL imprimir_agora ; JL = Jump if Less (Pular se for Menor)

    ; Passo 4: Se o programa chegou até aqui, a idade é 18 ou maior.
    ; Então, mudamos o resultado para PERMITIDO.
    MOV byte [resultado], '1'


; --- Bloco de Impressão e Saída ---
imprimir_agora:
    MOV byte [resultado + 1], 10 ; Adiciona o caractere de quebra de linha

    ; Chamada de sistema para escrever na tela
    MOV RAX, 1        ; syscall 1 = sys_write
    MOV RDI, 1        ; stdout (saída padrão, a tela)
    MOV RSI, resultado ; Endereço da memória com nosso resultado
    MOV RDX, 2        ; Tamanho da mensagem (o dígito + a quebra de linha)
    SYSCALL           ; Executa a chamada

; fim: Finaliza o programa de forma limpa
fim:
    MOV RAX, 60       ; syscall 60 = sys_exit
    XOR RDI, RDI      ; Código de saída 0 (sucesso)
    SYSCALL