////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   04/05/2024 
// Module  Name:   Full Adder Testbench
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module full_adder_tb;
	
	// Inputs
	reg A;
	reg B;
	reg Cin;
	
	// Outputs
	wire S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.S(S), 
		.Cout(Cout)
	);
  	
  	// Waveform Generation for EDA Playground
  	initial begin
      $dumpfile("fa.vcd");
      $dumpvars(0, full_adder_tb);
  	end

	initial begin
      	$monitor($time,"A=%b,B=%b,Cin=%b,S=%b,Cout=%b",A,B,Cin,S,Cout);
		// Initialize Inputs
		A=1'b0;B=1'b0;Cin=1'b0;    //Result = 00
      	#2;A=1'b0;B=1'b0;Cin=1'b1; //Result = 01
		#2;A=1'b0;B=1'b1;Cin=1'b0; //Result = 01
      	#2;A=1'b0;B=1'b1;Cin=1'b1; //Result = 10
      	#2;A=1'b1;B=1'b0;Cin=1'b0; //Result = 01
      	#2;A=1'b1;B=1'b0;Cin=1'b1; //Result = 10
      	#2;A=1'b1;B=1'b1;Cin=1'b0; //Result = 10
      	#2;A=1'b1;B=1'b1;Cin=1'b1; //Result = 11
      	#10;
      	$finish;
	end
endmodule