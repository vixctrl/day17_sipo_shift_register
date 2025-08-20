module sipo_tb;
    localparam int WIDTH = 8;

    logic clk, rst_n, shift_en, din;
    logic [WIDTH-1:0] q;

    sipo #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_en),
        .din(din),
        .q(q)
    );

    // 100 MHz clock (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    // Task: shift one byte MSB->LSB (so final q equals 'data')
    task automatic shift_msb_first(input logic [WIDTH-1:0] data);
        integer i;
        begin
            for (i = WIDTH-1; i >= 0; i = i - 1) begin
                @(posedge clk);
                shift_en <= 1'b1;
                din      <= data[i];
            end
            @(posedge clk);
            shift_en <= 1'b0;
        end
    endtask

    initial begin
        $dumpfile("waves/sipo_tb.vcd");
        $dumpvars(0, sipo_tb);

        // Reset
        rst_n    = 0;
        shift_en = 0;
        din      = 0;
        repeat (2) @(posedge clk);
        rst_n = 1;

        // Directed pattern
        logic [WIDTH-1:0] pat;
        pat = 8'b1010_1101;   // 0xAD
        shift_msb_first(pat);
        if (q !== pat) begin
            $display("ERROR: directed: q=%b expected=%b", q, pat);
            $finish(1);
        end

        // A few random patterns
        int i;
        for (i = 0; i < 20; i++) begin
            pat = $urandom();
            shift_msb_first(pat);
            if (q !== pat) begin
                $display("ERROR: rand %0d: q=%b expected=%b", i, q, pat);
                $finish(1);
            end
        end

        $display("All SIPO tests PASSED ✅");
        #10 $finish;
    end
endmodule
