onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Flash_FSM_Controller_tb/sim_clk
add wave -noupdate /Flash_FSM_Controller_tb/sim_reset
add wave -noupdate /Flash_FSM_Controller_tb/sim_clk_async
add wave -noupdate /Flash_FSM_Controller_tb/sim_play_enable
add wave -noupdate /Flash_FSM_Controller_tb/sim_direction
add wave -noupdate /Flash_FSM_Controller_tb/sim_restart
add wave -noupdate /Flash_FSM_Controller_tb/sim_restart_start_protocol
add wave -noupdate /Flash_FSM_Controller_tb/sim_flash_mem_waitrequest
add wave -noupdate /Flash_FSM_Controller_tb/sim_flash_mem_readdatavalid
add wave -noupdate /Flash_FSM_Controller_tb/sim_flash_mem_readdata
add wave -noupdate /Flash_FSM_Controller_tb/sim_flash_mem_read
add wave -noupdate /Flash_FSM_Controller_tb/sim_flash_mem_address
add wave -noupdate /Flash_FSM_Controller_tb/sim_audio_out
add wave -noupdate /Flash_FSM_Controller_tb/sim_out_clk
add wave -noupdate /Flash_FSM_Controller_tb/error
add wave -noupdate /Flash_FSM_Controller_tb/DUT/clk_in
add wave -noupdate /Flash_FSM_Controller_tb/DUT/reset
add wave -noupdate /Flash_FSM_Controller_tb/DUT/clk_async
add wave -noupdate /Flash_FSM_Controller_tb/DUT/play_enable
add wave -noupdate /Flash_FSM_Controller_tb/DUT/direction
add wave -noupdate /Flash_FSM_Controller_tb/DUT/restart
add wave -noupdate /Flash_FSM_Controller_tb/DUT/restart_start_protocol
add wave -noupdate /Flash_FSM_Controller_tb/DUT/flash_mem_waitrequest
add wave -noupdate /Flash_FSM_Controller_tb/DUT/flash_mem_readdatavalid
add wave -noupdate /Flash_FSM_Controller_tb/DUT/flash_mem_readdata
add wave -noupdate /Flash_FSM_Controller_tb/DUT/flash_mem_read
add wave -noupdate /Flash_FSM_Controller_tb/DUT/flash_mem_address
add wave -noupdate /Flash_FSM_Controller_tb/DUT/audio_out
add wave -noupdate /Flash_FSM_Controller_tb/DUT/state
add wave -noupdate /Flash_FSM_Controller_tb/DUT/data_out
add wave -noupdate /Flash_FSM_Controller_tb/DUT/current_address
add wave -noupdate /Flash_FSM_Controller_tb/DUT/current_direction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {485 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 320
configure wave -valuecolwidth 68
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
WaveRestoreZoom {0 ns} {490 ns}
