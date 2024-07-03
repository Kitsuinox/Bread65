.include	"lcd.inc"
.include	"delay.inc"

.code
main:	LDA	#20
	STA	REG0
	JSR	_delay_ms

	LDA	#(LCD_CMD_FNSET | LCD_FNSET_8BIT)
	JSR	_lcd_tx_command
	JSR	_lcd_tx_command
	JSR	_lcd_tx_command

	LDA	#(LCD_CMD_FNSET | LCD_FNSET_4BIT | LCD_FNSET_5X8 | LCD_FNSET_2LIN)
	JSR	_lcd_tx_command

	LDA	#(LCD_CMD_ENTRY | LCD_ENTRY_INCR)
	JSR	_lcd_tx_command

	LDA	#(LCD_CMD_DISP | LCD_DISP_ENABLE | LCD_DISP_CURSOR | LCD_DISP_CBLINK)
	JSR	_lcd_tx_command

	LDA	#(LCD_CMD_RETURN)
	JSR	_lcd_tx_command
	JSR	_delay_ms
	
	LDA	#(LCD_CMD_CLEAR)
	JSR	_lcd_tx_command
	JSR	_delay_ms

	LDA	#<pgsig
	STA	PTR0
	LDA	#>pgsig
	STA	PTR0+1
	JSR	_lcd_tx_string

@halt:	JMP	@halt

.rodata
pgsig:	.byte "lcd4bit - 03/07/2024", 0

.segment "VECTS"
.word	main
.word	main
.word	main
