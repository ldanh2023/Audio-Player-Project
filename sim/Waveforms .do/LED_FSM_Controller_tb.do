onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /LED_FSM_Controller_tb/sim_clk
add wave -noupdate /LED_FSM_Controller_tb/sim_reset
add wave -noupdate /LED_FSM_Controller_tb/sim_out
add wave -noupdate /LED_FSM_Controller_tb/error
add wave -noupdate /LED_FSM_Controller_tb/DUT/clk
add wave -noupdate /LED_FSM_Controller_tb/DUT/reset
add wave -noupdate /LED_FSM_Controller_tb/DUT/out
add wave -noupdate /LED_FSM_Controller_tb/DUT/current_state
add wave -noupdate /LED_FSM_Controller_tb/DUT/direction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24480 ms} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
configure wave -valuecolwidth 76
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ms} {26208 ms}
