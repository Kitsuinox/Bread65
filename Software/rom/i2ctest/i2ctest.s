.include	"24lc.inc"
.include	"delay.inc"
.include	"lcd.inc"

.code
main:	LDA	#50
	STA	REG0

	LDA	#(LCD_CMD_FNSET | LCD_FNSET_8BIT)
	JSR	_lcd_tx_command
	JSR	_lcd_tx_command
	
	LDA	#(LCD_CMD_FNSET | LCD_FNSET_4BIT | LCD_FNSET_5X8 | LCD_FNSET_2LIN)
	JSR	_lcd_tx_command

	LDA	#(LCD_CMD_ENTRY | LCD_ENTRY_INCR)
	JSR	_lcd_tx_command

	LDA	#(LCD_CMD_DISP | $07)
	JSR	_lcd_tx_command

	LDA	#LCD_CMD_CLEAR
	JSR	_lcd_tx_command
	JSR	_delay_ms

	LDA	#LCD_CMD_RETURN
	JSR	_lcd_tx_command
	JSR	_delay_ms

	LDA	#00
	STA	PTR0
	STA	PTR0+1

@loop:	JSR	_24lc_read
	BCS	@err
	
	CMP	#0
	BEQ	@halt
	JSR	_lcd_tx_data
	INC	PTR0
	JMP	@loop
@err:	LDA	#'?'
	JSR	_lcd_tx_data
@halt:	JMP	@halt

.rodata
.byte	"I2C - 24/07/04", 0

.segment "VECTS"
.word	main
.word	main
.word	main
