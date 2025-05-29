.include "./tn85def.inc"

ldi r16,0b00000010
out DDRB,r16
out PortB,r16
Start:
  rjmp Start