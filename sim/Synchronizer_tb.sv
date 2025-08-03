`timescale 1ns/1ns

module Synchronizer_tb;
    logic sim_async_in, sim_clk, sim_reset;
    logic sim_sync_out;
    logic error;

    Synchronizer DUT(
        .async_in(sim_async_in),
        .clk_in(sim_clk),
        .reset(sim_reset),
        .sync_out(sim_sync_out)
    );


    //Simulate the clk signal for sim_clk, 50MHz
    initial sim_clk = 0;
    always #10 sim_clk = ~sim_clk; //50MHz clock, period is 20ns, half period is 10ns


    //Simulate the clk signal for sim_clk, 25MHz (just for testing purposes)
    initial sim_async_in = 0;
    always #20 sim_async_in = ~sim_async_in; //25MHz clock, period is 40ns, half period is 20ns


    initial begin
        error = 1'b0;
        sim_reset = 1'b0;
        #20;

        //=================================== Case 1: Reset the Synchronizer ===================================
        sim_reset = 1'b1;
        #10;

        //Check sync_level_1
        assert(DUT.sync_level_1 === 1'b0)
            $display("Test 1 SUCCESS ** DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b0);
        else begin
            $display("FAIL: Test 1, DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b0);
            error = 1'b1;
        end

        //Check sync_level_2
        assert(DUT.sync_level_2 === 1'b0)
            $display("Test 2 SUCCESS ** DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b0);
        else begin
            $display("FAIL: Test 2, DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b0);
            error = 1'b1;
        end

        //Check sync_level_3
        assert(DUT.sync_level_3 === 1'b0)
            $display("Test 3 SUCCESS ** DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b0);
        else begin
            $display("FAIL: Test 3, DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b0);
            error = 1'b1;
        end

        //Check sync_out
        assert(DUT.sync_out === 1'b0)
            $display("Test 4 SUCCESS ** DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b0);
        else begin
            $display("FAIL: Test 4, DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b0);
            error = 1'b1;
        end

        #5;
        sim_reset = 1'b0; //Release reset
        #5;

        //==================================== Case 2: Synchronizer Normal Operation - Step 1 ===================================
        #35;
        //Check sync_level_1
        assert(DUT.sync_level_1 === 1'b1)
            $display("Test 5 SUCCESS ** DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b1);
        else begin
            $display("FAIL: Test 5, DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b1);
            error = 1'b1;
        end

        //Check sync_level_2
        assert(DUT.sync_level_2 === 1'b0)
            $display("Test 6 SUCCESS ** DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b0);
        else begin
            $display("FAIL: Test 6, DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b0);
            error = 1'b1;
        end

        //Check sync_level_3
        assert(DUT.sync_level_3 === 1'b0)
            $display("Test 7 SUCCESS ** DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b0);
        else begin
            $display("FAIL: Test 7, DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b0);
            error = 1'b1;
        end

        //Check sync_out
        assert(DUT.sync_out === 1'b0)
            $display("Test 8 SUCCESS ** DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b0);
        else begin
            $display("FAIL: Test 8, DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b0);
            error = 1'b1;
        end

        #5;


        //==================================== Case 3: Synchronizer Normal Operation - Step 2 ===================================
        #15;
        //Check sync_level_1
        assert(DUT.sync_level_1 === 1'b0)
            $display("Test 9 SUCCESS ** DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b0);
        else begin
            $display("FAIL: Test 9, DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b0);
            error = 1'b1;
        end

        //Check sync_level_2
        assert(DUT.sync_level_2 === 1'b1)
            $display("Test 10 SUCCESS ** DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b1);
        else begin
            $display("FAIL: Test 10, DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b1);
            error = 1'b1;
        end

        //Check sync_level_3
        assert(DUT.sync_level_3 === 1'b0)
            $display("Test 11 SUCCESS ** DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b0);
        else begin
            $display("FAIL: Test 11, DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b0);
            error = 1'b1;
        end

        //Check sync_out
        assert(DUT.sync_out === 1'b0)
            $display("Test 12 SUCCESS ** DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b0);
        else begin
            $display("FAIL: Test 12, DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b0);
            error = 1'b1;
        end
        
        #10;


        //==================================== Case 4: Synchronizer Normal Operation - Step 2 ===================================
        #15;
        //Check sync_level_1
        assert(DUT.sync_level_1 === 1'b1)
            $display("Test 13 SUCCESS ** DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b1);
        else begin
            $display("FAIL: Test 13, DUT.sync_level_1 is %b, expected %b", DUT.sync_level_1, 1'b1);
            error = 1'b1;
        end

        //Check sync_level_2
        assert(DUT.sync_level_2 === 1'b0)
            $display("Test 14 SUCCESS ** DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b0);
        else begin
            $display("FAIL: Test 14, DUT.sync_level_2 is %b, expected %b", DUT.sync_level_2, 1'b0);
            error = 1'b1;
        end

        //Check sync_level_3
        assert(DUT.sync_level_3 === 1'b1)
            $display("Test 15 SUCCESS ** DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b1);
        else begin
            $display("FAIL: Test 15, DUT.sync_level_3 is %b, expected %b", DUT.sync_level_3, 1'b1);
            error = 1'b1;
        end

        //Check sync_out
        assert(DUT.sync_out === 1'b1)
            $display("Test 16 SUCCESS ** DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b1);
        else begin
            $display("FAIL: Test 16, DUT.sync_out is %b, expected %b", DUT.sync_out, 1'b1);
            error = 1'b1;
        end
        
        #10;





        //Check error signal
        if (~error) begin
            $display("PASSED: All Synchronizer tests passed!");
        end else begin
            $display("FAILED: One or more Synchronizer tests failed.");
        end

        $finish;

    end


endmodule