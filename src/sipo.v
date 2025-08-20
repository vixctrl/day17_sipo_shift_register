`timescale 1ns/1ps
// Day 17: Serial-In Parallel-Out (SIPO) Shift Register
// Shift left each clock when shift_en=1, insert 'din' at LSB.
// Feed bits MSB->LSB to reconstruct the original byte in 'q'.

module sipo #(
    parameter WIDTH = 8
)(
    input  logic              clk,
    input  logic              rst_n,     // active-low synchronous reset
    input  logic              shift_en,  // shift enable
    input  logic              din,       // serial input
    output logic [WIDTH-1:0]  q          // parallel output
);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= '0;
        end else if (shift_en) begin
            q <= {q[WIDTH-2:0], din};
        end
    end

endmodule
