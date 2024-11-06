TITLE ProjetoFinal
.MODEL MEDIUM
.STACK 100h
.DATA

    Matriz_Escolhida DW 0 ;-Armazena o offset da matriz escolhida-;

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

    ;Procedimento para escolher gamepad aleatório
        CALL EscolherGamepadAleatorio ;Retorna para o OFFSET do gamepad escolhido para a variavel 'Matriz_Escolhida'
        
    ;----------------------------;
    ;-PARTE GRÁFICA DO BIG PETER-;
    ;----------------------------;

    ;-Fim de Código-;
        MOV AH, 4Ch ;-Aloca o valor '4ch' (função de terminação de programa) para AH, que é parte de AX-;
        INT 21h ;-Chama a função do DOS que usa o valor de AH para determinar qual operação realizar-;

MAIN ENDP ;-Finaliza a sessão MAIN-;

;-PROCEDIMENTOS-;
    ; Função de geração de coordenadas aleatórias (usando segundos)
    EscolherGamepadAleatorio PROC
        
        PUSH_ALL AX, BX, CX, DX

        MOV AH, 00h        ; Função para pegar a quantidade de ticks da CPU
        INT 1Ah            ; Interrompe e passa a quantidade de ticks para DX
        ; LCG -> Xn+1 = A*Xn+1+C           
        MOV AX, 03h        ; Parâmetro de multiplicação A=3
        MOV BX, 2          ; Parâmetro de soma C=2
        MOV CX, 4          ; Parâmetro de limite

        MUL DX             ; Xn*A
        ADD AX, BX         ; Xn*A+C
        DIV CX             ; Xn+1/4
        ; DX = Resto (0-3), número escolhido

        CMP DX, 3
        JE QUARTA

        CMP DX, 2
        JE TERCEIRA

        CMP DX, 1
        JE SEGUNDA
        
        PRIMEIRA:
            LEA DX, GamepadA
            MOV Matriz_Escolhida, DX
            JMP FIM_ESCOLHA_GAMEPAD
        
        SEGUNDA:
            LEA DX, GamepadB
            MOV Matriz_Escolhida, DX
            JMP FIM_ESCOLHA_GAMEPAD

        TERCEIRA:
            LEA DX, GamepadC
            MOV Matriz_Escolhida, DX
            JMP FIM_ESCOLHA_GAMEPAD

        QUARTA:
            LEA DX, GamepadD
            MOV Matriz_Escolhida, DX
            JMP FIM_ESCOLHA_GAMEPAD
            

    FIM_ESCOLHA_GAMEPAD:
        POP_ALL AX, BX, CX, DX
        
        RET                 ; Retorna com coordenadas válidas
    EscolherGamepadAleatorio ENDP
    
    ;----------------------------;
    ;-PARTE GRÁFICA DO BIG PETER-;
    ;----------------------------;

    ;-Leitura Da Jogada-;
    READ_ATTACK PROC ;-Inicializa o Procedimento, definindo seu tipo (FAR: Procedimento em outro segmento do código; NEAR: Procedimento no mesmo segmento do código)-;

    MOV SI, AL
    AND SI, 0Fh ;-Converte o valor do caractere recebido para um número por meio da Função Lógica AND-;

    MOV DI, AL
    AND DI, 0Fh ;-Converte o valor do caractere recebido para um número por meio da Função Lógica AND-;

        RET ;-Carrega o offset da próxima instrução (que foi guardada na pilha) em IP-;
    
    READ_ATTACK ENDP ;-Finaliza o Procedimento-;

END MAIN ;-Finaliza o Código-;