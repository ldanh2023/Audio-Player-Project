`timescale 1ms/1ms

`define SW0 3'b010
`define SW1 3'b001
`define SW2 3'b000
`define SW3 3'b011
`define SW4 3'b100
`define SW5 3'b101
`define SW6 3'b110
`define SW7 3'b111

//Define outputs
`define SW0_out 8'b00000001
`define SW1_out 8'b00000010
`define SW2_out 8'b00000100
`define SW3_out 8'b00001000
`define SW4_out 8'b00010000
`define SW5_out 8'b00100000
`define SW6_out 8'b01000000
`define SW7_out 8'b10000000

//Direction: 0: dir -> right, 1: dir -> left
`define LEFT 1'b1
`define RIGHT 1'b0

module LED_FSM_Controller_tb;
    //Inputs to DUT
    logic sim_clk;
    logic sim_reset;

    //Outputs to be checked
    logic [7:0] sim_out;

    //Error signal
    logic error;

    LED_FSM_Controller #(.N(8)) DUT(.clk(sim_clk), .reset(sim_reset), .out(sim_out));

    //Simulate the clk signal for sim_clk, 1Hz
    initial sim_clk = 0;
    always #500 sim_clk = ~sim_clk; //1Hz clock, period is 1000ms, half period is 500ms


    initial begin
        //Initialize signals
        sim_reset = 1'b0;
        error = 1'b0;
        #10;
        

        //======================= Case 1: Reset the FSM (start at SW2) ======================
        sim_reset = 1'b1; //Reset the FSM
        #10;

        //Check output
        assert(sim_out === `SW2_out)
            $display("Test 1 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW2_out);
        else begin
            $display("FAIL: Test 1, sim_out is %b, expected %b (on)", sim_out, `SW2_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW2)
            $display("Test 2 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW2);
        else begin
            $display("FAIL: Test 2, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW2);
            error = 1'b1;
        end

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 3 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 3, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        sim_reset = 1'b0; //turn off reset
        
        #480; //Wait for 1 second to check next state


        //======================= Case 2: Next state - SW1 ======================
        #20;

        //Check output
        assert(sim_out === `SW1_out)
            $display("Test 4 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW1_out);
        else begin
            $display("FAIL: Test 4, sim_out is %b, expected %b (on)", sim_out, `SW1_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW1)
            $display("Test 5 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW1);
        else begin
            $display("FAIL: Test 5, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW1);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 6 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 6, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 3: Next state - SW0 ======================
        #20;

        //Check output
        assert(sim_out === `SW0_out)
            $display("Test 7 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW0_out);
        else begin
            $display("FAIL: Test 7, sim_out is %b, expected %b (on)", sim_out, `SW0_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW0)
            $display("Test 8 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW0);
        else begin
            $display("FAIL: Test 8, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW0);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 9 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 9, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 4: Next state - SW1 ======================
        #20;

        //Check output
        assert(sim_out === `SW1_out)
            $display("Test 10 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW1_out);
        else begin
            $display("FAIL: Test 10, sim_out is %b, expected %b (on)", sim_out, `SW1_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW1)
            $display("Test 11 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW1);
        else begin
            $display("FAIL: Test 11, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW1);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `LEFT)
            $display("Test 12 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `LEFT);
        else begin
            $display("FAIL: Test 12, direction is %b, expected %b (on)", DUT.direction, `LEFT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 5: Next state - SW2 ======================
        #20;

        //Check output
        assert(sim_out === `SW2_out)
            $display("Test 13 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW2_out);
        else begin
            $display("FAIL: Test 13, sim_out is %b, expected %b (on)", sim_out, `SW2_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW2)
            $display("Test 14 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW2);
        else begin
            $display("FAIL: Test 14, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW2);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `LEFT)
            $display("Test 15 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `LEFT);
        else begin
            $display("FAIL: Test 15, direction is %b, expected %b (on)", DUT.direction, `LEFT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 6: Next state - SW3 ======================
        #20;

        //Check output
        assert(sim_out === `SW3_out)
            $display("Test 16 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW3_out);
        else begin
            $display("FAIL: Test 16, sim_out is %b, expected %b (on)", sim_out, `SW3_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW3)
            $display("Test 17 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW3);
        else begin
            $display("FAIL: Test 17, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW3);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `LEFT)
            $display("Test 18 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `LEFT);
        else begin
            $display("FAIL: Test 18, direction is %b, expected %b (on)", DUT.direction, `LEFT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 7: Next state - SW4 ======================
        #20;

        //Check output
        assert(sim_out === `SW4_out)
            $display("Test 19 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW4_out);
        else begin
            $display("FAIL: Test 19, sim_out is %b, expected %b (on)", sim_out, `SW4_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW4)
            $display("Test 20 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW4);
        else begin
            $display("FAIL: Test 20, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW4);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `LEFT)
            $display("Test 21 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `LEFT);
        else begin
            $display("FAIL: Test 21, direction is %b, expected %b (on)", DUT.direction, `LEFT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 8: Next state - SW5 ======================
        #20;
        
        //Check output
        assert(sim_out === `SW5_out)
            $display("Test 22 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW5_out);
        else begin
            $display("FAIL: Test 22, sim_out is %b, expected %b (on)", sim_out, `SW5_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW5)
            $display("Test 23 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW5);
        else begin
            $display("FAIL: Test 23, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW5);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `LEFT)
            $display("Test 24 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `LEFT);
        else begin
            $display("FAIL: Test 24, direction is %b, expected %b (on)", DUT.direction, `LEFT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 9: Next state - SW6 ======================
        #20;

        //Check output
        assert(sim_out === `SW6_out)
            $display("Test 25 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW6_out);
        else begin
            $display("FAIL: Test 25, sim_out is %b, expected %b (on)", sim_out, `SW6_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW6)
            $display("Test 26 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW6);
        else begin
            $display("FAIL: Test 26, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW6);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `LEFT)
            $display("Test 27 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `LEFT);
        else begin
            $display("FAIL: Test 27, direction is %b, expected %b (on)", DUT.direction, `LEFT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 10: Next state - SW7 ======================
        #20;

        //Check output
        assert(sim_out === `SW7_out)
            $display("Test 28 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW7_out);
        else begin
            $display("FAIL: Test 28, sim_out is %b, expected %b (on)", sim_out, `SW7_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW7)
            $display("Test 29 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW7);
        else begin
            $display("FAIL: Test 29, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW7);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `LEFT)
            $display("Test 30 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `LEFT);
        else begin
            $display("FAIL: Test 30, direction is %b, expected %b (on)", DUT.direction, `LEFT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 11: Next state - SW6 ======================
        #20;

        //Check output
        assert(sim_out === `SW6_out)
            $display("Test 31 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW6_out);
        else begin
            $display("FAIL: Test 31, sim_out is %b, expected %b (on)", sim_out, `SW6_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW6)
            $display("Test 32 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW6);
        else begin
            $display("FAIL: Test 32, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW6);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 33 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 33, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end
        
        #970; //Wait for 1 second to check next state


        //======================= Case 12: Next state - SW5 ======================
        #20;

        //Check output
        assert(sim_out === `SW5_out)
            $display("Test 34 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW5_out);
        else begin
            $display("FAIL: Test 34, sim_out is %b, expected %b (on)", sim_out, `SW5_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW5)
            $display("Test 35 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW5);
        else begin
            $display("FAIL: Test 35, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW5);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 36 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 36, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 13: Next state - SW4 ======================
        #20;

        //Check output
        assert(sim_out === `SW4_out)
            $display("Test 37 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW4_out);
        else begin
            $display("FAIL: Test 37, sim_out is %b, expected %b (on)", sim_out, `SW4_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW4)
            $display("Test 38 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW4);
        else begin
            $display("FAIL: Test 38, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW4);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 39 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 39, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 14: Next state - SW3 ======================
        #20;

        //Check output
        assert(sim_out === `SW3_out)
            $display("Test 40 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW3_out);
        else begin
            $display("FAIL: Test 40, sim_out is %b, expected %b (on)", sim_out, `SW3_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW3)
            $display("Test 41 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW3);
        else begin
            $display("FAIL: Test 41, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW3);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 42 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 42, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 15: Next state - SW2 ======================
        #20;

        //Check output
        assert(sim_out === `SW2_out)
            $display("Test 43 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW2_out);
        else begin
            $display("FAIL: Test 43, sim_out is %b, expected %b (on)", sim_out, `SW2_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW2)
            $display("Test 44 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW2);
        else begin
            $display("FAIL: Test 44, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW2);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 45 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 45, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 16: Next state - SW1 ======================
        #20;

        //Check output
        assert(sim_out === `SW1_out)
            $display("Test 46 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW1_out);
        else begin
            $display("FAIL: Test 46, sim_out is %b, expected %b (on)", sim_out, `SW1_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW1)
            $display("Test 47 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW1);
        else begin
            $display("FAIL: Test 47, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW1);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 48 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 48, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end

        #970; //Wait for 1 second to check next state


        //======================= Case 17: Next state - SW0 ======================
        #20;

        //Check output
        assert(sim_out === `SW0_out)
            $display("Test 49 SUCCESS ** sim_out is %b, expected %b (on)", sim_out, `SW0_out);
        else begin
            $display("FAIL: Test 49, sim_out is %b, expected %b (on)", sim_out, `SW0_out);
            error = 1'b1;
        end

        //Check current state
        assert(DUT.current_state === `SW0)
            $display("Test 50 SUCCESS ** DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW0);
        else begin
            $display("FAIL: Test 50, DUT.current_state is %b, expected %b (on)", DUT.current_state, `SW0);
            error = 1'b1;
        end

        #10;

        //Check direction
        assert(DUT.direction === `RIGHT)
            $display("Test 51 SUCCESS ** direction is %b, expected %b (on)", DUT.direction, `RIGHT);
        else begin
            $display("FAIL: Test 51, direction is %b, expected %b (on)", DUT.direction, `RIGHT);
            error = 1'b1;
        end



        if (~error) begin
            $display("PASSED: All LED_FSM_Controller tests passed!");
        end else begin
            $display("FAILED: One or more LED_FSM_Controller tests failed.");
        end

        $finish;
    end
endmodule