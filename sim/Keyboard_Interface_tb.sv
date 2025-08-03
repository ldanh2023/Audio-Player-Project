`timescale 1ns/1ns


//Stop and start music
`define STOP_MUSIC 1'b0
`define PLAY_MUSIC 1'b1

//Playback mode
`define FORWARD 1'b0
`define BACKWARD 1'b1

module Keyboard_Interface_tb;
    //ASCII characters from top module
    
    //Character definitions
    //numbers
    parameter character_0 =8'h30;
    parameter character_1 =8'h31;
    parameter character_2 =8'h32;
    parameter character_3 =8'h33;
    parameter character_4 =8'h34;
    parameter character_5 =8'h35;
    parameter character_6 =8'h36;
    parameter character_7 =8'h37;
    parameter character_8 =8'h38;
    parameter character_9 =8'h39;


    //Uppercase Letters
    parameter character_A =8'h41;
    parameter character_B =8'h42;
    parameter character_C =8'h43;
    parameter character_D =8'h44;
    parameter character_E =8'h45;
    parameter character_F =8'h46;
    parameter character_G =8'h47;
    parameter character_H =8'h48;
    parameter character_I =8'h49;
    parameter character_J =8'h4A;
    parameter character_K =8'h4B;
    parameter character_L =8'h4C;
    parameter character_M =8'h4D;
    parameter character_N =8'h4E;
    parameter character_O =8'h4F;
    parameter character_P =8'h50;
    parameter character_Q =8'h51;
    parameter character_R =8'h52;
    parameter character_S =8'h53;
    parameter character_T =8'h54;
    parameter character_U =8'h55;
    parameter character_V =8'h56;
    parameter character_W =8'h57;
    parameter character_X =8'h58;
    parameter character_Y =8'h59;
    parameter character_Z =8'h5A;

    //Lowercase Letters
    parameter character_lowercase_a= 8'h61;
    parameter character_lowercase_b= 8'h62;
    parameter character_lowercase_c= 8'h63;
    parameter character_lowercase_d= 8'h64;
    parameter character_lowercase_e= 8'h65;
    parameter character_lowercase_f= 8'h66;
    parameter character_lowercase_g= 8'h67;
    parameter character_lowercase_h= 8'h68;
    parameter character_lowercase_i= 8'h69;
    parameter character_lowercase_j= 8'h6A;
    parameter character_lowercase_k= 8'h6B;
    parameter character_lowercase_l= 8'h6C;
    parameter character_lowercase_m= 8'h6D;
    parameter character_lowercase_n= 8'h6E;
    parameter character_lowercase_o= 8'h6F;
    parameter character_lowercase_p= 8'h70;
    parameter character_lowercase_q= 8'h71;
    parameter character_lowercase_r= 8'h72;
    parameter character_lowercase_s= 8'h73;
    parameter character_lowercase_t= 8'h74;
    parameter character_lowercase_u= 8'h75;
    parameter character_lowercase_v= 8'h76;
    parameter character_lowercase_w= 8'h77;
    parameter character_lowercase_x= 8'h78;
    parameter character_lowercase_y= 8'h79;
    parameter character_lowercase_z= 8'h7A;

    //Other Characters
    parameter character_colon = 8'h3A;          //':'
    parameter character_stop = 8'h2E;           //'.'
    parameter character_semi_colon = 8'h3B;   //';'
    parameter character_minus = 8'h2D;         //'-'
    parameter character_divide = 8'h2F;         //'/'
    parameter character_plus = 8'h2B;          //'+'
    parameter character_comma = 8'h2C;          // ','
    parameter character_less_than = 8'h3C;    //'<'
    parameter character_greater_than = 8'h3E; //'>'
    parameter character_equals = 8'h3D;         //'='
    parameter character_question = 8'h3F;      //'?'
    parameter character_dollar = 8'h24;         //'$'
    parameter character_space=8'h20;           //' '     
    parameter character_exclaim=8'h21;          //'!'


    
    logic sim_clk, sim_reset;
    logic sim_kbd_data_ready;
    logic [7:0] sim_kbd_received_ascii_code;
    logic sim_restart_start_protocol;
    logic sim_play_enable;
    logic sim_direction;
    logic sim_restart;

    //Error signal
    logic error;

    //Instantiate the DUT
    Keyboard_Interface DUT (
        //Keyboard inputs
        .kbd_data_ready(sim_kbd_data_ready),
        .kbd_received_ascii_code(sim_kbd_received_ascii_code),

        //Clock and reset
        .clk_in(sim_clk),
        .reset(sim_reset),

        .restart_start_protocol(sim_restart_start_protocol),

        //Play mode outputs
        .play_enable(sim_play_enable),
        .direction(sim_direction),
        .restart(sim_restart)
    );



    //Simulate the clk signal for sim_clk, 50MHz
    initial sim_clk = 0;
    always #10 sim_clk = ~sim_clk; //50MHz clock, period is 20ns, half period is 10ns


    initial begin
        //Initialize inputs
        sim_reset = 1'b0;
        sim_kbd_data_ready = 1'b0;
        sim_kbd_received_ascii_code = 8'h00; //No character received
        sim_restart_start_protocol = 1'b0;
        error = 1'b0;
        #5; //wait for clock and signals to stabilize


        //=================================== Case 1: Reset the Keyboard Interface ===================================
        sim_reset = 1'b1;
        #5; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 1 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 1, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 2 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 2, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end

        //Check sim_restart
        assert(sim_restart === 1'b0)
            $display("Test 3 SUCCESS ** sim_restart is %b, expected %b", sim_restart, 1'b0);
        else begin
            $display("FAIL: Test 3, sim_restart is %b, expected %b", sim_restart, 1'b0);
            error = 1'b1;
        end

        #5;
        sim_reset = 1'b0;


        //=================================== Case 2: Test Play Event (Capital E) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_E;
        #15; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `PLAY_MUSIC)
            $display("Test 4 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `PLAY_MUSIC);
        else begin
            $display("FAIL: Test 4, sim_play_enable is %b, expected %b", sim_play_enable, `PLAY_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 5 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 5, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end

        #5; //clock is low
        sim_kbd_data_ready = 1'b0; //Reset play event


        //=================================== Case 3: Test Stop Event (Capital D) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_D;
        #15; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 6 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 6, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 7 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 7, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end

        #5;
        sim_kbd_data_ready = 1'b0; //Reset stop event


        //=================================== Case 4: Test Play Event (Lowercase e) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_lowercase_e;
        #15; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `PLAY_MUSIC)
            $display("Test 8 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `PLAY_MUSIC);
        else begin
            $display("FAIL: Test 8, sim_play_enable is %b, expected %b", sim_play_enable, `PLAY_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 9 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 9, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end

        #5; //clock is low
        sim_kbd_data_ready = 1'b0; //Reset play event


        //=================================== Case 5: Test Stop Event (lowercase d) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_lowercase_d;
        #20; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 10 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 10, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 11 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 11, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end

        #5;
        sim_kbd_data_ready = 1'b0; //Reset stop event



        //=================================== Case 6: Test Backward Event (Capital B) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_B;
        #15; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 12 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 12, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `BACKWARD)
            $display("Test 13 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `BACKWARD);
        else begin
            $display("FAIL: Test 13, sim_direction is %b, expected %b", sim_direction, `BACKWARD);
            error = 1'b1;
        end

        #5;
        sim_kbd_data_ready = 1'b0; //Reset stop event


        //=================================== Case 7: Test Forward Event (Capital F) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_F;
        #15; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 14 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 14, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 15 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 15, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end

        #5;
        sim_kbd_data_ready = 1'b0; //Reset stop event


        //=================================== Case 8: Test Backward Event (lowercase b) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_lowercase_b;
        #20; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 16 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 16, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `BACKWARD)
            $display("Test 17 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `BACKWARD);
        else begin
            $display("FAIL: Test 17, sim_direction is %b, expected %b", sim_direction, `BACKWARD);
            error = 1'b1;
        end

        #5;
        sim_kbd_data_ready = 1'b0; //Reset stop event


        //=================================== Case 9: Test Forward Event (lowercase f) ===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_lowercase_f;
        #15; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 18 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 18, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 19 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 19, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end

        #5;
        sim_kbd_data_ready = 1'b0; //Reset stop event


        //==================================== Case 10: Restart start protocol (Capital R)===================================
        #5;
        sim_kbd_data_ready = 1'b1;
        sim_kbd_received_ascii_code = character_R;
        #20; //Clock is high

        //Check sim_play_enable
        assert(sim_play_enable === `STOP_MUSIC)
            $display("Test 20 SUCCESS ** sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
        else begin
            $display("FAIL: Test 20, sim_play_enable is %b, expected %b", sim_play_enable, `STOP_MUSIC);
            error = 1'b1;
        end

        //Check sim_direction
        assert(sim_direction === `FORWARD)
            $display("Test 21 SUCCESS ** sim_direction is %b, expected %b", sim_direction, `FORWARD);
        else begin
            $display("FAIL: Test 21, sim_direction is %b, expected %b", sim_direction, `FORWARD);
            error = 1'b1;
        end


        //Check restart
        assert(sim_restart === 1'b1)
            $display("Test 22 SUCCESS ** sim_restart is %b, expected %b", sim_restart, 1'b1);
        else begin
            $display("FAIL: Test 22, sim_restart is %b, expected %b", sim_restart, 1'b1);
            error = 1'b1;
        end

        #5;
        sim_kbd_data_ready = 1'b0; //Reset stop event
        

        //Check error signal
        if (~error) begin
            $display("PASSED: All Keyboard_Interface tests passed!");
        end else begin
            $display("FAILED: One or more Keyboard_Interface tests failed.");
        end

        $finish;
    end
endmodule
