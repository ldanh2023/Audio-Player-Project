//Stop and start music
`define STOP_MUSIC 1'b0
`define PLAY_MUSIC 1'b1

//Playback mode
`define FORWARD 1'b0
`define BACKWARD 1'b1

//Max address
`define MAX_ADDRESS 23'h7FFFF


//Handles reading from flash memory and outputting audio data
module Flash_FSM_Controller(
    //Clock and reset
    input logic clk_in, //50MHz system clock
    input logic reset, //Active high reset

    //Async signal (synchronized in top module)
    input logic clk_async,

    //Control inputs
    input logic play_enable, //Play or stop
    input logic direction, //Forward or backward playback
    input logic restart, //Restart playback
    output logic restart_start_protocol, //Uses the Start-Finish protocol taught in class

    //Flash memory interface
    input logic flash_mem_waitrequest,
    input logic flash_mem_readdatavalid,
    input logic [31:0] flash_mem_readdata,
    output logic flash_mem_read,
    output logic [22:0] flash_mem_address,

    //Audio output
    output logic [7:0] audio_out
);

    //Define state encoding
    parameter IDLE = 3'b000;
    parameter ADDRESS = 3'b001;
    parameter WAIT_VALID = 3'b010;
    parameter OUTPUT1 = 3'b011;
    parameter OUTPUT2 = 3'b100;
    parameter OUTPUT3 = 3'b101;
    parameter OUTPUT4 = 3'b110;

    //State register
    logic [2:0] state;

    //Data output register
    logic [31:0] data_out;

    //Address register
    logic [22:0] current_address;

    //Direction register
    logic current_direction;


    always_ff @(posedge clk_in, posedge reset) begin
        if (reset) begin
            state <= IDLE;

            data_out <= 32'h0;
            current_address <= 23'h0;

            flash_mem_read <= 1'b0;
            flash_mem_address <= 23'h0;
            audio_out <= 8'h00;

            restart_start_protocol <= 1'b0;
        end else begin
            restart_start_protocol <= 1'b0;

            case(state)
                IDLE: begin
                    if (restart) begin //if R key pressed, go to start of song
                        current_address <= 23'h0;
                        restart_start_protocol <= 1'b1;
                    end

                    if ((play_enable == `PLAY_MUSIC) && clk_async) begin //on next clock edge (audio clock, not the 50MHz one), go to next state
                        current_direction <= direction;

                        state <= ADDRESS;
                        flash_mem_read <= 1'b1; //set read signal
                        flash_mem_address <= current_address; //send address to read from
                    end
                end
                ADDRESS: begin
                    if (~flash_mem_waitrequest) begin //wait until flash_mem_waitrequest is deasserted
                        state <= WAIT_VALID;
                        flash_mem_read <= 1'b0;
                    end
                end
                WAIT_VALID: begin
                    if (flash_mem_readdatavalid) begin //if read is valid, can read new data
                        data_out <= flash_mem_readdata;
                        state <= OUTPUT1;
                    end
                end
                OUTPUT1: begin
                    if (current_direction == `BACKWARD) begin
                        audio_out <= data_out[31:24]; //Output upper 16 bits of sample
                    end
                    else begin
                        audio_out <= data_out[7:0]; //Output lower 16 bits of sample
                    end

                    if ((play_enable == `PLAY_MUSIC) && clk_async) begin //Output not at 50MHz, but audio clock
                        state <= OUTPUT2;
                    end
                end
                OUTPUT2: begin
                    if (current_direction == `BACKWARD) begin
                        audio_out <= data_out[23:16]; //Output middle 16 bits of sample
                    end
                    else begin
                        audio_out <= data_out[15:8]; //Output middle 16 bits of sample
                    end

                    if ((play_enable == `PLAY_MUSIC) && clk_async) begin //Output not at 50MHz, but audio clock
                        state <= OUTPUT3;
                    end
                end
                OUTPUT3: begin
                    if (current_direction == `BACKWARD) begin
                        audio_out <= data_out[15:8]; //Output middle 16 bits of sample
                    end
                    else begin
                        audio_out <= data_out[23:16]; //Output middle 16 bits of sample
                    end

                    if ((play_enable == `PLAY_MUSIC) && clk_async) begin //Output not at 50MHz, but audio clock
                        state <= OUTPUT4;
                    end
                end
                OUTPUT4: begin
                    if (current_direction == `BACKWARD) begin
                        audio_out <= data_out[7:0]; //Output lower 16 bits of sample
                    end else begin
                        audio_out <= data_out[31:24]; //Output upper 16 bits of sample
                    end


                    if (current_direction == `FORWARD) begin
                        if (current_address < `MAX_ADDRESS) begin //Total number of samples is 23'h7FFFF
                            current_address <= current_address + 1;
                        end else begin
                            current_address <= 23'h0; //Wrap around to start
                        end
                    end else begin
                        if (current_address > 0) begin
                            current_address <= current_address - 1;
                        end else begin
                            current_address <= `MAX_ADDRESS; //Wrap around to end
                        end
                    end

                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule