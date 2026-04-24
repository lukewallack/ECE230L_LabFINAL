module full_adder(
    input A, B,
    input Cin, // Carry in
    output Y,
    output Cout // Carry out
);

    assign Y = A ^ B ^ Cin;
    assign Cout = (B & Cin) | (A & Cin) | (A & B);

endmodule
