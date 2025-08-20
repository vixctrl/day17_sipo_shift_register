// ---------------------------------------------
// 4-bit Serial-In Parallel-Out (SIPO) Register
// ---------------------------------------------
module sipo #(
    parameter WIDTH = 4              // Parallel width (default 4)
)(
    input  logic              clk,        // Clock
    input  logic              rst_n,      // Active-low reset
    input  logic              serial_in,  // Serial input bit
    output logic [WIDTH-1:0]  q           // Parallel output
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= '0;                              // Clear all bits on reset
        else
            q <= {q[WIDTH-2:0], serial_in};       // Shift-left; bring in serial_in
    end

endmodule
