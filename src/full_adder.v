////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   03/05/2024 
// Module  Name:   Full Adder
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module full_adder(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );

    assign {Cout,S} = A+B+Cin;

endmodule
