TITLE ProjetoFinal
.MODEL MEDIUM
.STACK 100h
.DATA

    Matriz_Escolhida DW 0 ;-Armazena o offset da matriz escolhida-;
    ReadLineMessage DB "Write the number of the line you want to attack(0-9): $"
    ReadCollumMessage DB "Write the number of the collum you want to attack(0-9): $"
    HitMessage DB "Hit! $"
    MissMessage DB "Miss! $"

    GamepadA DB 0,0,0,1,1,1,0,0,0,0
             DB 0,1,0,0,0,0,0,0,0,0
             DB 0,1,0,0,0,0,1,0,0,0
             DB 0,1,0,0,0,1,1,1,0,0
             DB 0,1,0,0,0,0,0,0,0,0
             DB 0,0,0,0,0,1,0,0,0,0
             DB 0,0,0,0,0,1,1,0,0,0
             DB 0,0,0,0,0,1,0,0,0,0
             DB 0,0,0,0,0,0,0,0,1,0
             DB 0,1,1,0,0,0,0,0,1,0
             DB 0,0,0,0,0,0,0,0,0,0
    
    GamepadB DB 1,0,0,0,0,0,0,1,1,0
             DB 1,0,0,0,1,0,0,0,0,0
             DB 1,0,0,1,1,1,0,0,0,0
             DB 0,0,0,0,0,0,0,0,0,0
             DB 0,0,0,0,0,0,0,0,1,0
             DB 0,1,0,0,0,0,0,0,1,0
             DB 0,1,1,0,0,0,0,0,0,0
             DB 0,1,0,0,0,0,0,0,0,0
             DB 0,0,0,0,0,0,0,0,0,0
             DB 0,0,0,1,1,1,1,0,0,0
             DB 0,0,0,0,0,0,0,0,0,0

    GamepadC DB 0,0,0,0,0,0,0,0,0,0
             DB 0,0,0,0,0,0,0,0,0,0
             DB 0,1,0,0,0,0,0,0,0,0
             DB 0,1,0,0,0,0,0,1,0,0
             DB 0,0,0,0,0,0,1,1,1,0
             DB 0,0,0,0,0,0,0,0,0,0
             DB 0,0,1,1,1,0,0,0,0,0
             DB 0,0,0,0,0,0,1,0,0,0
             DB 1,0,0,0,0,0,1,0,0,0
             DB 1,1,0,0,0,0,0,0,0,0
             DB 1,0,0,1,1,1,1,0,0,0
    
    GamepadD DB 0,0,0,0,0,0,0,0,0,0
             DB 0,1,1,0,0,0,0,0,0,0
             DB 0,0,0,0,1,0,0,0,0,1
             DB 0,0,0,1,1,1,0,0,0,1
             DB 0,0,0,0,0,0,0,0,0,1
             DB 0,0,0,0,0,0,0,0,0,1
             DB 0,0,1,1,0,0,0,0,0,0
             DB 0,0,0,0,0,0,0,0,0,0
             DB 0,0,0,1,0,0,0,0,0,0
             DB 0,0,0,1,0,0,0,1,0,0
             DB 0,0,0,1,0,0,1,1,1,0

;-MACROS-;

    ;-PUSH_ALL-;
    PUSH_ALL MACRO R1, R2, R3, R4 ;-Inicia o Macro-;

        PUSH R1
        PUSH R2
        PUSH R3
        PUSH R4

    ENDM ;-Finaliza o Macro-;

    ;-POP_ALL-;
    POP_ALL MACRO R1, R2, R3, R4 ;-Inicia o Macro-;
        POP R4
        POP R3
        POP R2
        POP R1
    ENDM ;-Finaliza o Macro-;

.CODE ;-Inicia a Sessão Code-;

MAIN PROC ;-Inicia a Sessão Main-;
    
    ;-Sessão Básica do Código-;
        MOV AX, @DATA ;-Conteúdo de DATA é direcionado para o registrador AX, gerando acesso ao conteúdo de DATA pelo programa-;
        MOV DS, AX ;-Endereço de AX é direcionado para o registrador DS-;

    ; Procedimento para escolher gamepad aleatório
        CALL EscolherGamepadAleatorio ;Retorna para o OFFSET do gamepad escolhido para a variavel 'Matriz_Escolhida'
        
    ;----------------------------;
    ;-PARTE GRÁFICA DO BIG PETER-;
    ;----------------------------;

    ; Procedimento de leitura da jogada do usuário
        CALL READ_ATTACK
    
    ;-Fim de Código-;
        MOV AH, 4Ch ;-Aloca o valor '4ch' (função de terminação de programa) para AH, que é parte de AX-;
        INT 21h ;-Chama a função do DOS que usa o valor de AH para determinar qual operação realizar-;

MAIN ENDP ;-Finaliza a sessão MAIN-;

