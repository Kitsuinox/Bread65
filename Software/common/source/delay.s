.include	"zeropage.inc"

.export	_delay_ms
.export	_delay_ms_sr

.code
_delay_ms:
	LDX	REG0
	BEQ	@done
@xloop:	LDY	#203
@yloop:	DEY
	BNE	@yloop
	DEX
	BNE	@xloop
@done:	RTS

_delay_ms_sr:
	PHA	
	TXA
	PHA
	TYA
	PHA
	LDX	REG0
	BEQ	@done
@xloop:	LDY	#203
@yloop:	DEY
	BNE	@yloop
	DEX
	BNE	@xloop
@done:	PLA
	TAY
	PLA
	TAX
	PLA
	RTS
