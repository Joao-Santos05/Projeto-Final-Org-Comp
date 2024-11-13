TITLE ProjetoFinal
.MODEL MEDIUM
.STACK 100h
.DATA

    Matriz_Escolhida DW 0 ;-Armazena o offset da matriz escolhida-;
    ReadLineMessage DB "Write the number of the line you want to attack(1-10): $"
    ReadCollumMessage DB "Write the number of the collum you want to attack(1-10): $"
    HitMessage DB "Hit! $"
    MissMessage DB "Miss! $"

    GamepadBase DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0
                DB 0,0,0,0,0,0,0,0,0,0

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

    ; Macro para salvar todos registradores na pilha
    PUSH_ALL MACRO R1, R2, R3, R4

        PUSH R1
        PUSH R2
        PUSH R3
        PUSH R4

    ENDM

    ; Macro para voltar todos registradores salvos na pilha
    POP_ALL MACRO R1, R2, R3, R4

        POP R4
        POP R3
        POP R2
        POP R1

    ENDM 

    ; Macro para imprimir a quebra de linha
    PulaLinha MACRO
        PUSH AX
        PUSH DX

        MOV AH, 2
        MOV DX, 0Ah
        INT 21h
        MOV DX, 0Dh
        INT 21h

        POP DX
        POP AX
    ENDM

    SPACE MACRO
        PUSH AX
        PUSH DX

        MOV AH, 2
        MOV DL, 20h
        INT 21h

        POP DX
        POP AX
    ENDM

    EntDec MACRO
        LOCAL LoopScan
        LOCAL FimScan
        
        ;Retorna o número lido em BL
        PUSH AX
        PUSH CX

        XOR BX, BX
        XOR CX, CX
        LoopScan:
            MOV AH, 1
            INT 21h
            CMP AL, 0Dh
            JE FimScan
            MOV CL, AL
            AND CL, 0Fh
            MOV AX, 10
            MUL BX
            MOV BL, AL
            ADD BL, CL
            JMP LoopScan
        FimScan:

        POP CX
        POP AX
    ENDM
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

        ; Procedimento para imprimir a gamepad base
        CALL PrintGamepad
        
        ; Procedimento de leitura da jogada do usuário e atualização da gamepad base
        CALL READ_ATTACK

        CALL PrintGamepad
    
        ;-Fim de Código-;
        MOV AH, 4Ch ;-Aloca o valor '4ch' (função de terminação de programa) para AH, que é parte de AX-;
        INT 21h ;-Chama a função do DOS que usa o valor de AH para determinar qual operação realizar-;

    MAIN ENDP ;-Finaliza a sessão MAIN-;

    ; Procedimento de geração de coordenadas aleatórias
    EscolherGamepadAleatorio PROC NEAR
        
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
    ;description
    PrintGamepad PROC NEAR
        
        PUSH SI
        PUSH_ALL AX, BX, CX, DX

        MOV AH, 2
        XOR CX, CX
        MOV CH, 10
        XOR BX, BX
        Loop_linha:
            XOR SI, SI
            MOV CL, 10
            Loop_coluna:
                MOV DL, GamepadBase[BX][SI]
                INT 21h
                Space
                INC SI
                DEC CL
                JNZ Loop_coluna
            PulaLinha
            ADD BX, 10
            DEC CH
            JNZ Loop_linha

        POP_ALL AX, BX, CX, DX
        POP SI

        RET
    PrintGamepad ENDP

    ;-Leitura Da Jogada-;
    READ_ATTACK PROC NEAR

        PUSH SI
        PUSH DI
        PUSH_ALL AX, BX, CX, DX         ; Salva todos os registradores na pilha

        MOV AH, 9                       ; Função de impressão de string
        LEA DX, ReadLineMessage         ; Carrega o OFFSET da string em DX
        INT 21h                         ; Executa a função e imprime a string com OFFSET salvo em DX
        EntDec                          ; MACRO para entrada de número decimal
        MOV SI, BX                      ; Salva a linha a ser manipulada em SI
        DEC SI                          ; De 1-10 para 0-9
        PulaLinha                       ; Macro para pular linha
        LEA DX, ReadCollumMessage           ; Carrega o OFFSET da string em DX
        INT 21h                         ; Executa a impressão da string com OFFSER salvo em DX
        EntDec                          ; MACRO para entrada de número decimal
        MOV DI, BX                      ; Salva a coluna a ser manipulada em DI
        DEC DI                          ; De 1-10 para 0-9

        MOV AX, 10                      ; Salva o multiplicador em AX
        MUL SI                          ; AX*SI = DX:AX
        MOV SI, AX                      ; Passa resultado para SI
        MOV BX, [Matriz_Escolhida]      ; Salva o OFFSET da matriz escolhida em BX
        ADD BX, SI                      ; OFFSET + Pos LInha = Pos Linha Real
        CMP [BX][DI], 0                 ; Compara o conteúdo da posição escolhida com 0
        JE Erro                         ; Se Local escolhido for 0, usuário errou o tiro
        PulaLinha                       ; Se não, executa rotina de Impressão de acerto
        MOV AH, 9                       ; Função de impressão de string
        LEA DX, HitMessage              ; Salva o OFFSET da string em DX
        INT 21h                         ; Executa a impressão
        XCHG BX, SI                     ; Pos linha -> BX e salva conteúdo de BX em SI
        MOV GamepadBase[BX][DI], 'X'    ; Muda a posição acertada para X
        XCHG BX, SI                     ; Retorna os Conteúdos aos registradores de origem
        PulaLinha                       ; Macro para pular linha
        JMP EndProc                     ; Pula para o final do procedimento
        ERRO:
            PulaLinha                       ; Macro para pular linha
            MOV AH, 9                       ; Função de impressão de string
            LEA DX, MissMessage             ; Carrega o OFFSET da string em DX
            INT 21h                         ; Executa a impressão
            XCHG BX, SI                     ; Pos linha -> BX e salva conteúdo de BX em SI
            MOV GamepadBase[BX][DI], ' '    ; Muda a posição errada para spacebar
            XCHG BX, SI                     ; Retorna os Conteúdos aos registradores de origem
            PulaLinha                       ; Macro para pular linha
        EndProc:
            POP_ALL AX, BX, CX, DX          ; Devolve os valores dos registradores na pilha
            POP DI
            POP SI

        RET                             ; Carrega o offset de retorno ao MAIN (que foi guardada na pilha)
    
    READ_ATTACK ENDP
END MAIN