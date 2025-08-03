onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Arbitrary_Clock_Divider_My_Version_tb/sim_in_clk
add wave -noupdate /Arbitrary_Clock_Divider_My_Version_tb/sim_out_clk
add wave -noupdate /Arbitrary_Clock_Divider_My_Version_tb/sim_freq_counter
add wave -noupdate /Arbitrary_Clock_Divider_My_Version_tb/sim_on_off
add wave -noupdate /Arbitrary_Clock_Divider_My_Version_tb/error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {712 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 57
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {976 ns}
