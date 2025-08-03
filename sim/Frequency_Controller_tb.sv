`timescale 1ns/1ns


//Music frequency
// `define MUSIC_FREQUENCY_DEFAULT 32'd1228 //for 16 bit samples at 22KHz
`define MUSIC_FREQUENCY_DEFAULT 32'd614 //Bonus: for 8 bit samples at 44KHz
`define MIN_FREQUENCY_COUNT 32'd1 //fastest frequency
`define MAX_FREQUENCY_COUNT 32'd4000 //slowest frequency
`define INCREMENT 32'd1 //Not specified in lab, value I chose to illustrate how the frequency changes dramatically


//Define default state
`define DEFAULT 1'b0 //default frequency is played
`define CUSTOM 1'b1 //custom frequency is played


module Frequency_Controller_tb;
    parameter N = 32;

    logic sim_clk, sim_reset;
    logic sim_speed_up_event, sim_speed_down_event, sim_speed_reset_event; //Input logic for speed
    logic [N-1:0] sim_freq_count;
    logic [N-1:0] prev_freq_count; //Previous frequency count for comparison

    //Error signal
    logic error;

    //Instantiate the DUT
    Frequency_Controller #(.N(N)) DUT (
        .clk_in(sim_clk),
        .reset(sim_reset),
        .speed_up_event(sim_speed_up_event),
        .speed_down_event(sim_speed_down_event),
        .speed_reset_event(sim_speed_reset_event),
        .freq_count(sim_freq_count)
    );



    //Simulate the clk signal for sim_clk, 50MHz
    initial sim_clk = 0;
    always #10 sim_clk = ~sim_clk; //50MHz clock, period is 20ns, half period is 10ns


    initial begin
        //Initialize inputs
        sim_reset = 1'b0;
        sim_speed_up_event = 1'b0;
        sim_speed_down_event = 1'b0;
        sim_speed_reset_event = 1'b0;
        error = 1'b0;
        #5; //wait for clock and signals to stabilize

        //=================================== Case 1: Reset the Frequency Controller ===================================
        sim_reset = 1'b1;
        #5; //Clock is high

        //Check custom_state
        assert(DUT.custom_state === `DEFAULT)
            $display("Test 1 SUCCESS ** DUT.custom_state is %b, expected %b", DUT.custom_state, `DEFAULT);
        else begin
            $display("FAIL: Test 1, DUT.custom_state is %b, expected %b", DUT.custom_state, `DEFAULT);
            error = 1'b1;
        end


        //Check freq_count
        assert(sim_freq_count === `MUSIC_FREQUENCY_DEFAULT) begin
            $display("Test 2 SUCCESS ** freq_count is %d, expected %d", sim_freq_count, `MUSIC_FREQUENCY_DEFAULT);
            prev_freq_count = sim_freq_count; //Store the frequency count for comparison
        end else begin
            $display("FAIL: Test 2, freq_count is %d, expected %d", sim_freq_count, `MUSIC_FREQUENCY_DEFAULT);
            error = 1'b1;
        end

        #5;
        sim_reset = 1'b0;
        #5; //Clock is low

        //=================================== Case 2: Speed up event (x 2) ===================================
        #5;
        sim_speed_up_event = 1'b1;

        #20; //Clock is high


        //Check custom_state
        assert(DUT.custom_state === `CUSTOM)
            $display("Test 3 SUCCESS ** DUT.custom_state is %b, expected %b", DUT.custom_state, `CUSTOM);
        else begin
            $display("FAIL: Test 3, DUT.custom_state is %b, expected %b", DUT.custom_state, `CUSTOM);
            error = 1'b1;
        end


        //Check freq_count
        assert(sim_freq_count === (prev_freq_count - `INCREMENT)) begin
            $display("Test 4 SUCCESS ** freq_count is %d, expected %d", sim_freq_count, (prev_freq_count - `INCREMENT));
            prev_freq_count = sim_freq_count; //Store the frequency count for comparison
        end else begin
            $display("FAIL: Test 4, freq_count is %d, expected %d", sim_freq_count, (prev_freq_count - `INCREMENT));
            error = 1'b1;
        end


        #10; //Clock is high

        //Check custom_state
        assert(DUT.custom_state === `CUSTOM)
            $display("Test 5 SUCCESS ** DUT.custom_state is %b, expected %b", DUT.custom_state, `CUSTOM);
        else begin
            $display("FAIL: Test 5, DUT.custom_state is %b, expected %b", DUT.custom_state, `CUSTOM);
            error = 1'b1;
        end


        //Check freq_count
        assert(sim_freq_count === (prev_freq_count - `INCREMENT)) begin
            $display("Test 6 SUCCESS ** freq_count is %d, expected %d", sim_freq_count, (prev_freq_count - `INCREMENT));
            prev_freq_count = sim_freq_count; //Store the frequency count for comparison
        end else begin
            $display("FAIL: Test 6, freq_count is %d, expected %d", sim_freq_count, (prev_freq_count - `INCREMENT));
            error = 1'b1;
        end

        sim_speed_up_event = 1'b0; //Reset speed up event

        //=================================== Case 3: Speed down event (x 1) ===================================
        #5;
        sim_speed_down_event = 1'b1;
        #20; //Clock is high


        //Check custom_state
        assert(DUT.custom_state === `CUSTOM)
            $display("Test 7 SUCCESS ** DUT.custom_state is %b, expected %b", DUT.custom_state, `CUSTOM);
        else begin
            $display("FAIL: Test 7, DUT.custom_state is %b, expected %b", DUT.custom_state, `CUSTOM);
            error = 1'b1;
        end


        //Check freq_count
        assert(sim_freq_count === (prev_freq_count + `INCREMENT)) begin
            $display("Test 8 SUCCESS ** freq_count is %d, expected %d", sim_freq_count, (prev_freq_count + `INCREMENT));
            prev_freq_count = sim_freq_count; //Store the frequency count for comparison
        end else begin
            $display("FAIL: Test 8, freq_count is %d, expected %d", sim_freq_count, (prev_freq_count + `INCREMENT));
            error = 1'b1;
        end


        sim_speed_down_event = 1'b0; //Reset speed down event



        //=================================== Case 4: Speed reset event ===================================
        #5;
        sim_speed_reset_event = 1'b1;
        #20; //Clock is high


        //Check custom_state
        assert(DUT.custom_state === `DEFAULT)
            $display("Test 9 SUCCESS ** DUT.custom_state is %b, expected %b", DUT.custom_state, `DEFAULT);
        else begin
            $display("FAIL: Test 9, DUT.custom_state is %b, expected %b", DUT.custom_state, `DEFAULT);
            error = 1'b1;
        end


        //Check freq_count
        assert(sim_freq_count === `MUSIC_FREQUENCY_DEFAULT) begin
            $display("Test 10 SUCCESS ** freq_count is %d, expected %d", sim_freq_count, `MUSIC_FREQUENCY_DEFAULT);
            prev_freq_count = sim_freq_count; //Store the frequency count for comparison
        end else begin
            $display("FAIL: Test 10, freq_count is %d, expected %d", sim_freq_count, `MUSIC_FREQUENCY_DEFAULT);
            error = 1'b1;
        end


        //Check error signal
        if (~error) begin
            $display("PASSED: All Frequency_Controller tests passed!");
        end else begin
            $display("FAILED: One or more Frequency_Controller tests failed.");
        end

        $finish;
    end
endmodule