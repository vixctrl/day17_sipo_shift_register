// ---------------------------------------------
// Testbench for 4-bit SIPO Shift Register
// ---------------------------------------------
`timescale 1ns/1ps

module tb_sipo;

    // Parameters
    localparam WIDTH = 4;

    // Testbench signals
    logic clk;
    logic rst_n;
    logic serial_in;
    logic [WIDTH-1:0] q;

    // DUT Instantiation
    sipo #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .q(q)
    );

    // Clock Generation: 10ns period
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $dumpfile("sipo.vcd");   // waveform file
        $dumpvars(0, tb_sipo);

        // Init
        clk = 0;
        rst_n = 0;
        serial_in = 0;

        // Reset
        #10;
        rst_n = 1;

        // Shift sequence: 1,0,1,1
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;

        // Few more cycles
        serial_in = 0; #40;

        $finish;
    end

endmodule
