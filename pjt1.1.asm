TITLE PROJETO-FINAL
.MODEL MEDIUM
.STACK 100h
; Segmento de dados
.DATA
    tabela DB 20 DUP(20 DUP(0))    ; Matriz 20x20
    tamanho DB 4,3,2,4             ; Vetor com os tamanhos das embarcações: 4 (encouraçado), 3 (fragata), 2 (submarino), 4 (hidroavião)
    tipos DB 1,2,3,4               ; Vetor de tipos para as embarcações 1 (encouraçado), 2 (fragata), 3 (submarino), 4 (hidroavião)
    LeituraCoord DB 'Digite as coordenadas (linha, coluna): $'
    MsgErro DB 'Errou! $'
    MsgAcerto DB 'Acertou! $'
; Segmento de código
.CODE
    MAIN PROC
        ; Configuração inicial
        MOV AX, @DATA
        MOV DS, AX

        ; Chama funções de posicionamento de embarcações
        ; Tamanho e tipo das embarcações são passados nos registradores BX e DX

        XOR SI, SI       ; Zera SI para a manipulação dos vetores
        MOV CX, 1        ; Quantidade de embarcações a serem alocadas
        ; Posicionar encouraçado (tamanho 4, tipo 1)
        PosicionarEncouracado:
            MOV AL, tamanho[SI]
            MOV BX, AX        ; Tamanho do encouraçado
            MOV AL, tipos[SI]
            MOV DX, AX        ; Identificador do encouraçado
            CALL PosEmbarcacao
            LOOP PosicionarEncouracado
        INC SI          ; Passa para a próxima posição do vetor
        MOV CX, 1       ; Quantidade de embarcaçõe a serem alocadas
        ; Posicionar fragata (Tamanho 3, tipo 2)
        PosicionarFragata:
            MOV AL, tamanho[SI]
            MOV BX, AX        ; Tamanho da fragata
            MOV AL, tipos[SI]
            MOV DX, AX        ; Identificador da fragata
            CALL PosEmbarcacao
            LOOP PosicionarFragata
        INC SI          ; Passa para a próxima posição do vetor
        MOV CX, 2       ; Quantidade de embarcaçõe a serem alocadas
        ; Posicionar submarino (Tamanho 2, tipo 3)
        PosicionarSubmarino:
            MOV AL, tamanho[SI]
            MOV BX, AX        ; Tamanho do submarino
            MOV AL, tipos[SI]
            MOV DX, AX        ; Identificador do submarino
            CALL PosEmbarcacao
            LOOP PosicionarSubmarino
        INC SI          ; Passa para a próxima posição do vetor
        MOV CX, 2       ; Quantidade de embarcações a serem alocadas
        ; Posicionar hidroavião (tamanho 4, tipo 4)
        PosicionarHidroaviao:
            MOV AL, tamanho[SI]
            MOV BX, AX        ; Tamanho do submarino
            MOV AL, tipos[SI]
            MOV DX, AX        ; Identificador do submarino
            CALL PosEmbarcacao
            LOOP PosicionarHidroaviao
        ; Fim do programa
        MOV AH, 4Ch      ; Interrompe para finalizar o programa
        INT 21h
    MAIN ENDP
    ; Função de posicionamento generalizada
    PosEmbarcacao PROC
        ; Recebe o tamanho da embarcação em BX
        ; Recebe o tipo de embarcação em DX
        PUSH AX
        PUSH CX

        CMP DX, 4                 ; Verifica se é o hidroavião
        JE PosicionarHidroaviao    ; Se for o hidroavião, vai para a função específica

        BuscarPosicao:
            CALL GerarPosicaoAleatoria ; Gera nova coordenada (SI = POS Linha, DI = POS Coluna)

            ; Decide orientação aleatória (horizontal ou vertical)
            MOV AH, 02h
            INT 1Ah
            MOV AL, CH
            AND AL, 01h                 ; 0 = horizontal, 1 = vertical
            JZ VerificaHorizontal      ; Se 0, tenta posicionar na horizontal
            JMP VerificaVertical       ; Se 1, tenta posicionar na vertical

        VerificaHorizontal:
            MOV CX, BX                 ; Tamanho da embarcação em CX (número de células)
            ; Lógica para verificar e alocar células na horizontal

            JMP BuscarPosicao       ; Se falhar, tenta nova posição

        VerificaVertical:
            MOV CX, BX                 ; Tamanho da embarcação em CX (número de células)
            ; Lógica para verificar e alocar células na vertical
            JMP BuscarPosicao       ; Se falhar, tenta nova posição

            ; Se encontrar posição válida, aloca na matriz
            ; ...
        
        POP CX
        POP AX

        RET
    PosEmbarcacao ENDP

    ; Função de posicionamento específica do hidroavião
    PosHidroaviao PROC
    BuscarPosicaoHidro:
        CALL GerarPosicaoAleatoria ; Gera posição central da cruz do hidroavião
        CMP AX, -1                 ; Verifica se a posição foi inválida
        JE BuscarPosicaoHidro   ; Se inválida, tenta novamente

        ; Lógica específica para o hidroavião (célula central + cruz)
        ; Verifica se há espaço suficiente
        
        JMP BuscarPosicaoHidro  ; Se falhar, tenta nova posição

        ; Se encontrar posição válida, aloca na matriz
        

    PosHidroaviao ENDP

    ; Função de geração de coordenadas aleatórias (usando segundos)
    GerarPosicaoAleatoria PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        MOV AH, 00h        ; Função para pegar a quantidade de ticks da CPU
        INT 1Ah            ; Interrompe e passa a quantidade de ticks para DX
        ; LCG -> Xn+1 = A*Xn+1+C    
        MOV SI, DX         ; Salva a qtd de ticks em DX para não ser alterado com o MUL       
        MOV AX, 03h        ; Parâmetro de multiplicação A=3
        MOV BX, 2          ; Parâmetro de soma C=2
        MOV CX, 20         ; Parâmetro de limite

        MUL SI             ; Xn*A
        ADD AX, BX         ; Xn*A+C
        DIV CX             ; Xn+1/20
        MOV SI, DX         ; Pos aleatória em SI

        ; Gera coordenada para a coluna
        MOV DI, SI         ; SEED para DI
        MOV AX, 02h        ; Parâmetro de multiplicação
        MOV BX, 3          ; Parâmetro de soma
        MOV CX, 20         ; Parâmetro de limite

        MUL DI             ; Xn*A
        ADD AX, BX         ; Xn*A+C
        DIV CX             ; AX/CX
        MOV DI, DX         ; Pos aleatória em DI

        POP DX
        POP CX
        POP BX
        POP AX

        RET                 ; Retorna com coordenadas válidas
    GerarPosicaoAleatoria ENDP
END CODE