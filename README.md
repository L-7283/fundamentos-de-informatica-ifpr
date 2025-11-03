 # Meus Projetos de Fundamentos de Informática - IFPR

Este repositório contém os códigos desenvolvidos durante as aulas práticas da disciplina de Fundamentos de Informática com o Prof. Vagner Simões Santos, utilizando o simulador Simbler.

---

## B4.P1.A3 - Desafios da ULA

Nesta atividade, foram desenvolvidos três programas distintos para explorar diferentes funcionalidades da linguagem Assembly.

### 1. Desafio da Calculadora (`desafio1_calculadora.sbl`)

*   **Objetivo:** Calcular a expressão matemática `(100 + 50 - 30) * 2 / 10`.
*   **Comandos Utilizados:** `LOAD`, `ADD`, `SUB`, `STORE`, `MUL`, `DIV`, `HLT`.
*   **Resultado Esperado:** Ao final da execução, o valor **24** é armazenado nos registradores AX e CX.

### 2. Desafio do Porteiro Digital (`desafio2_porteiro.sbl`)

*   **Objetivo:** Simular uma verificação condicional. O programa verifica se o valor inicial é igual a 18.
*   **Comandos Utilizados:** `LOAD`, `CMP` (Comparar) e `JZ` (Pular se Zero).
*   **Lógica de Funcionamento:**
    *   Se o valor de entrada for `18`, o programa termina com `1` no registrador AX (acesso permitido).
    *   Se o valor for diferente de `18`, ele termina com `0` em AX (acesso negado).
*   **Conceito-Chave:** Este programa demonstra o uso do **Zero Flag (Z)** para controlar o fluxo de execução com um salto condicional.

### 3. Desafio da Contagem Regressiva (`desafio3_contagem.sbl`)

*   **Objetivo:** Implementar um loop simples que decrementa um contador de 5 até 0.
*   **Comandos Utilizados:** `LOAD`, `DEC` (Decrementar), `CMP`, `JZ` e `JMP` (Pular).
*   **Lógica de Funcionamento:** O programa entra em um ciclo onde subtrai 1 do valor em AX e verifica se já chegou a zero. Enquanto não for zero, ele volta ao início do loop usando `JMP`. Quando chega a zero, ele usa `JZ` para sair do loop e encerrar.
*   **Conceito-Chave:** Demonstração de uma estrutura de repetição (loop) em Assembly.

## B4.P1.A4 - Missões de Baixo Nível

Nesta atividade, foram desenvolvidos três programas para explorar o uso de memória, saltos condicionais avançados e loops.

### 1. Missão do Cofre Secreto (`missao1_cofre.sbl`)
*   **Objetivo:** Ler um número da posição de memória `@0` e verificar se ele é par.
*   **Conceitos-Chave:** Uso de `DB` para definir dados na memória, `LOAD @` para ler da memória, e a lógica de `(N/2)*2 == N` para checar a paridade.
*   **Resultado:** Termina com `1` em AX se o número for par, e `0` se for ímpar.

### 2. Missão do Termostato Inteligente (`missao2_termostato.sbl`)
*   **Objetivo:** Simular um termostato que decide entre ligar o ar-condicionado, o aquecedor ou ficar desligado com base em uma temperatura de entrada.
*   **Conceitos-Chave:** Uso de `SUB` para criar condições e o salto condicional `JS` (Pular se Negativo) para tomar decisões baseadas no **Signal Flag (S)**.
*   **Resultado:** `1` (ar), `-1` (aquecedor) ou `0` (desligado).

### 3. Missão do Gerador de Fibonacci (`missao3_fibonacci.sbl`)
*   **Objetivo:** Calcular o 8º termo da sequência de Fibonacci (13).
*   **Conceitos-Chave:** Implementação de um loop complexo com um contador, manipulação de múltiplos registradores para guardar valores intermediários e o uso de `JNZ` (Pular se Não-Zero) para controlar o loop.
*   **Resultado:** O programa termina com o valor `13` no registrador AX.
