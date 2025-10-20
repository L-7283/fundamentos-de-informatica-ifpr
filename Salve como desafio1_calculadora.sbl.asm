; Define a seção para dados inicializados
section .data
    ; Não precisamos de dados pré-definidos aqui

; Define a seção para dados não inicializados (para nosso resultado em texto)
section .bss
    resultado_texto resb 3  ; Reserva 3 bytes de memória para o resultado
                            ; (2 dígitos + 1 quebra de linha)

; Define a seção de código
section .text
global _start

_start:
    ; --- Início do seu cálculo original ---
    MOV AX, 100   ; Carrega 100 em AX
    ADD AX, 50    ; Adiciona 50 a AX (AX = 150)
    SUB AX, 30    ; Subtrai 30 de AX (AX = 120)

    MOV BX, AX    ; Copia o valor para BX (BX = 120)

    MOV AX, 2     ; Carrega 2 em AX
    MUL BX        ; Multiplica AX por BX (DX:AX = 2 * 120 = 240)

    MOV BX, 10    ; Carrega o divisor 10
    XOR DX, DX    ; Zera DX, pois DIV usa o par DX:AX para a divisão
    DIV BX        ; Divide DX:AX por BX. Quociente em AX (AX = 24), Resto em DX
    ; --- Fim do seu cálculo original. O resultado (24) está em AX ---


    ; --- Conversão do número 24 para texto (ASCII) ---
    MOV CX, 10        ; Divisor para separar os dígitos
    XOR DX, DX        ; Limpa DX para a divisão
    DIV CX            ; Divide AX (24) por 10. AX=2 (quociente), DX=4 (resto)

    ADD AL, '0'       ; Converte o dígito 2 para o caractere '2' (ASCII)
    ADD DL, '0'       ; Converte o dígito 4 para o caractere '4' (ASCII)

    ; Armazena os caracteres na memória para impressão
    MOV [resultado_texto], AL     ; Coloca '2' no início do nosso buffer
    MOV [resultado_texto + 1], DL ; Coloca '4' na segunda posição

    ; Adiciona uma quebra de linha para a saída ficar mais limpa
    MOV byte [resultado_texto + 2], 10 ; 10 é o código ASCII para "nova linha"


    ; --- Chamada de Sistema (Syscall) para Escrever na Tela ---
    ; Em Linux x86-64, a syscall 'write' tem o número 1
    MOV RAX, 1        ; Número da syscall sys_write
    MOV RDI, 1        ; File descriptor 1 (stdout - saída padrão/tela)
    MOV RSI, resultado_texto ; Endereço da mensagem a ser impressa
    MOV RDX, 3        ; Tamanho da mensagem em bytes ('2', '4', e a quebra de linha)
    SYSCALL           ; Executa a chamada de sistema


    ; --- Chamada de Sistema (Syscall) para Sair do Programa ---
    ; É uma boa prática finalizar o programa de forma limpa
    MOV RAX, 60       ; Número da syscall sys_exit
    XOR RDI, RDI      ; Código de saída 0 (sucesso)
    SYSCALL           ; Executa a chamada de sistema