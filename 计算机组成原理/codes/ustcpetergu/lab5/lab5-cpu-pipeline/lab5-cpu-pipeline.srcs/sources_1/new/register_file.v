`timescale 1ns / 1ps
// regfile with debug port and fowarding -- write & read in same cycle
// 2020 COD Lab5
// ustcpetergu

module register_file
    #(parameter WIDTH = 32)
    (
        input clk,
        input [4:0]ra0,
        input [4:0]ra1,
        input [4:0]ra2,
        input [4:0]wa,
        input we,
        input [WIDTH-1:0]wd,
        output reg [WIDTH-1:0]rd0,
        output reg [WIDTH-1:0]rd1,
        output reg [WIDTH-1:0]rd2
    );

    reg [WIDTH-1:0]regfile[31:0];
    initial $readmemh("/home/petergu/MyHome/COD/lab4/regfile.dat", regfile);

    always @ (*) begin
        if (ra0 == 5'b0) rd0 = 0;
        else if (we & (ra0 == wa)) rd0 = wd;
        else rd0 = regfile[ra0];

        if (ra1 == 5'b0) rd1 = 0;
        else if (we & (ra1 == wa)) rd1 = wd;
        else rd1 = regfile[ra1];

        if (ra2 == 5'b0) rd2 = 0;
        else if (we & (ra2 == wa)) rd2 = wd;
        else rd2 = regfile[ra2];
    end

    always @ (posedge clk) begin
        if (we) begin
            if (wa != 5'b0) begin
                regfile[wa] <= wd;
            end
        end
    end

endmodule

