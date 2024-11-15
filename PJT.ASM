TITLE ProjetoFinal
.MODEL MEDIUM
.STACK 100h
.DATA
  ; Introdução:
  INTRO_TITLE DB 'BATTLESHIP | OSC 2S24', '$' ; Criação/definição da variável "INTRO_TITLE" que contém o título da introdução.	

  ; Regras/Instruções:
    RULES_TITLE DB 'RULES/INSTRUCTIONS:', '$' ; Criação/definição da variável "RULES_TITLE" que contém o título das regras/instruções.
    FIRST_RULE DB '> You play against the CPU', '$' ; Criação/definição da variável "FIRST_RULE" que contém a primeira regra.
    SECOND_RULE DB '> The CPU has a set of ships, which are', '$' ; Criação/definição da variável "SECOND_RULE" que contém a segunda regra.
    THIRD_RULE DB '   * 1 Battleship - 4 position length/size', '$' ; Criação/definição da variável "THIRD_RULE" que contém a terceira regra.
    FOURTH_RULE DB '   * 1 Frigate - 3 position length/size', '$' ; Criação/definição da variável "FOURTH_RULE" que contém a quarta regra.
    FIFTH_RULE DB '   * 2 Submarines - 2 position lenght/size', '$' ; Criação/definição da variável "FIFTH_RULE" que contém a quinta regra.
    SIXTH_RULE DB '   * 2 Hydroplanes - 4 position lenght/size ("T" format/shape)', '$' ; Criação/definição da variável "SIXTH_RULE" que contém a sexta regra.
    SEVENTH_RULE DB '> Vessels/ships cannot be docked:', '$'  ; Criação/definição da variável "SEVENTH_RULE" que contém a sétima regra.
    EIGHTH_RULE DB '   * There is a minimum distance of 1 square on every direction.', '$'  ; Criação/definição da variável "EIGHTH_RULE" que contém a oitava regra.
    NINTH_RULE DB '> You can try as many times as you want.', '$'  ; Criação/definição da variável "NINTH_RULE" que contém a nona regra.
    NINTH_RULE2 DB '   * You can stop the round by typing 0, 0 and Enter.', '$'
    TENTH_RULE DB '> The game ends when you sink all the enemy ships.', '$'  ; Criação/definição da variável "TENTH_RULE" que contém a décima regra.

    CONFIRM_MESSAGE DB 'PRESS ANY BUTTON TO CONTINUE', '$' ; Criação/definição da variável "CONFIRM_MESSAGE" que contém a confirmação de leitura.
    EndGameMessage DB 'THE END $'
    ScoreMessage DB 'You sank $'
    ScoreMessage2 DB '/19 positions $'

    Matriz_Escolhida DW 0 ;-Armazena o offset da matriz escolhida-;
    VictoryParam DB 19 ; Variável para fim do jogo
    ReadLineMessage DB "Write the number of the line you want to attack(A-J): $"
    ReadCollumMessage DB "Write the number of the collum you want to attack(1-10): $"
    PosInvalida DB "Invalid Position! Verify the index of the position you want to attack. $"
    PosAtingida DB "You have already used this position, try again. $"
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

    GamepadC DB 0,0,0,0,0,0,0,0,0,0
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
             DB 0,0,1,1,0,0,0,0,0,1
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
    PulaLinha MACRO PARAM ; Criação de MACRO para quebra/inicialização de nova linha.
        LOCAL REPEAT

        PUSH AX ; Salva o valor de AX na pilha.
        PUSH CX ; Salva o valor de CX na pilha.
        PUSH DX ; Salva o valor de DX na pilha.

        MOV CX,PARAM ; Movimentação/cópia do valor de PARAM (parâmetro) para CX.
        MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.

        REPEAT:
            MOV DL,10 ; Movimentação/cópia do valor 10 para DL (quebra de linha).
            INT 21H ; Conjunto de funções de entrada/saída.

            MOV DL,13 ; Movimentação/cópia do valor 13 para DL (retorno de carro).
            INT 21H ; Conjunto de funções de entrada/saída.

        LOOP REPEAT ; Loop de repetição.

        POP DX ; Restaura o valor de DX da pilha.
        POP CX ; Restaura o valor de CX da pilha.
        POP AX ; Restaura o valor de AX da pilha.
    ENDM ; Fim da MACRO.

    LEFT_TAB MACRO PARAM ; Criação de MACRO para impressão da tabulação das strings definidas no segmento de dados.
        PUSH AX ; Salva o valor de AX na pilha.
        PUSH BX ; Salva o valor de BX na pilha.
        PUSH CX ; Salva o valor de CX na pilha.
        PUSH DX ; Salva o valor de DX na pilha.
                
        MOV AH,3 ; Função responsável por obter a posição do cursor.
        MOV BH,0 ; Movimentação/cópia do valor 0 para BH. 
        INT 10H ; Conjunto de funções de vídeo.
                
        MOV AH,2 ; Função responsável por posicionar o cursor na tela.
        ADD DL,PARAM ; Movimentação/cópia do valor de PARAM (parâmetro) para DL.
        INT 10H ; Conjunto de funções de vídeo.
                
        POP DX ; Restaura o valor de DX da pilha.
        POP CX ; Restaura o valor de CX da pilha.
        POP BX ; Restaura o valor de BX da pilha.
        POP AX ; Restaura o valor de AX da pilha.
    ENDM ; Fim da MACRO.

    READ_CONFIRMATION MACRO ; Criação de MACRO para realizar a confirmação da leitura das instruções pelo jogador.
        MOV AH,9 ; Função responsável por imprimir uma string na tela.
        LEA DX,CONFIRM_MESSAGE ; Carregamento do endereço da variável "CONFIRM_MESSAGE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        MOV AH,1 ; Função responsável por ler um caractere do teclado.
        INT 21H ; Conjunto de funções de entrada/saída.
    ENDM

    SPACE MACRO
        PUSH AX
        PUSH DX

        MOV AH, 2
        MOV DX, 20h
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

    CLEAR_SCREEN MACRO ; Criação/definição do procedimento "CLEAR_SCREEN" para limpeza da tela.
        PUSH AX
        
        MOV AX,03H ; Movimentação/cópia do valor 3 para AX (limpeza da tela).
        INT 10H ; Conjunto de funções de vídeo.
        
        POP AX
        
    ENDM
