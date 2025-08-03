onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Keyboard_Interface_tb/sim_clk
add wave -noupdate /Keyboard_Interface_tb/sim_reset
add wave -noupdate /Keyboard_Interface_tb/sim_kbd_data_ready
add wave -noupdate /Keyboard_Interface_tb/sim_kbd_received_ascii_code
add wave -noupdate /Keyboard_Interface_tb/sim_restart_start_protocol
add wave -noupdate /Keyboard_Interface_tb/sim_play_enable
add wave -noupdate /Keyboard_Interface_tb/sim_direction
add wave -noupdate /Keyboard_Interface_tb/sim_restart
add wave -noupdate /Keyboard_Interface_tb/error
add wave -noupdate /Keyboard_Interface_tb/DUT/kbd_data_ready
add wave -noupdate /Keyboard_Interface_tb/DUT/kbd_received_ascii_code
add wave -noupdate /Keyboard_Interface_tb/DUT/clk_in
add wave -noupdate /Keyboard_Interface_tb/DUT/reset
add wave -noupdate /Keyboard_Interface_tb/DUT/restart_start_protocol
add wave -noupdate /Keyboard_Interface_tb/DUT/play_enable
add wave -noupdate /Keyboard_Interface_tb/DUT/direction
add wave -noupdate /Keyboard_Interface_tb/DUT/restart
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 325
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {230 ns}
