module Synchronizer(input logic async_in, clk_in, reset,
					output logic sync_out);

    logic sync_level_1, sync_level_2, sync_level_3;
	
    always_ff @(posedge clk_in, posedge reset) begin
        if (reset) begin
            sync_level_1 <= 1'b0;
            sync_level_2 <= 1'b0;
			sync_level_3 <= 1'b0;
            sync_out <= 1'b0;
        end else begin
            sync_level_1 <= async_in;
            sync_level_2 <= sync_level_1;
			sync_level_3 <= sync_level_2;
            sync_out <= sync_level_2 & ~sync_level_3; //Rising edge detection
        end
    end
endmodule