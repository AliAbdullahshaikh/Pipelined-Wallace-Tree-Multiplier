////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   06/05/2024 
// Module  Name:   Unpipelined_Wallace_Tree
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
// ==========================================
// Basic Building Blocks Half & Full Adder   
// ==========================================
module HA(input a_HA, b_HA, output sum_HA, carry_out_HA);
	assign sum_HA = a_HA ^ b_HA; 
	assign carry_out_HA = a_HA & b_HA; 
endmodule

module FA(input a_FA, b_FA, c_FA, output sum_FA, carry_out_FA);
	assign sum_FA = a_FA ^ b_FA ^ c_FA; 
	assign carry_out_FA = ((a_FA ^ b_FA) & c_FA) | (a_FA & b_FA); 
endmodule

// ============================================
// Unpipelined 4-bit Wallace Tree Multiplier
// ============================================
module unpipelined_wallace_tree_multiplier(
    input clk,                // ADDED for timing analysis
    input rst,                // ADDED for timing analysis
    input [3:0] a, 
    input [3:0] b, 
    output reg [7:0] result   // Changed to 'reg' to register the output
);

	// ADD THESE REGISTERS
    	reg [3:0] a_reg, b_reg;
	always @(posedge clk) begin
        	a_reg <= a; 
        	b_reg <= b;
    	end	

	reg [3:0] P[3:0];
	wire [11:0] s;
	wire [11:0] c;	
	integer i, j;
    	wire [7:0] result_comb; // Internal wire for the combinational result
	 
	 always @(*) begin
		for (i=0; i<4; i=i+1) begin
			for (j=0; j<4; j=j+1) begin
				P[i][j] = a_reg[i] & b_reg[j]; 
			end
		end
	 end
	 
	 //Stage 1
	 HA HA_1(.a_HA(P[0][1]), .b_HA(P[1][0]), .sum_HA(s[0]),  .carry_out_HA(c[0])); 
	 FA FA_1(.a_FA(P[0][2]), .b_FA(P[1][1]), .c_FA(P[2][0]), .sum_FA(s[1]), .carry_out_FA(c[1])); 
	 FA FA_2(.a_FA(P[0][3]), .b_FA(P[1][2]), .c_FA(P[2][1]), .sum_FA(s[2]), .carry_out_FA(c[2])); 
	 HA HA_2(.a_HA(P[1][3]), .b_HA(P[2][2]), .sum_HA(s[3]),  .carry_out_HA(c[3])); 

	 //Stage 2
	 HA HA_3(.a_HA(c[0]), .b_HA(s[1]),    .sum_HA(s[4]),  .carry_out_HA(c[4])); 
	 FA FA_3(.a_FA(c[1]), .b_FA(s[2]),    .c_FA(P[3][0]), .sum_FA(s[5]), .carry_out_FA(c[5])); 
	 FA FA_4(.a_FA(c[2]), .b_FA(s[3]),    .c_FA(P[3][1]), .sum_FA(s[6]), .carry_out_FA(c[6])); 
	 FA FA_5(.a_FA(c[3]), .b_FA(P[2][3]), .c_FA(P[3][2]), .sum_FA(s[7]), .carry_out_FA(c[7])); 

     //Stage 3
	 HA HA_4(.a_HA(s[5]),    .b_HA(c[4]), .sum_HA(s[8]), .carry_out_HA(c[8])); 
	 FA FA_6(.a_FA(s[6]),    .b_FA(c[5]), .c_FA(c[8]),   .sum_FA(s[9]), .carry_out_FA(c[9])); 
	 FA FA_7(.a_FA(s[7]),    .b_FA(c[6]), .c_FA(c[9]),   .sum_FA(s[10]), .carry_out_FA(c[10])); 
	 FA FA_8(.a_FA(P[3][3]), .b_FA(c[7]), .c_FA(c[10]),  .sum_FA(s[11]), .carry_out_FA(c[11])); 
	 
     // Combinational result wire
	 assign result_comb = {c[11],s[11],s[10],s[9],s[8],s[4],s[0],P[0][0]};

     // Output Register (This gives ISE a destination to calculate the critical path)
     always @(posedge clk or posedge rst) begin
         if (rst) begin
             result <= 8'd0;
         end else begin
             result <= result_comb;
         end
     end

endmodule