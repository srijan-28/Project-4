
.ORIG x3000

; Project 4
; Sum of squares using runtime stack
; AI used for code help and debugging

MAIN
    LD R6, STACK
    LEA R0, ARRAY
    LD R1, SIZE

    ; Push arguments
    ADD R6, R6, #-1
    STR R1, R6, #0
    ADD R6, R6, #-1
    STR R0, R6, #0

    JSR SUMOFSQUARES

    ; Remove arguments
    ADD R6, R6, #2

    ; Save final answer
    ADD R6, R6, #-1
    STR R0, R6, #0
    HALT

SUMOFSQUARES
    ; Save registers
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    ADD R5, R6, #0
    ADD R6, R6, #-2

    ; counter = 0, sum = 0
    AND R0, R0, #0
    STR R0, R5, #-1
    STR R0, R5, #-2

LOOP
    ; Check counter
    LDR R0, R5, #-1
    LDR R1, R5, #3
    NOT R1, R1
    ADD R1, R1, #1
    ADD R1, R0, R1
    BRzp DONE

    ; Get array value
    LDR R1, R5, #2
    ADD R1, R1, R0
    LDR R0, R1, #0

    ; Call square
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR SQUARE
    ADD R6, R6, #1

    ; Add to sum
    LDR R1, R5, #-2
    ADD R1, R1, R0
    STR R1, R5, #-2

    ; counter++
    LDR R0, R5, #-1
    ADD R0, R0, #1
    STR R0, R5, #-1
    BRnzp LOOP

DONE
    ; Return sum
    LDR R0, R5, #-2
    ADD R6, R5, #0
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
    RET

SQUARE
    ; Save registers
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    ADD R5, R6, #0

    ; Square using addition
    AND R0, R0, #0
    LDR R1, R5, #2
    ADD R2, R1, #0

AGAIN
    ADD R2, R2, #0
    BRnz FINISH
    ADD R0, R0, R1
    ADD R2, R2, #-1
    BRnzp AGAIN

FINISH
    ; Restore registers
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    ADD R6, R6, #1
    RET

; Array
ARRAY .FILL #2
      .FILL #3
      .FILL #5
      .FILL #0
      .FILL #1

SIZE  .FILL #5
STACK .FILL xF000

.END
