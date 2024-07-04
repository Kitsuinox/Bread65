.include	"lcdconst.inc"
.include	"via.inc"
.include	"zeropage.inc"

.export	_lcd_tx_command
.export	_lcd_tx_data
.export _lcd_tx_string

LCD_DDR		= VIA0_DDRA
LCD_IOR		= VIA0_IORA
LCD_DATA_MASK	= $0F
LCD_RS		= $10
LCD_RW		= $20
LCD_E		= $40
LCD_WMASK	= LCD_DATA_MASK | LCD_RS | LCD_RW | LCD_E
LCD_RMASK	= LCD_RS | LCD_RW | LCD_E

.code
_lcd_tx_command:
	PHA	; save A for RTS. (0->1)
	PHA	; save A for lower nybble. (1->2)
	
	PHA	; save A again. (2->3)
	LDA	#LCD_WMASK	; put write mask
	STA	LCD_DDR		; on LCD's DDR.
	PLA	; load A (3->2)

	LSR
	LSR
	LSR
	LSR	; shift right 4 times, get upper nybble.
	
	ORA	#LCD_E	; make E high, RS and RW low.
	STA	LCD_IOR	; put data on port.
	
	EOR	#LCD_E	; falling edge on E...
	STA	LCD_IOR	; writes data into the LCD.

	PLA	; now load A, once again. (2->1)
	AND	#LCD_DATA_MASK	; only lower nyble now.
	ORA	#LCD_E	; make E high, RS and RW low.
	STA	LCD_IOR	; put data on the port
	
	EOR	#LCD_E	; falling edge on E...
	STA	LCD_IOR	; writes data into the LCD.

	PLA	; get A back. (1->0, stack is back to normal)
	RTS	; return from subroutine.

_lcd_tx_data:
	PHA	; save A for RTS. (0->1)
	PHA	; save A for lower nybble. (1->2)
	
	PHA	; save A again. (2->3)
	LDA	#LCD_WMASK	; put write mask
	STA	LCD_DDR		; on LCD's DDR.
	PLA	; load A (3->2)

	LSR
	LSR
	LSR
	LSR	; shift right 4 times, get upper nybble.
	
	ORA	#(LCD_E | LCD_RS)	; make E & RS high, RW low.
	STA	LCD_IOR	; put data on port.
	
	EOR	#LCD_E	; falling edge on E...
	STA	LCD_IOR	; writes data into the LCD.

	PLA	; now load A, once again. (2->1)
	AND	#LCD_DATA_MASK	; only lower nyble now.
	ORA	#(LCD_E | LCD_RS)	; make E & RS high, RW low.
	STA	LCD_IOR	; put data on the port
	
	EOR	#LCD_E	; falling edge on E...
	STA	LCD_IOR	; writes data into the LCD.

	PLA	; get A back. (1->0, stack is back to normal)
	RTS	; return from subroutine.

_lcd_tx_string:
	PHA	; push A (0->1)
	TYA	; write Y into A
	PHA	; push A (1->2)
	LDY	#0 		; write 0 to Y for indexing
@loop:	LDA	(PTR0), Y	; load M[M[PTR0]+Y] into A (char).
	BEQ	@done		; if 0, done
	INY			; increment Y.
	BMI	@done		; if carry occurs, done.
	JSR	_lcd_tx_data	; print character in A.
	JMP	@loop
@done:	PLA	; pop A (2->1)
	TAY	; write A into Y back.
	PLA	; pop A (1->0).
	RTS	; return from subroutine.
