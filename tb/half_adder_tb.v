////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   03/05/2024 
// Module  Name:   Half Adder Testbench
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module half_adder_tb;

	// Inputs
	reg a;
	reg b;

	// Outputs
	wire sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	half_adder uut (
		.a(a), 
		.b(b), 
		.sum(sum), 
		.cout(cout)
	);

  	// Waveform Generation for EDA Playground
  	initial begin
    	$dumpfile("ha.vcd");
    	$dumpvars(0, half_adder_tb);
  	end

	initial begin
		$monitor($time,"a=%b,b=%b,sum=%b,cout=%b",a,b,sum,cout);
		// Initialize Inputs
		a=1'b0;b=1'b0;
		#5;a=1'b1;b=1'b0;
      	#5;a=1'b0;b=1'b1;
      	#5;a=1'b1;b=1'b1;
    	#10;
    	$finish;
	end
      
endmodule
