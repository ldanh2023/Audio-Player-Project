onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Frequency_Controller_tb/sim_clk
add wave -noupdate /Frequency_Controller_tb/sim_reset
add wave -noupdate /Frequency_Controller_tb/sim_speed_up_event
add wave -noupdate /Frequency_Controller_tb/sim_speed_down_event
add wave -noupdate /Frequency_Controller_tb/sim_speed_reset_event
add wave -noupdate /Frequency_Controller_tb/sim_freq_count
add wave -noupdate /Frequency_Controller_tb/prev_freq_count
add wave -noupdate /Frequency_Controller_tb/error
add wave -noupdate /Frequency_Controller_tb/DUT/clk_in
add wave -noupdate /Frequency_Controller_tb/DUT/reset
add wave -noupdate /Frequency_Controller_tb/DUT/speed_up_event
add wave -noupdate /Frequency_Controller_tb/DUT/speed_down_event
add wave -noupdate /Frequency_Controller_tb/DUT/speed_reset_event
add wave -noupdate /Frequency_Controller_tb/DUT/freq_count
add wave -noupdate /Frequency_Controller_tb/DUT/custom_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 298
configure wave -valuecolwidth 200
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
WaveRestoreZoom {1 ns} {105 ns}
