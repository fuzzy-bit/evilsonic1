OUTPUT_ARCH(m68k)
__DYNAMIC  =  0;

MEMORY
{
    rom (rx) : ORIGIN = 0x00000000, LENGTH = 0x00400000
    ram (wx) : ORIGIN = 0x00FF0000, LENGTH = 0x00010000
}

SECTIONS
{
  .text :
  {
    ld_text_start = .;
	*(.text .text.*)
    . = ALIGN (0x4);
    *(.rodata .rodata.*)
    . = ALIGN (0x2);
    ld_text_end = .;
  } > rom
  ld_text_size = SIZEOF(.text);
}
