onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Synchronizer_tb/sim_async_in
add wave -noupdate /Synchronizer_tb/sim_clk
add wave -noupdate /Synchronizer_tb/sim_reset
add wave -noupdate /Synchronizer_tb/sim_sync_out
add wave -noupdate /Synchronizer_tb/error
add wave -noupdate /Synchronizer_tb/DUT/async_in
add wave -noupdate /Synchronizer_tb/DUT/clk_in
add wave -noupdate /Synchronizer_tb/DUT/reset
add wave -noupdate /Synchronizer_tb/DUT/sync_out
add wave -noupdate /Synchronizer_tb/DUT/sync_level_1
add wave -noupdate /Synchronizer_tb/DUT/sync_level_2
add wave -noupdate /Synchronizer_tb/DUT/sync_level_3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {128 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
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
WaveRestoreZoom {2 ns} {128 ns}
