//Stop and start music
`define STOP_MUSIC 1'b0
`define PLAY_MUSIC 1'b1

//Playback mode
`define FORWARD 1'b0
`define BACKWARD 1'b1

module Keyboard_Interface (
    //Keyboard inputs
    input logic kbd_data_ready,
    input logic [7:0] kbd_received_ascii_code,

    //Clock and reset
    input logic clk_in,
    input logic reset,

    input logic restart_start_protocol, //Uses the Start-Finish protocol taught in class

    //Play mode outputs
    output logic play_enable, 
    output logic direction,
    output logic restart                       
);

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


    always_ff @(posedge clk_in or posedge reset) begin
        if (reset) begin
            play_enable <= `STOP_MUSIC;
            direction <= `FORWARD;
            restart <= 1'b0;
        end else begin
            if (restart_start_protocol) begin
                restart <= 1'b0;
            end

            if (kbd_data_ready) begin
                case (kbd_received_ascii_code)
                    character_D: begin //Stop music for D (upper or lowercase)
                        play_enable <= `STOP_MUSIC;
                    end
                    character_lowercase_d: begin
                        play_enable <= `STOP_MUSIC;
                    end

                    character_E: begin //Start music for E (upper or lowercase)
                        play_enable <= `PLAY_MUSIC;
                    end character_lowercase_e: begin
                        play_enable <= `PLAY_MUSIC;
                    end

                    character_B: begin //Play music backward for B (upper or lowercase)
                        direction <= `BACKWARD;
                    end character_lowercase_b: begin
                        direction <= `BACKWARD;
                    end

                    character_F: begin //Play music forward for F (upper or lowercase)
                        direction <= `FORWARD;
                    end character_lowercase_f: begin
                        direction <= `FORWARD;
                    end

                    character_R: begin //Restart music for R (upper or lowercase)
                        restart <= 1'b1;
                    end character_lowercase_r: begin
                        restart <= 1'b1;
                    end
                endcase
            end
        end
    end

endmodule