.CODE ;-Inicia a Sessão Code-;

    MAIN PROC ;-Inicia a Sessão Main-;
        
        ;-Sessão Básica do Código-;
        MOV AX, @DATA ;-Conteúdo de DATA é direcionado para o registrador AX, gerando acesso ao conteúdo de DATA pelo programa-;
        MOV DS, AX ;-Endereço de AX é direcionado para o registrador DS-;

        ; Procedimento para escolher gamepad aleatório
        CALL EscolherGamepadAleatorio ;Retorna para o OFFSET do gamepad escolhido para a variavel 'Matriz_Escolhida'
        
        CLEAR_SCREEN                  ;Macro para limpar tela

        CALL INTRODUCTION_SCREEN      ;Função gráfica para introdução

        READ_CONFIRMATION             ;Macro para aguardar ação do usuário

        CLEAR_SCREEN                  ;Macro para limpar tela
        
        ; Procedimento para imprimir a gamepad base
        CALL PrintGamepad
        
        GameLoop:
            ; Procedimento de leitura da jogada do usuário e atualização da gamepad base
            CALL READ_ATTACK
            CMP VictoryParam, 0       ;Compara quantas posições restam a acertar
            JE Encerramento           ;Se não restar nenhuma, Pula para o encerramento
            PulaLinha 2               ;Macro para pular linha
            READ_CONFIRMATION         ;Macro para aguardar ação do usuário
            CLEAR_SCREEN              ;Macro para limpar tela

            CALL PrintGamepad         ; Procedimento oara imprimir a gamepad base
            JMP GameLoop              ; 
        Encerramento:
        MOV VictoryParam, DL          ;

        CLEAR_SCREEN
        CALL FinalScreen
        
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

    INTRODUCTION_SCREEN PROC NEAR; Criação/definição do procedimento "INTRODUCTION_SCREEN" para exibição da tela de introdução.
        MOV AH,9 ; Função responsável por imprimir uma string na tela.

        PulaLinha 2 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 25 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,INTRO_TITLE ; Carregamento do endereço da variável "INTRO_TITLE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 3 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,RULES_TITLE ; Carregamento do endereço da variável "RULES_TITLE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 2 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,FIRST_RULE ; Carregamento do endereço da variável "FIRST_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,SECOND_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,THIRD_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,FOURTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,FIFTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,SIXTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,SEVENTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,EIGHTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,NINTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,NINTH_RULE2 ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX,TENTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
        INT 21H ; Conjunto de funções de entrada/saída.

        PulaLinha 4 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 23 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        RET ; Retorno do procedimento.
    INTRODUCTION_SCREEN ENDP ; Fim do procedimento "INTRODUCTION_SCREEN".

    ; Proc para printar a tabela para o usuário
    PrintGamepad PROC NEAR
        
        PUSH SI
        PUSH_ALL AX, BX, CX, DX
        MOV BX, 1
        MOV CX, 10
        LEFT_TAB 4
        Loop_Indice:
            CALL SaiDec
            INC BX
            SPACE
            LOOP Loop_Indice

        PulaLinha 1
        MOV AH, 2
        XOR CX, CX
        MOV CH, 10
        XOR BX, BX
        MOV DL, 'A'
        Loop_linha:
            LEFT_TAB 2
            XOR SI, SI
            MOV CL, 10
            INT 21h
            LEFT_TAB 1
            INC DL
            PUSH DX
            Loop_coluna:
                MOV DL, GamepadBase[BX][SI]
                CMP DL, 20h
                JE NotNumber
                CMP DL, 'X'
                JE NotNumber
                OR DL, 30h
                NotNumber:
                    INT 21h
                    SPACE
                    INC SI
                    DEC CL
                    JNZ Loop_coluna
            PulaLinha 1
            ADD BX, 10
            DEC CH
            POP DX
            JNZ Loop_linha

        PulaLinha 2
        POP_ALL AX, BX, CX, DX
        POP SI

        RET
    PrintGamepad ENDP

    ;-Leitura Da Jogada-;
    READ_ATTACK PROC NEAR

        PUSH SI
        PUSH_ALL AX, BX, CX, DI         ; Salva todos os registradores na pilha

        LerLinha:
            MOV AH, 9                       ; Função de impressão de string
            LEA DX, ReadLineMessage         ; Carrega o OFFSET da string em DX
            INT 21h                         ; Executa a função e imprime a string com OFFSET salvo em DX
            MOV AH, 1                       ; Função de leitura de caractere
            INT 21h                         ; Executa a leitura
            CMP AL, 30h
            JZ LerColuna
            CMP AL, 'A'
            JL ErrorLineMSG                 ; Se AL < 'A', não é uma letra válida
            CMP AL, 'J'
            JLE MAIUSCULA                   ; Se AL <= 'J', é uma letra maiúscula válida
            CMP AL, 'a'
            JL ErrorLineMSG                 ; Se AL < 'a', não é uma letra válida
            CMP AL, 'j'
            JG ErrorLineMSG                 ; Se AL > 'j', não é uma letra válida
            JMP MINUSCULA
        ErrorLineMsg:
            PulaLinha 1
            MOV AH, 9
            LEA DX, PosInvalida
            INT 21h
            PulaLinha 2
            JMP LerLinha
        MAIUSCULA:
            SUB AL, 41h                     ; Converte Maiusculo para número
            JMP CONTINUA
        MINUSCULA:
            SUB AL, 61h                     ; Converte Minusculo para númeroS
        CONTINUA:
            XOR AH, AH
            MOV SI, AX                      ; Salva a linha a ser manipulada em SI
        LerColuna:
            PulaLinha 2                     ; Macro para pular linha
            MOV AH, 9
            LEA DX, ReadCollumMessage       ; Carrega o OFFSET da string em DX
            INT 21h                         ; Executa a impressão da string com OFFSER salvo em DX
            EntDec                          ; MACRO para entrada de número decimal
            OR BX, BX
            JZ EncerrarJogo
            CMP BX, 10
            JG ErrorCollumMSG
            JMP SEGUE
        EncerrarJogo:
            MOV DL, VictoryParam
            XOR DH, DH
            MOV VictoryParam, 0
            JMP EndProc
        ErrorCollumMSG:
            PulaLinha 1
            MOV AH, 9
            LEA DX, PosInvalida
            INT 21h
            PulaLinha 2
            JMP LerColuna
        SEGUE:
            MOV DI, BX                      ; Salva a coluna a ser manipulada em DI
            DEC DI                          ; De 1-10 para 0-9

        MOV AX, 10                      ; Salva o multiplicador em AX
        MUL SI                          ; AX*SI = DX:AX
        MOV SI, AX                      ; Passa resultado para SI
        MOV BX, [Matriz_Escolhida]      ; Salva o OFFSET da matriz escolhida em BX
        ADD BX, SI                      ; OFFSET + Pos LInha = Pos Linha Real
        XCHG BX, SI
        CMP GamepadBase[BX][DI], ' '
        JE EspacoJaAtingido
        CMP GamepadBase[BX][DI], 'X'
        JE EspacoJaAtingido
        XCHG BX, SI
        CMP BYTE PTR [BX][DI], 0        ; Compara o conteúdo da posição escolhida com 0
        JE Erro                         ; Se Local escolhido for 0, usuário errou o tiro
        PulaLinha 1                     ; Se não, executa rotina de Impressão de acerto
        DEC VictoryParam
        MOV AH, 9                       ; Função de impressão de string
        LEA DX, HitMessage              ; Salva o OFFSET da string em DX
        INT 21h                         ; Executa a impressão
        XCHG BX, SI                     ; Pos linha -> BX e salva conteúdo de BX em SI
        MOV GamepadBase[BX][DI], 'X'    ; Muda a posição acertada para X
        XCHG BX, SI                     ; Retorna os Conteúdos aos registradores de origem
        PulaLinha 2                     ; Macro para pular linha
        JMP EndProc                     ; Pula para o final do procedimento
        EspacoJaAtingido:
            PulaLinha 1
            MOV AH, 9
            LEA DX, PosAtingida
            INT 21h
            PulaLinha 2
            JMP EndProc
        ERRO:
            PulaLinha 1                     ; Macro para pular linha
            MOV AH, 9                       ; Função de impressão de string
            LEA DX, MissMessage             ; Carrega o OFFSET da string em DX
            INT 21h                         ; Executa a impressão
            XCHG BX, SI                     ; Pos linha -> BX e salva conteúdo de BX em SI
            MOV GamepadBase[BX][DI], ' '    ; Muda a posição errada para spacebar
            XCHG BX, SI                     ; Retorna os Conteúdos aos registradores de origem
            PulaLinha 2                     ; Macro para pular linha
        EndProc:
            POP_ALL AX, BX, CX, DI          ; Devolve os valores dos registradores na pilha
            POP SI

        RET                             ; Carrega o offset de retorno ao MAIN (que foi guardada na pilha)
    
    READ_ATTACK ENDP

    SaiDec PROC NEAR
        ; BX carrega o número a ser printado
        PUSH_ALL AX, CX, DX, DI

        MOV DI, 10
        XOR CX, CX
        MOV AX, BX          ;PASSA O NUMERO A SER DIVIDIDO PARA AX
        XOR DX, DX          ;tira o lixo de dx
        OUTPUTDECIMAL:
            DIV DI              ;AX / DI    --> QUOCIENTE VAI PARA AX E RESTO VAI PARA DX
            PUSH DX
            XOR DX, DX
            INC CX
            OR AX, AX
            JNZ OUTPUTDECIMAL
        
        MOV AH, 2
        IMPRIMIRDECIMAL:
            POP DX
            OR DL, 30H
            INT 21H
            LOOP IMPRIMIRDECIMAL

        POP_ALL AX, CX, DX, DI
        RET

    SaiDec ENDP

    FinalScreen PROC NEAR
        MOV AH, 9   ; Função responsável por imprimir uma string na tela.

        PulaLinha 5 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
        LEFT_TAB 37 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

        LEA DX, EndGameMessage  ; Carregamento do endereço da variável "INTRO_TITLE" em SI.
        INT 21H                 ; Conjunto de funções de entrada/saída.

        PulaLinha 1
        LEFT_TAB 29
        LEA DX, ScoreMessage
        INT 21h
        MOV CL, VictoryParam
        MOV BL, 19
        SUB BL, CL
        CALL SaiDec
        LEA DX, ScoreMessage2
        INT 21h

        RET
    FinalScreen ENDP
END MAIN