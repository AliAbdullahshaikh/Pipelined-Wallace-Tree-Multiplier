////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   07/05/2024 
// Module  Name:   Pipelined_Wallace_Tree
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module pipelined_wallace_tree_tb;
    reg [3:0] a;
    reg [3:0] b;
    reg clk;
    wire [7:0] result;

    pipelined_wallace_tree uut (
        .a(a), 
        .b(b), 
        .clk(clk), 
        .result(result)
    );

    // Clock Generation (10ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    // Waveform Generation for EDA Playground
    initial begin
        $dumpfile("pipelined.vcd");
        $dumpvars(0, pipelined_wallace_tree_tb);
    end

    initial begin
        // Print in Decimal so you can verify the math instantly
        $monitor("Time=%0t | a=%d, b=%d | result=%d", $time, a, b, result);
        
        a = 0; b = 0;
        
        // Feed data on the negedge to ensure it is stable for the posedge
        @(negedge clk); a=4'd12; b=4'd1;  // Expected: 12
        @(negedge clk); a=4'd11; b=4'd2;  // Expected: 22
        @(negedge clk); a=4'd10; b=4'd3;  // Expected: 30
        @(negedge clk); a=4'd9;  b=4'd4;  // Expected: 36
        @(negedge clk); a=4'd8;  b=4'd5;  // Expected: 40
        @(negedge clk); a=4'd7;  b=4'd6;  // Expected: 42

        // Wait for the 3-stage pipeline to flush
        #50;
        $finish;
    end
endmodule