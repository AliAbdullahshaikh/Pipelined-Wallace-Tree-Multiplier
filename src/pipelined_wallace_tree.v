////////////////////////////////////////////////////////////////////////////
// Creator Name:   Ali Abdullah 
// Create  Date:   07/05/2024 
// Module  Name:   Pipelined_Wallace_Tree
// Project Name:   Pipelined-Wallace-Tree-Multiplier
// Description:    
////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module pipelined_wallace_tree(
    input clk,
    input [3:0] a,
    input [3:0] b,
    output reg [7:0] result
);

    // ADD THESE REGISTERS
    reg [3:0] a_reg, b_reg;
    always @(posedge clk) begin
        a_reg <= a; 
        b_reg <= b;
    end	

    // ==========================================
    // Partial Product Generation
    // ==========================================
    wire [3:0] P [3:0];
    assign P[0] = {4{a_reg[0]}} & b_reg;
    assign P[1] = {4{a_reg[1]}} & b_reg;
    assign P[2] = {4{a_reg[2]}} & b_reg;
    assign P[3] = {4{a_reg[3]}} & b_reg;

    // ==========================================
    // STAGE 1 (Combinational Logic + Registers)
    // ==========================================
    wire s0, c0, s1, c1, s2, c2, s3, c3;
    
    // HA 1
    assign {c0, s0} = P[0][1] + P[1][0];
    // FA 1
    assign {c1, s1} = P[0][2] + P[1][1] + P[2][0];
    // FA 2
    assign {c2, s2} = P[0][3] + P[1][2] + P[2][1];
    // HA 2
    assign {c3, s3} = P[1][3] + P[2][2];

    // Pipeline Registers for Stage 1
    reg r_s0, r_c0, r_s1, r_c1, r_s2, r_c2, r_s3, r_c3;
    reg r_P00, r_P30, r_P31, r_P32, r_P23, r_P33;

    always @(posedge clk) begin
        r_s0 <= s0;   r_c0 <= c0;
        r_s1 <= s1;   r_c1 <= c1;
        r_s2 <= s2;   r_c2 <= c2;
        r_s3 <= s3;   r_c3 <= c3;
        r_P00 <= P[0][0];
        r_P30 <= P[3][0]; r_P31 <= P[3][1]; r_P32 <= P[3][2];
        r_P23 <= P[2][3]; r_P33 <= P[3][3];
    end

    // ==========================================
    // STAGE 2 (Combinational Logic + Registers)
    // ==========================================
    wire s4, c4, s5, c5, s6, c6, s7, c7;
    
    // HA 3
    assign {c4, s4} = r_c0 + r_s1;
    // FA 3
    assign {c5, s5} = r_c1 + r_s2 + r_P30;
    // FA 4
    assign {c6, s6} = r_c2 + r_s3 + r_P31;
    // FA 5
    assign {c7, s7} = r_c3 + r_P23 + r_P32;

    // Pipeline Registers for Stage 2
    reg r2_s0, r2_s4;
    reg r2_s5, r2_c4;
    reg r2_s6, r2_c5;
    reg r2_s7, r2_c6;
    reg r2_P00, r2_P33, r2_c7;

    always @(posedge clk) begin
        r2_s0 <= r_s0;
        r2_s4 <= s4;
        r2_s5 <= s5; r2_c4 <= c4;
        r2_s6 <= s6; r2_c5 <= c5;
        r2_s7 <= s7; r2_c6 <= c6;
        r2_P00 <= r_P00;
        r2_P33 <= r_P33; r2_c7 <= c7;
    end

    // ==========================================
    // STAGE 3 (Combinational Logic + Final Output)
    // ==========================================
    wire s8, c8, s9, c9, s10, c10, s11, c11;
    
    // HA 4
    assign {c8, s8} = r2_c4 + r2_s5;
    // FA 6
    assign {c9, s9} = r2_c5 + r2_s6 + c8;
    // FA 7
    assign {c10, s10} = r2_c6 + r2_s7 + c9;
    // FA 8
    assign {c11, s11} = r2_c7 + r2_P33 + c10;

    // Final Result Register
    always @(posedge clk) begin
        result <= {c11, s11, s10, s9, s8, r2_s4, r2_s0, r2_P00};
    end

endmodule
