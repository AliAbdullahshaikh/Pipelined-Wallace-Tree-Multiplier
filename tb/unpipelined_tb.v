////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   06/05/2024 
// Module  Name:   Unpipelined_Wallace_Tree
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module unpipelined_tb;
    reg clk;
    reg rst;
    reg [3:0] a;
    reg [3:0] b;
    wire [7:0] result;

    unpipelined_wallace_tree_multiplier uut (
        .clk(clk), .rst(rst), .a(a), .b(b), .result(result)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("unpipe.vcd");
        $dumpvars(0, unpipelined_tb);
        
        rst = 1; a = 0; b = 0;
        #15; 
        rst = 0;
        
        #10; a = 4'd12; b = 4'd1; // 12
        #10; a = 4'd11; b = 4'd2; // 22
        #10; a = 4'd10; b = 4'd3; // 30
        #10; a = 4'd9;  b = 4'd4; // 36
        #10; a = 4'd8;  b = 4'd5; // 40
        #10; a = 4'd7;  b = 4'd6; // 42
        
        #50; $finish;
    end
endmodule