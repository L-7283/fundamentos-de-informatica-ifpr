; --- Missão 3: O Gerador de Fibonacci ---
; Objetivo: Calcular o 8º termo da sequência (0, 1, 1, 2, 3, 5, 8, 13, 21 <- queremos este).

section .text
    global _start

_start:
    ; --- Inicialização ---
    ; LOAD 7 -> Usaremos CX como nosso contador.
    ; Para chegar no 8º termo (F(8)), partindo de F(1), precisamos de 7 cálculos.
    mov cx, 7        

    ; LOAD 0 -> Termo N-2 (o penúltimo).
    ; STORE BX -> Guarda o termo N-2 em BX.
    mov bx, 0        

    ; LOAD 1 -> Termo N-1 (o último). AX conterá o termo atual.
    mov ax, 1        

; --- Loop principal de cálculo ---
loop_fibonacci:
    ; A lógica principal é: Novo Termo = Termo Atual + Termo Anterior
    ; Em Assembly, a troca de valores para a próxima iteração é mais simples.
    ; Usaremos um registrador temporário (DX) para fazer a troca de forma clara.

    ; 1. Salva o termo atual (AX) antes de calcular o próximo.
    mov dx, ax       ; DX = Termo N-1 (ex: na 1ª iteração, DX = 1)

    ; 2. Calcula o novo termo.
    ; ADD BX -> AX (Novo Termo N) = AX (Termo N-1) + BX (Termo N-2).
    add ax, bx       ; AX = Novo Termo N (ex: na 1ª iteração, AX = 1 + 0 = 1)

    ; 3. Atualiza o termo anterior (N-2) para ser o termo que acabamos de usar (N-1).
    ; O valor que estava em AX (e salvamos em DX) se torna o novo "penúltimo".
    mov bx, dx       ; BX = Termo N-1 (ex: na 1ª iteração, BX = 1)

    ; Agora AX tem o novo termo e BX tem o termo anterior, prontos para a próxima iteração.
    
    ; DEC CX -> Decrementa nosso contador.
    dec cx           

    ; JNZ loop -> Se o contador (CX) não for zero, volta para o início do loop.
    jnz loop_fibonacci

; --- Fim do programa ---
; O resultado final (o 8º termo, 21) está no registrador AX.
; Agora, preparamos para encerrar o programa.
fim:
    ; HLT -> Finaliza o programa de forma controlada.
    ; O valor em EAX será o "código de saída" do programa.
    ; Movemos o resultado de AX para EAX. 'movzx' zera a parte superior de EAX.
    movzx eax, ax

    mov ebx, eax    ; A syscall 'exit' espera o código de saída em EBX.
    mov eax, 1      ; Código da syscall 'exit'.
    int 0x80        ; Chama o sistema operacional para terminar.