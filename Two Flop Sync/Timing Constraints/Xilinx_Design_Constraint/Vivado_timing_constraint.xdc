create_clock -add -name sys_clk_pin -period 10.00 -waveform {0.000 5.000} [get_ports {wclk}];
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { wclk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0.000 5.000} [get_ports {rclk}];
set_property -dict { PACKAGE_PIN E2 IOSTANDARD LVCMOS33 } [get_ports { rclk }];



