////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   03/05/2024 
// Module  Name:   Half Adder
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module half_adder(
    input a,
    input b,
    output sum,
    output cout
    );

assign {cout,sum} = a+b;

endmodule
