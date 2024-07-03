.code
main: JMP	main
.rodata
	.byte	"Test", 0
.segment "VECTS"
	.word main
	.word main
	.word main
