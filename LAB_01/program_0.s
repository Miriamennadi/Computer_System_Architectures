
.data

v1:  	.byte    	2, 6, -3, 11, 9, 18, -13, 16, 5, 1
v2:  	.byte    	4, 2, -14, 3, 9, 9, 7, 16, 4, 7
v3: 	.space      10                                      ;lascio lo spazio in memoria , metto .space	
flag01: .byte 1                                             ;v3 vuoto
flag02: .byte 1                                             ;crescente
flag03: .byte 1                                             ;decrescente


.text

 ; settare nuovamente i registri a 0 per sicurezza
daddi R31, R0, 10       ; mi salvo la dimensione della lunghezza dei vettori
lbu R28, flag01(R0)      ; R28 contiene FLAG 1, load byte unsigned, parto con il flag settato a 0
lbu R29, flag02(R0)      ; R29 contiene FLAG 2, load byte unsigned, parto con il flag settato a 0
lbu R30, flag03(R0)      ; R30 contiene FLAG 3, load byte unsinged, parto con il flag settato a 0


Loop_Uno:
lb R4, v1(R1)       ; carico il primo elemento del vettore V1 nel registro R4
daddi R2, R0, 0     ; resetto


Loop_Due:
lb R5, v2(R2)       ; carico il primo elemento del vettore v2 nel registor R5
beq R4, R5, Uguali  ; se i due elementi confrontati sono uguali termino gia il loop
daddi R2, R2, 1     ; incremento l'indice che scorre il secondo vettore
beq  R2, R31, Fine  ; devo verificare di aver terminato il controllo del vettore R2
j Loop_Due          ; continuo il Loop


Uguali:
sb R4, v3(R3)       ; carico il valore uguale nel vettore R3
daddi R3, R3, 1     ; incremento il contatore di uno 
daddi R28, R0, 0    ; setto il FLAG 1 A 0 ,puoi fare la somma solo tra registri e un valore immediato, non valore immediato e registro
beqz  R1, Fine      ; branch if R1 = R0
daddi R2, R3, -1    ; prendo l'emento precedente del vettore v3
ld R2, v3(R2)       ; prendo il valore precedente nel vettore v3
slt R2, R4, R2      ; se R4 E MINORE DI R2, R2 DIVENTA uno senno va a 0, da 0 se sono anche uguali
beqz R2, Fase       ; se R4 non e piu piccolo di R2
daddi R29, R0, 0    ; Setto il flag decrescente Flag02 a 0
j Fine


Fase:
slt R2, R2, R4      ; rifaccio il confronto al contrario per assodare sia minore stretto
beqz R2, Fine       ; tengo il flag02 al valore di prima
daddi R30, R0, 0    ; e poi metto il flag03 a 0, 


Fine:
daddi R1, R1, 1     ; incremento il contatore di R1 per il primo vettore v1
bne   R1, R31, Loop_Uno
sb    R28, flag01(R0)   ;salvo il cambiamento di FLAG01
sb    R29, flag02(R0)   ;salvo il cambiamento di FLAG02
sb    R30, flag03(R0)   ;salvo il cambiamento di FLAG03
;BRANCH LINE PER STACCARE LE COSE, PER INDENTAZIONE

Halt











