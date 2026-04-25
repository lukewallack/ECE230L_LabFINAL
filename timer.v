//Timer: Mod-60 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state      //6-bits to represent the highest number 59
);

wire [5:0] nextState;
wire [5:0] enMuxOut;
mux_2to1 enableMux(
    .sel(en),
    .A(state),
    .B(nextState),
    .Y(enMuxOut)
);

wire [5:0] loadMuxOut;
mux_2to1 loadMux(
    .sel(load),
    .A(enMuxOut),
    .B(load_value),
    .Y(loadMuxOut)
);

wire lowerLimit = (~state[5]) & (~state[4]) & (~state[3]) & (~state[2]) & (~state[1]) & (~state[0]);

//bit 0
wire D0;
wire Cout0;

dff dff0(
    .D(D0),
    .clk(clk),
    .Q(state[0]),
    .rst(rst)
);

full_adder fa0(
    .B(en),
    .A(state[0]),
    .Cin(1'b0),
    .Y(D0),
    .Cout(Cout0)
);


//bit 1
wire D1;
wire Cout1;

dff dff1(
    .D(D1),
    .clk(clk),
    .Q(state[1]),
    .rst(rst)
);

full_adder fa1(
    .B(1'b0),
    .A(state[1]),
    .Cin(Cout0),
    .Y(D1),
    .Cout(Cout1)
);


//bit 2
wire D2;
wire Cout2;

dff dff2(
    .D(D2),
    .clk(clk),
    .Q(state[2]),
    .rst(rst)
);

full_adder fa2(
    .B(1'b0),
    .A(state[2]),
    .Cin(Cout1),
    .Y(D2),
    .Cout(Cout2)
);


//bit 3
wire D3;
wire Cout3;

dff dff3(
    .D(D3),
    .clk(clk),
    .Q(state[3]),
    .rst(rst)
);

full_adder fa3(
    .B(1'b0),
    .A(state[3]),
    .Cin(Cout2),
    .Y(D3),
    .Cout(Cout3)
);


//bit 4
wire D4;
wire Cout4;

dff dff4(
    .D(D4),
    .clk(clk),
    .Q(state[4]),
    .rst(rst)
);

full_adder fa4(
    .B(1'b0),
    .A(state[4]),
    .Cin(Cout3),
    .Y(D4),
    .Cout(Cout4)
);


//bit 5
wire D5;

dff dff5(
    .D(D5),
    .clk(clk),
    .Q(state[5]),
    .rst(rst)
);

full_adder fa5(
    .B(1'b0),
    .A(state[5]),
    .Cin(Cout4),
    .Y(D5)
);

endmodule