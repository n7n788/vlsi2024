###############################################################
#  Generated by:      Cadence Innovus 21.18-s099_1
#  OS:                Linux x86_64(Host ID katsuo)
#  Generated on:      Thu Aug  1 06:59:46 2024
#  Design:            mips32
#  Command:           saveDesign final.enc
###############################################################
current_design mips32
create_clock [get_ports {clk}]  -name clk -period 10.000000 -waveform {0.000000 5.000000}
set_propagated_clock  [get_ports {clk}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[3]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[29]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[1]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[27]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[25]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[18]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[30]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[23]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[16]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[21]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[14]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[12]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[10]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[8]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[6]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[4]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[2]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[28]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[0]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[26]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[19]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[31]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[24]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[17]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[22]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[15]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[20]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[13]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[11]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[9]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[7]}]
set_input_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memdata[5]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[4]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[31]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[24]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[17]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[6]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[21]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[14]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[9]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[29]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[0]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[20]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[13]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[26]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[19]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[2]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[10]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[5]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[25]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[18]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[7]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[22]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[15]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[1]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[21]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[14]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[27]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[3]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[11]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[6]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[26]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[19]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[8]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[10]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[30]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[23]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[16]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[22]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[15]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[28]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[2]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[4]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[12]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[7]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[27]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memread}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[9]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[11]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[31]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[24]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[17]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[0]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[3]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[30]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[23]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[16]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[29]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[5]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[20]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[13]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[8]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[28]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {adr[12]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[25]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[18]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {writedata[1]}]
set_output_delay -add_delay 0.1 -clock [get_clocks {clk}] [get_ports {memwrite}]
set_clock_uncertainty 0.02 [get_clocks {clk}]
