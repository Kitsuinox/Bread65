.include	"i2c.inc"
.include	"zeropage.inc"

.export	_24lc_read

.code

; reads byte at address PTR0 into ACC.
; C = 1 if an error occurs.

_24lc_read:
	JSR	_i2c_start
	
	LDA	#$a0
	JSR	_i2c_send
	JSR	_i2c_ack
	BCS	@err

	LDA	PTR0+1
	AND	#$0F
	JSR	_i2c_send
	JSR	_i2c_ack
	BCS	@err

	LDA	PTR0
	JSR	_i2c_send
	JSR	_i2c_ack
	BCS	@err

	JSR	_i2c_start

	LDA	#$a1
	JSR	_i2c_send
	JSR	_i2c_ack
	BCS	@err

	JSR	_i2c_recv
	JSR	_i2c_ack
	BCC	@err
	CLC
	JMP	@done
@err:	SEC
@done:	JSR	_i2c_stop
	RTS

