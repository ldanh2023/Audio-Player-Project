//Music frequency
// `define MUSIC_FREQUENCY_DEFAULT 32'd1228 //for 16 bit samples at 22KHz
`define MUSIC_FREQUENCY_DEFAULT 32'd614 //Bonus: for 8 bit samples at 44KHz
`define MIN_FREQUENCY_COUNT 32'd1 //fastest frequency
`define MAX_FREQUENCY_COUNT 32'd4000 //slowest frequency
`define INCREMENT 32'd1 //Not specified in lab, value I chose to illustrate how the frequency changes dramatically


//Define default state
`define DEFAULT 1'b0 //default frequency is played
`define CUSTOM 1'b1 //custom frequency is played

module Frequency_Controller(clk_in, reset, speed_up_event, speed_down_event, speed_reset_event, freq_count);
    parameter N = 32;


    input logic clk_in, reset;
    input logic speed_up_event, speed_down_event, speed_reset_event; //Input logic for speed
    output logic [N-1:0] freq_count;


    logic custom_state; //needed to identify value of freq_count on startup because on startup value of freq_count is not initialized so need way to give it an initial frequency


    always_ff @(posedge clk_in, posedge reset) begin
        if (reset) begin
            freq_count <= `MUSIC_FREQUENCY_DEFAULT;
            custom_state <= `DEFAULT;
        end
        else begin
            if (speed_reset_event) begin //if speed reset, go to default freq_count
                freq_count <= `MUSIC_FREQUENCY_DEFAULT;
                custom_state <= `DEFAULT;
            end
            else if (speed_up_event) begin //if speed up event, subtract from freq_count (smaller count is faster)
                custom_state <= `CUSTOM;

                if (freq_count >= (`MIN_FREQUENCY_COUNT + `INCREMENT)) begin
                    freq_count <= freq_count - `INCREMENT;
                end
            end
            else if (speed_down_event) begin //if speed down event, add to freq_count (larger count is slower)
                custom_state <= `CUSTOM;

                if (freq_count <= (`MAX_FREQUENCY_COUNT - `INCREMENT)) begin
                    freq_count <= freq_count + `INCREMENT;
                end
            end
            else if (custom_state == `DEFAULT) begin //used mainly for startup and no key presses (registers initially contain 1'b0 value)
                freq_count <= `MUSIC_FREQUENCY_DEFAULT;
            end
        end
    end
endmodule