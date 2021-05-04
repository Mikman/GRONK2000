transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/joach/OneDrive/Dokumenter/Github/GRONK2000/FPGA-LEDRAM/FPGA_LEDRAM.vhd}

