`timescale 1ns/1ns

//Define States
`define IDLE 3'b000
`define ADDRESS 3'b001
`define WAIT_VALID 3'b010
`define OUTPUT1 3'b011
`define OUTPUT2 3'b100
`define OUTPUT3 3'b101
`define OUTPUT4 3'b110

//Stop and start music
`define STOP_MUSIC 1'b0
`define PLAY_MUSIC 1'b1

//Playback mode
`define FORWARD 1'b0
`define BACKWARD 1'b1

//Max address
`define MAX_ADDRESS 23'h7FFFF


module Flash_FSM_Controller_tb;
    //Inputs to DUT
    logic sim_clk;
    logic sim_reset;
    logic sim_clk_async;
    logic sim_play_enable;
    logic sim_direction;
    logic sim_restart;
    logic sim_restart_start_protocol;
    logic sim_flash_mem_waitrequest;
    logic sim_flash_mem_readdatavalid;
    logic [31:0] sim_flash_mem_readdata;
    logic sim_flash_mem_read;
    logic [22:0] sim_flash_mem_address;
    logic [7:0] sim_audio_out;
    logic sim_out_clk;

    //Error signal
    logic error;
    

    //Instantiate the DUT
    Flash_FSM_Controller DUT(
        .clk_in(sim_clk), //50MHz system clock
        .reset(sim_reset), //Active high reset

        //Async signal (synchronized in top module)
        .clk_async(sim_clk_async),

        //Control inputs
        .play_enable(sim_play_enable), //Play or stop
        .direction(sim_direction), //Forward or backward playback
        .restart(sim_restart), //Restart playback
        .restart_start_protocol(sim_restart_start_protocol), //Uses the Start-Finish protocol taught in class

        //Flash memory interface
        .flash_mem_waitrequest(sim_flash_mem_waitrequest),
        .flash_mem_readdatavalid(sim_flash_mem_readdatavalid),
        .flash_mem_readdata(sim_flash_mem_readdata),
        .flash_mem_read(sim_flash_mem_read),
        .flash_mem_address(sim_flash_mem_address),

        //Audio output
        .audio_out(sim_audio_out)
    );


    //Simulate the clk signal for sim_clk, 50MHz
    initial sim_clk = 0;
    always #10 sim_clk = ~sim_clk; //50MHz clock, period is 20ns, half period is 10ns


    //Simulate the clk signal for sim_clk, 25MHz (just for testing purposes)
    initial sim_out_clk = 0;
    always #20 sim_out_clk = ~sim_out_clk; //25MHz clock, period is 40ns, half period is 20ns


    Synchronizer synch(.async_in(sim_out_clk), .clk_in(sim_clk), .reset(1'b0), .sync_out(sim_clk_async));



    initial begin
        //Initialize inputs
        sim_reset = 1'b0;
        sim_play_enable = `STOP_MUSIC; //Initially not playing
        sim_direction = `FORWARD; //Initially forward playback
        sim_restart = 1'b0; //Initially not restarting
        sim_flash_mem_waitrequest = 1'b0; //Initially not waiting for flash memory
        sim_flash_mem_readdatavalid = 1'b0; //Initially not valid data from flash memory
        sim_flash_mem_readdata = 32'h0; //Initially no data from flash memory

        error = 1'b0;
        #10;


        //=================================== Case 1: Reset the FSM ===================================
        sim_reset = 1'b1; //Assert reset
        #10;


        //Check state
        assert(DUT.state === `IDLE)
            $display("Test 1 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `IDLE);
        else begin
            $display("FAIL: Test 1, DUT.state is %b, expected %b", DUT.state, `IDLE);
            error = 1'b1;
        end

        //Check data_out
        assert(DUT.data_out === 32'h0)
            $display("Test 2 SUCCESS ** DUT.data_out is %b, expected %b", DUT.data_out, 32'h0);
        else begin
            $display("FAIL: Test 2, DUT.data_out is %b, expected %b", DUT.data_out, 32'h0);
            error = 1'b1;
        end

        //Check current_address
        assert(DUT.current_address === 23'h0)
            $display("Test 3 SUCCESS ** DUT.current_address is %b, expected %b", DUT.current_address, 23'h0);
        else begin
            $display("FAIL: Test 3, DUT.current_address is %b, expected %b", DUT.current_address, 23'h0);
            error = 1'b1;
        end

        //Check flash_mem_read
        assert(sim_flash_mem_read === 1'b0)
            $display("Test 4 SUCCESS ** sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b0);
        else begin
            $display("FAIL: Test 4, sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b0);
            error = 1'b1;
        end

        //Check flash_mem_address
        assert(sim_flash_mem_address === 23'h0)
            $display("Test 5 SUCCESS ** sim_flash_mem_address is %b, expected %b", sim_flash_mem_address, 23'h0);
        else begin
            $display("FAIL: Test 5, sim_flash_mem_address is %b, expected %b", sim_flash_mem_address, 23'h0);
            error = 1'b1;
        end

        //Check audio_out
        assert(sim_audio_out === 8'h00)
            $display("Test 6 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h00);
        else begin
            $display("FAIL: Test 6, sim_audio_out is %b, expected %b", sim_audio_out, 8'h00);
            error = 1'b1;
        end

        //Check restart_start_protocol
        assert(sim_restart_start_protocol === 1'b0)
            $display("Test 7 SUCCESS ** sim_restart_start_protocol is %b, expected %b", sim_restart_start_protocol, 1'b0);
        else begin
            $display("FAIL: Test 7, sim_restart_start_protocol is %b, expected %b", sim_restart_start_protocol, 1'b0);
            error = 1'b1;
        end

        #5;
        sim_reset = 1'b0;
        #5;


        //=================================== Case 2: IDLE state with RESTART ===================================
        sim_restart = 1'b1;
        #10;

        //Check state
        assert(DUT.state === `IDLE)
            $display("Test 8 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `IDLE);
        else begin
            $display("FAIL: Test 8, DUT.state is %b, expected %b", DUT.state, `IDLE);
            error = 1'b1;
        end


        //Check current_address
        assert(DUT.current_address === 23'h0)
            $display("Test 9 SUCCESS ** DUT.current_address is %b, expected %b", DUT.current_address, 23'h0);
        else begin
            $display("FAIL: Test 9, DUT.current_address is %b, expected %b", DUT.current_address, 23'h0);
            error = 1'b1;
        end


        //Check restart_start_protocol
        assert(sim_restart_start_protocol === 1'b1)
            $display("Test 10 SUCCESS ** sim_restart_start_protocol is %b, expected %b", sim_restart_start_protocol, 1'b1);
        else begin
            $display("FAIL: Test 10, sim_restart_start_protocol is %b, expected %b", sim_restart_start_protocol, 1'b1);
            error = 1'b1;
        end

        sim_restart = 1'b0;


        //=================================== Case 3: Transition to ADDRESS state ===================================
        #20;
        sim_play_enable = `PLAY_MUSIC; //Set play_enable to PLAY_MUSIC
        #35; //need to wait for the next clock edge after sim_clk_async is set to 1'b1 (need to register the change)

        //Check state
        assert(DUT.state === `ADDRESS)
            $display("Test 11 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `ADDRESS);
        else begin
            $display("FAIL: Test 11, DUT.state is %b, expected %b", DUT.state, `ADDRESS);
            error = 1'b1;
        end


        //Check flash_mem_read
        assert(sim_flash_mem_read === 1'b1)
            $display("Test 12 SUCCESS ** sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b1);
        else begin
            $display("FAIL: Test 12, sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b1);
            error = 1'b1;
        end


        //Check flash_mem_address
        assert(sim_flash_mem_address === 23'h0)
            $display("Test 13 SUCCESS ** sim_flash_mem_address is %b, expected %b", sim_flash_mem_address, 23'h0);
        else begin
            $display("FAIL: Test 13, sim_flash_mem_address is %b, expected %b", sim_flash_mem_address, 23'h0);
            error = 1'b1;
        end

        #10;

        //=================================== Case 4: Transition to WAIT_VALID state ===================================
        sim_flash_mem_waitrequest = 1'b0; //Deassert waitrequest to simulate flash memory ready

        #10;
        //Check state
        assert(DUT.state === `WAIT_VALID)
            $display("Test 14 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `WAIT_VALID);
        else begin
            $display("FAIL: Test 14, DUT.state is %b, expected %b", DUT.state, `WAIT_VALID);
            error = 1'b1;
        end

        //Check flash_mem_read
        assert(sim_flash_mem_read === 1'b0)
            $display("Test 15 SUCCESS ** sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b0);
        else begin
            $display("FAIL: Test 15, sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b0);
            error = 1'b1;
        end


        //=================================== Case 5: Transition to OUTPUT1 state ===================================
        #10;
        sim_flash_mem_readdatavalid = 1'b1; //Simulate valid data from flash memory
        sim_flash_mem_readdata = 32'h12345678; //Simulate some data from flash memory

        #10;

        //Check state
        assert(DUT.state === `OUTPUT1)
            $display("Test 16 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT1);
        else begin
            $display("FAIL: Test 16, DUT.state is %b, expected %b", DUT.state, `OUTPUT1);
            error = 1'b1;
        end

        //Check output_data
        assert(DUT.data_out === 32'h12345678)
            $display("Test 17 SUCCESS ** DUT.data_out is %b, expected %b", DUT.data_out, 32'h12345678);
        else begin
            $display("FAIL: Test 17, DUT.data_out is %b, expected %b", DUT.data_out, 32'h12345678);
            error = 1'b1;
        end

        #10;


        //=================================== Case 6: OUTPUT1 & Transition to OUTPUT2 state ===================================
        #30;
        //Check audio_out
        assert(sim_audio_out === 8'h78) //Output lower 16 bits of sample
            $display("Test 18 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h78);
        else begin
            $display("FAIL: Test 18, sim_audio_out is %b, expected %b", sim_audio_out, 8'h78);
            error = 1'b1;
        end

        //Check state
        assert(DUT.state === `OUTPUT2)
            $display("Test 19 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT2);
        else begin
            $display("FAIL: Test 19, DUT.state is %b, expected %b", DUT.state, `OUTPUT2);
            error = 1'b1;
        end

        #10;

        //==================================== Case 7: OUTPUT2 & Transition to OUTPUT3 state ===================================
        #30;
        //Check audio_out
        assert(sim_audio_out === 8'h56) //Output lower 16 bits of sample
            $display("Test 20 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h56);
        else begin
            $display("FAIL: Test 20, sim_audio_out is %b, expected %b", sim_audio_out, 8'h56);
            error = 1'b1;
        end

        //Check state
        assert(DUT.state === `OUTPUT3)
            $display("Test 21 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT3);
        else begin
            $display("FAIL: Test 21, DUT.state is %b, expected %b", DUT.state, `OUTPUT3);
            error = 1'b1;
        end

        #10;


        //==================================== Case 8: OUTPUT3 & Transition to OUTPUT4 state ===================================
        #30;
        //Check audio_out
        assert(sim_audio_out === 8'h34) //Output lower 16 bits of sample
            $display("Test 22 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h34);
        else begin
            $display("FAIL: Test 22, sim_audio_out is %b, expected %b", sim_audio_out, 8'h34);
            error = 1'b1;
        end

        //Check state
        assert(DUT.state === `OUTPUT4)
            $display("Test 23 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT4);
        else begin
            $display("FAIL: Test 23, DUT.state is %b, expected %b", DUT.state, `OUTPUT4);
            error = 1'b1;
        end

        #10;


        //==================================== Case 9: OUTPUT4 & Transition to IDLE state ===================================
        #10;
        //Check audio_out
        assert(sim_audio_out === 8'h12) //Output lower 16 bits of sample
            $display("Test 24 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h12);
        else begin
            $display("FAIL: Test 24, sim_audio_out is %b, expected %b", sim_audio_out, 8'h12);
            error = 1'b1;
        end


        //Check current_address
        assert(DUT.current_address === 23'h1) //Incremented by 1
            $display("Test 25 SUCCESS ** DUT.current_address is %b, expected %b", DUT.current_address, 23'h1);
        else begin
            $display("FAIL: Test 25, DUT.current_address is %b, expected %b", DUT.current_address, 23'h1);
            error = 1'b1;
        end


        //Check state
        assert(DUT.state === `IDLE)
            $display("Test 26 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `IDLE);
        else begin
            $display("FAIL: Test 26, DUT.state is %b, expected %b", DUT.state, `IDLE);
            error = 1'b1;
        end


        //===================================== Case 10: Play music in BACKWARD direction ===================================
        sim_direction = `BACKWARD; //Set direction to BACKWARD
        sim_restart = 1'b1; //Assert restart
        #20;

        //Check current_address
        assert(DUT.current_address === 23'h0)
            $display("Test 27 SUCCESS ** DUT.current_address is %b, expected %b", DUT.current_address, 23'h0);
        else begin
            $display("FAIL: Test 27, DUT.current_address is %b, expected %b", DUT.current_address, 23'h0);
            error = 1'b1;
        end
        
        //Check restart_start_protocol
        assert(sim_restart_start_protocol === 1'b1)
            $display("Test 28 SUCCESS ** sim_restart_start_protocol is %b, expected %b", sim_restart_start_protocol, 1'b1);
        else begin
            $display("FAIL: Test 28, sim_restart_start_protocol is %b, expected %b", sim_restart_start_protocol, 1'b1);
            error = 1'b1;
        end

        #5;
        sim_restart = 1'b0;


        //=================================== Case 11: Transition to ADDRESS state ===================================
        #5;
        sim_play_enable = `PLAY_MUSIC; //Set play_enable to PLAY_MUSIC

        //Check state
        assert(DUT.state === `ADDRESS)
            $display("Test 29 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `ADDRESS);
        else begin
            $display("FAIL: Test 29, DUT.state is %b, expected %b", DUT.state, `ADDRESS);
            error = 1'b1;
        end


        //Check flash_mem_read
        assert(sim_flash_mem_read === 1'b1)
            $display("Test 30 SUCCESS ** sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b1);
        else begin
            $display("FAIL: Test 30, sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b1);
            error = 1'b1;
        end


        //Check flash_mem_address
        assert(sim_flash_mem_address === 23'h1)
            $display("Test 31 SUCCESS ** sim_flash_mem_address is %b, expected %b", sim_flash_mem_address, 23'h1);
        else begin
            $display("FAIL: Test 31, sim_flash_mem_address is %b, expected %b", sim_flash_mem_address, 23'h1);
            error = 1'b1;
        end

        #10;

        //=================================== Case 12: Transition to WAIT_VALID state ===================================
        sim_flash_mem_waitrequest = 1'b0; //Deassert waitrequest to simulate flash memory ready

        #10;
        //Check state
        assert(DUT.state === `WAIT_VALID)
            $display("Test 32 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `WAIT_VALID);
        else begin
            $display("FAIL: Test 32, DUT.state is %b, expected %b", DUT.state, `WAIT_VALID);
            error = 1'b1;
        end

        //Check flash_mem_read
        assert(sim_flash_mem_read === 1'b0)
            $display("Test 33 SUCCESS ** sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b0);
        else begin
            $display("FAIL: Test 33, sim_flash_mem_read is %b, expected %b", sim_flash_mem_read, 1'b0);
            error = 1'b1;
        end


        //=================================== Case 13: Transition to OUTPUT1 state ===================================
        #10;
        sim_flash_mem_readdatavalid = 1'b1; //Simulate valid data from flash memory
        sim_flash_mem_readdata = 32'h12345678; //Simulate some data from flash memory

        #10;

        //Check state
        assert(DUT.state === `OUTPUT1)
            $display("Test 34 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT1);
        else begin
            $display("FAIL: Test 34, DUT.state is %b, expected %b", DUT.state, `OUTPUT1);
            error = 1'b1;
        end

        //Check output_data
        assert(DUT.data_out === 32'h12345678)
            $display("Test 35 SUCCESS ** DUT.data_out is %b, expected %b", DUT.data_out, 32'h12345678);
        else begin
            $display("FAIL: Test 35, DUT.data_out is %b, expected %b", DUT.data_out, 32'h12345678);
            error = 1'b1;
        end

        #10;


        //=================================== Case 14: OUTPUT1 & Transition to OUTPUT2 state ===================================
        #30;
        //Check audio_out
        assert(sim_audio_out === 8'h12) //Output lower 16 bits of sample
            $display("Test 36 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h12);
        else begin
            $display("FAIL: Test 36, sim_audio_out is %b, expected %b", sim_audio_out, 8'h12);
            error = 1'b1;
        end

        //Check state
        assert(DUT.state === `OUTPUT2)
            $display("Test 37 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT2);
        else begin
            $display("FAIL: Test 37, DUT.state is %b, expected %b", DUT.state, `OUTPUT2);
            error = 1'b1;
        end

        #10;

        //==================================== Case 15: OUTPUT2 & Transition to OUTPUT3 state ===================================
        #30;
        //Check audio_out
        assert(sim_audio_out === 8'h34) //Output lower 16 bits of sample
            $display("Test 38 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h34);
        else begin
            $display("FAIL: Test 38, sim_audio_out is %b, expected %b", sim_audio_out, 8'h34);
            error = 1'b1;
        end

        //Check state
        assert(DUT.state === `OUTPUT3)
            $display("Test 39 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT3);
        else begin
            $display("FAIL: Test 39, DUT.state is %b, expected %b", DUT.state, `OUTPUT3);
            error = 1'b1;
        end

        #10;


        //==================================== Case 16: OUTPUT3 & Transition to OUTPUT4 state ===================================
        #30;
        //Check audio_out
        assert(sim_audio_out === 8'h56) //Output lower 16 bits of sample
            $display("Test 40 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h56);
        else begin
            $display("FAIL: Test 40, sim_audio_out is %b, expected %b", sim_audio_out, 8'h56);
            error = 1'b1;
        end

        //Check state
        assert(DUT.state === `OUTPUT4)
            $display("Test 41 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `OUTPUT4);
        else begin
            $display("FAIL: Test 41, DUT.state is %b, expected %b", DUT.state, `OUTPUT4);
            error = 1'b1;
        end

        #10;

        //==================================== Case 17: OUTPUT4 & Transition to IDLE state ===================================
        #10;
        //Check audio_out
        assert(sim_audio_out === 8'h78) //Output lower 16 bits of sample
            $display("Test 42 SUCCESS ** sim_audio_out is %b, expected %b", sim_audio_out, 8'h78);
        else begin
            $display("FAIL: Test 42, sim_audio_out is %b, expected %b", sim_audio_out, 8'h78);
            error = 1'b1;
        end


        //Check current_address
        assert(DUT.current_address === `MAX_ADDRESS) //Incremented by 1
            $display("Test 43 SUCCESS ** DUT.current_address is %b, expected %b", DUT.current_address, `MAX_ADDRESS);
        else begin
            $display("FAIL: Test 43, DUT.current_address is %b, expected %b", DUT.current_address, `MAX_ADDRESS);
            error = 1'b1;
        end


        //Check state
        assert(DUT.state === `IDLE)
            $display("Test 44 SUCCESS ** DUT.state is %b, expected %b", DUT.state, `IDLE);
        else begin
            $display("FAIL: Test 44, DUT.state is %b, expected %b", DUT.state, `IDLE);
            error = 1'b1;
        end



        //Check error signal
        if (~error) begin
            $display("PASSED: All Flash_FSM_Controller tests passed!");
        end else begin
            $display("FAILED: One or more Flash_FSM_Controller tests failed.");
        end

        $finish;
    end



endmodule
