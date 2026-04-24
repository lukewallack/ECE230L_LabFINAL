module mux_2to1(
    input sel,      // 1-bit select input
    input [5:0] A,  // 6-bit data input 0
    input [5:0] B,  // 6-bit data input 1
    output [5:0] Y  // 6-bit data output
);

// Assign Y as B if sel == 1, otherwise A
assign Y = sel ? B : A;

endmodule
