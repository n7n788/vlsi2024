set_clock_latency -source -early -max -rise  -0.0646969 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.0657319 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -0.0646969 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.0657319 [get_ports {clk}] -clock clk 