;-PROCEDIMENTOS-;
    ; Função de geração de coordenadas aleatórias (usando segundos)
    EscolherGamepadAleatorio PROC
        
        PUSH_ALL AX, BX, CX, DX         ; Push dos resgistradores utilizados

        MOV AH, 00h                     ; Função para pegar a quantidade de ticks da CPU
        INT 1Ah                         ; Interrompe e passa a quantidade de ticks para DX
        ; LCG -> Xn+1 = A*Xn+1+C           
        MOV AX, 03h                     ; Parâmetro de multiplicação A=3
        MOV BX, 2                       ; Parâmetro de soma C=2
        MOV CX, 4                       ; Parâmetro de limite

        MUL DX                          ; Xn*A
        ADD AX, BX                      ; Xn*A+C
        DIV CX                          ; Xn+1/4
        ; DX = Resto (0-3), número escolhido

        CMP DX, 3                       ; Compara número aleatório com 3
        JE QUARTA                       ; Se DX=3, Utiliza a GamepadD

        CMP DX, 2                       ; Compara número aleatório com 2
        JE TERCEIRA                     ; Se DX=2, utiliza a GamepadC

        CMP DX, 1                       ; Compara número aleatório com 1
        JE SEGUNDA                      ;Se DX=1, Utiliza a GamepadB
        ; Caso contrário, utiliza a GamepadA

        PRIMEIRA:
            LEA DX, GamepadA            ; Carrega o OFFSET da GamepadA em DX
            MOV Matriz_Escolhida, DX    ; Salva o OFFSET da gamepad na variavel
            JMP FIM_ESCOLHA_GAMEPAD     ; JMP do fim do procedimento
        
        SEGUNDA:
            LEA DX, GamepadB            ; Carrega o OFFSET da GamepadB em DX
            MOV Matriz_Escolhida, DX    ; Salva o OFFSET da gamepad na variavel
            JMP FIM_ESCOLHA_GAMEPAD     ; JMP do fim do procedimento

        TERCEIRA:
            LEA DX, GamepadC            ; Carrega o OFFSET da GamepadC em DX
            MOV Matriz_Escolhida, DX    ; Salva o OFFSET da gamepad na variavel
            JMP FIM_ESCOLHA_GAMEPAD     ; JMP do fim do procedimento

        QUARTA:
            LEA DX, GamepadD            ; Carrega o OFFSET da GamepadD em DX
            MOV Matriz_Escolhida, DX    ; Salva o OFFSET da gamepad na variavel
            JMP FIM_ESCOLHA_GAMEPAD     ; JMP do fim do procedimento
            
    FIM_ESCOLHA_GAMEPAD:
        POP_ALL AX, BX, CX, DX          ; POP dos registradores utilizados
        
        RET                             ; Carrega o Endereço de retorno à MAIN salvo na pilha
    EscolherGamepadAleatorio ENDP
    
    ;----------------------------;
    ;-PARTE GRÁFICA DO BIG PETER-;
    ;----------------------------;

    ;-Leitura Da Jogada-;
    READ_ATTACK PROC

        PUSH_ALL AX, BX, CX, DX         ; Salva todos os registradores na pilha

        MOV AH, 9                       ; Função de impressão de string
        LEA ReadLineMessage, DX         ; Carrega o OFFSET da string em DX
        INT 21h                         ; Executa a função e imprime a string com OFFSET salvo em DX
        MOV AH, 1                       ; Função de leitura de caractere
        INT 21h                         ; Executa a leitura e salva em AL
        MOV SI, AL                      ; Salva a linha a ser manipulada em SI
        AND SI, 0Fh                     ; Converte o valor do caractere recebido para um número por meio da Função Lógica AND
        PulaLinha                       ; Macro para pular linha
        MOV AH, 9                       ; Função de impressão de string
        LEA ReadCollumMessage           ; Carrega o OFFSET da string em DX
        INT 21h                         ; Executa a impressão da string com OFFSER salvo em DX
        MOV AH, 1                       ; Função de leitura
        INT 21h                         ; Executa a leitura
        MOV DI, AL                      ; Salva a coluna a ser manipulada em DI
        AND DI, 0Fh                     ; Converte o valor do caractere recebido para um número por meio da Função Lógica AND

        MOV AX, 4
        MUL SI
        MOV SI, AX
        MOV BX, [Matriz_Escolhida]
        CMP [BX][SI][DI], 0
        JE Erro
        PulaLinha
        MOV AH, 9
        LEA DX, HitMessage
        INT 21h
        MOV [BX][SI][DI], 'X'
        PulaLinha
        JMP EndProc
        ERRO:
            MOV AH, 9
            LEA DX, MissMessage
            INT 21h
            MOV [BX][SI][DI], '-'
        POP_ALL AX, BX, CX, DX          ; Devolve os valores dos registradores na pilha

        RET                             ; Carrega o offset de retorno ao MAIN (que foi guardada na pilha)
    
    READ_ATTACK ENDP
END MAIN