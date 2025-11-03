; --- Missão 1: O Cofre Secreto (Tradução para Assembly Real) ---

section .data
    ; DB 42: Define a senha na memória.
    ; Usamos 'dw' (Define Word) para alocar 2 bytes, o tamanho do registrador AX.
    ; Mude o valor 42 aqui para testar com números pares ou ímpares.
    senha dw 42

section .text
    global _start

_start:
    ; // Etapa 1: Ler a senha da memória.
    ; LOAD @0  -> Carrega o valor da 'senha' em AX.
    mov ax, [senha]
    
    ; STORE BX -> Guarda a senha original em BX para a comparação.
    mov bx, ax       

    ; // Etapa 2: A lógica para verificar se é par.
    ; DIV 2 -> Divide AX por 2.
    ; Em x86, a divisão 'div' usa os registradores DX e AX juntos.
    ; Por isso, precisamos primeiro zerar DX.
    mov dx, 0        
    mov cx, 2        ; Coloca o divisor (2) em um registrador.
    div cx           ; Divide DX:AX por CX. O resultado fica em AX.

    ; MUL 2 -> Multiplica o resultado em AX por 2.
    mul cx           ; Multiplica AX por CX. O resultado fica em DX:AX.
                     ; Como o número é pequeno, ele caberá em AX.

    ; // Etapa 3: A comparação.
    ; CMP BX -> Compara o resultado do cálculo (AX) com o original (BX).
    cmp ax, bx       
    
    ; JZ abre_cofre -> Pula se forem iguais (Jump if Zero/Equal).
    je abre_cofre    ; Se (N/2)*2 == N, o número é par.

; // Se não pulou, a senha era ímpar.
falha:
    ; LOAD 0 -> Carrega 0 em AX (sinal de falha).
    mov eax, 0
    jmp fim          ; Pula para o final.

abre_cofre:
    ; LOAD 1 -> Carrega 1 em AX (sinal de sucesso).
    mov eax, 1

fim:
    ; HLT -> Finaliza o programa de forma limpa.
    ; Em um sistema operacional, pedimos para ele encerrar o programa.
    mov ebx, eax     ; O código de saída (0 ou 1) é passado para EBX.
    mov eax, 1       ; Código da chamada de sistema (syscall) para "exit".
    int 0x80         ; Executa a chamada, terminando o programa.