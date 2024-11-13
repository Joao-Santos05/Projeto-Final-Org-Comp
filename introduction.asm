TITLE PROJECT INTRODUCTION
.MODEL SMALL
.STACK 100H



NEW_LINE MACRO PARAM ; Criação de MACRO para quebra/inicialização de nova linha.
  LOCAL REPEAT

  PUSH AX ; Salva o valor de AX na pilha.
  PUSH DX ; Salva o valor de DX na pilha.

  MOV CX,PARAM ; Movimentação/cópia do valor de PARAM (parâmetro) para CX.

  REPEAT:
    MOV AH,2 ; Função responsável por imprimir um caractere na tela do usuário.
    MOV DL,10 ; Movimentação/cópia do valor 10 para DL (quebra de linha).
    INT 21H ; Conjunto de funções de entrada/saída.

    MOV DL,13 ; Movimentação/cópia do valor 13 para DL (retorno de carro).
    INT 21H ; Conjunto de funções de entrada/saída.

  LOOP REPEAT ; Loop de repetição.

  POP DX ; Restaura o valor de DX da pilha.
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



.DATA ; Seção de dados que serão utilizados no programa.
  ; Introdução:
  INTRO_TITLE DB 'BATTLESHIP | OSC 2S24', '$' ; Criação/definição da variável "INTRO_TITLE" que contém o título da introdução.	

  ; Regras/Instruções:
  RULES_TITLE DB 'RULES/INSTRUCTIONS:', '$' ; Criação/definição da variável "RULES_TITLE" que contém o título das regras/instruções.
  FIRST_RULE DB '> The game has to be played by 2 players.', '$' ; Criação/definição da variável "FIRST_RULE" que contém a primeira regra.
  SECOND_RULE DB '> Each player has to set a position to their ships, which are:', '$' ; Criação/definição da variável "SECOND_RULE" que contém a segunda regra.
  THIRD_RULE DB '   * Battleship - 4 position length/size', '$' ; Criação/definição da variável "THIRD_RULE" que contém a terceira regra.
  FOURTH_RULE DB '   * Frigate - 3 position length/size', '$' ; Criação/definição da variável "FOURTH_RULE" que contém a quarta regra.
  FIFTH_RULE DB '   * Submarine - 2 position lenght/size', '$' ; Criação/definição da variável "FIFTH_RULE" que contém a quinta regra.
  SIXTH_RULE DB '   * Hydroplane - 4 position lenght/size ("T" format/shape)', '$' ; Criação/definição da variável "SIXTH_RULE" que contém a sexta regra.
  SEVENTH_RULE DB '> Vessels/ships cannot be docked:', '$'  ; Criação/definição da variável "SEVENTH_RULE" que contém a sétima regra.
  EIGHTH_RULE DB '   * There must be a minimum distance of 1 square on every direction.', '$'  ; Criação/definição da variável "EIGHTH_RULE" que contém a oitava regra.
  NINTH_RULE DB '> Both players have 35 attempts to sink the ships.', '$'  ; Criação/definição da variável "NINTH_RULE" que contém a nona regra.
  TENTH_RULE DB '> The game ends when the winner hits all enemy ships.', '$'  ; Criação/definição da variável "TENTH_RULE" que contém a décima regra.

  CONFIRM_MESSAGE DB 'PRESS ANY BUTTON TO CONTINUE', '$' ; Criação/definição da variável "CONFIRM_MESSAGE" que contém a confirmação de leitura.



.CODE
MAIN PROC
  MOV AX,@DATA ; Endereço base do segmento de dados.
  MOV DS,AX ; Movimentação/cópia de "AX" para "DS" (registrador).

  ;#####################################################################################################################
  ; INICIALIZAÇÃO DO MODO DE VÍDEO DO MONITOR DE SAÍDA ("TELA LIMPA")
  ;#####################################################################################################################
  CALL CLEAR_SCREEN

  ;#####################################################################################################################
  ; INICIALIZAÇÃO DA TELA DE INTRODUÇÃO (BEM-VINDO & REGRAS/INSTRUÇÕES)
  ;#####################################################################################################################
  CALL INTRODUCTION_SCREEN ; Chamada da função "INTRODUCTION_SCREEN".

  READ_CONFIRMATION ; Chamada da MACRO "READ_CONFIRMATION" para prosseguir com a execução.

  ;#####################################################################################################################
  ;ENCERRAMENTO DA EXECUÇÃO DO PROGRAMA
  ;#####################################################################################################################
  MOV AH,4CH ; Função responsável por finalizar o programa.
  INT 21H ; Conjunto de funções de entrada/saída.
MAIN ENDP



INTRODUCTION_SCREEN PROC ; Criação/definição do procedimento "INTRODUCTION_SCREEN" para exibição da tela de introdução.
  MOV AH,9 ; Função responsável por imprimir uma string na tela.

  NEW_LINE 2 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 25 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,INTRO_TITLE ; Carregamento do endereço da variável "INTRO_TITLE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 3 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,RULES_TITLE ; Carregamento do endereço da variável "RULES_TITLE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 2 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,FIRST_RULE ; Carregamento do endereço da variável "FIRST_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,SECOND_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,THIRD_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,FOURTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,FIFTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,SIXTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,SEVENTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,EIGHTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,NINTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 1 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 2 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  LEA DX,TENTH_RULE ; Carregamento do endereço da variável "SECOND_RULE" em SI.
  INT 21H ; Conjunto de funções de entrada/saída.

  NEW_LINE 4 ; Chamada da MACRO "NEW_LINE" para quebra/inicialização de nova linha.
  LEFT_TAB 23 ; Chamada da MACRO "LEFT_TAB" para tabulação das strings definidas no segmento de dados.

  RET ; Retorno do procedimento.
INTRODUCTION_SCREEN ENDP ; Fim do procedimento "INTRODUCTION_SCREEN".



CLEAR_SCREEN PROC ; Criação/definição do procedimento "CLEAR_SCREEN" para limpeza da tela.
  MOV AX,03H ; Movimentação/cópia do valor 3 para AX (limpeza da tela).
  INT 10H ; Conjunto de funções de vídeo.

  RET ; Retorno do procedimento.
CLEAR_SCREEN ENDP ; Fim do procedimento "CLEAR_SCREEN".



END MAIN