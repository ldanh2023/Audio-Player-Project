//Define FSM states
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

module LED_FSM_Controller(clk, reset, out);
    parameter N = 8; //default is 0-7 LEDs

    input logic clk, reset;
    output logic [N-1:0] out;

    logic [2:0] current_state;
    logic direction;


    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
			direction <= `RIGHT;
            current_state <= `SW2;
        end
        else begin
            case (current_state)
                `SW0: begin //if at LED0, move to the left
                    current_state <= `SW1;
                    direction <= `LEFT;
                end
                `SW1: begin //all other LEDs are bidirectional, can move to the left or right depending on direction
                    if (direction == `RIGHT) begin
                        current_state <= `SW0;
                    end
                    else begin
                        current_state <= `SW2;
                    end
                end
                `SW2: begin //LEDs from LED1 to LED6 have the same behavior
                    if (direction == `RIGHT) begin
                        current_state <= `SW1;
                    end
                    else begin
                        current_state <= `SW3;
                    end
                end
                `SW3: begin
                    if (direction == `RIGHT) begin
                        current_state <= `SW2;
                    end
                    else begin
                        current_state <= `SW4;
                    end
                end
                `SW4: begin
                    if (direction == `RIGHT) begin
                        current_state <= `SW3;
                    end
                    else begin
                        current_state <= `SW5;
                    end
                end
                `SW5: begin
                    if (direction == `RIGHT) begin
                        current_state <= `SW4;
                    end
                    else begin
                        current_state <= `SW6;
                    end
                end
                `SW6: begin
                    if (direction == `RIGHT) begin
                        current_state <= `SW5;
                    end
                    else begin
                        current_state <= `SW7;
                    end
                end
                `SW7: begin //if at LED7 (leftmost LED), move to the right
                    current_state <= `SW6;
                    direction <= `RIGHT;
                end
                default: begin //default start at LED2, it is the expected behaviour from the solution .sof given to us
                    current_state <= `SW2;
                    direction <= `RIGHT;
                end	
            endcase
        end
    end


    //Output logic - turn on or off the LEDs (logic is one hot code)
    always_comb begin
        case (current_state)
            `SW0: out = `SW0_out;
            `SW1: out = `SW1_out;
            `SW2: out = `SW2_out;
            `SW3: out = `SW3_out;
            `SW4: out = `SW4_out;
            `SW5: out = `SW5_out;
            `SW6: out = `SW6_out;
            `SW7: out = `SW7_out;
            default: out = `SW2_out;
        endcase
    end
endmodule