.include	"via.inc"
.include	"delay.inc"	

.code
main:	LDA	#$FF
	STA	VIA0_DDRB
	STA	REG0
	LDA	#$00
	STA	VIA0_DDRA
@loop:	LDA	VIA0_IORA
	JSR	_delay_ms
	JSR	_delay_ms
	STA	VIA0_IORB
	JMP	@loop

.rodata
pgname:	.byte	"hello.s - 2024-07-03", 0

.segment "VECTS"
.word	main
.word	main
.word	main
