.include	"via.inc"

.code
main:	LDA	#$FF
	STA	VIA0_DDRB
	LDA	#$00
	STA	VIA0_DDRA
@loop:	LDA	VIA0_IORA
	STA	VIA0_IORB
	JMP	@loop

.rodata
pgname:	.byte	"hello.s - 2024-06-30", 0

.segment "VECTS"
.word	main
.word	main
.word	main
