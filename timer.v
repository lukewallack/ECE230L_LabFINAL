//Timer: Mod-60 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state      //6-bits to represent the highest number 59
);

// The timer can count when load is 0, rst is 0, en is 1, and state is not 0.
wire canCount = en & ~rst & ~load & ~(~state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5]);

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



/// COUNTING CIRCUIT ///

//bit 0
wire D0;
wire Cout0;

dff dff0(
    .D(loadMuxOut[0]),
    .clk(clk),
    .Q(state[0]),
    .rst(rst)
);

full_adder fa0(
    .B(canCount),
    .A(state[0]),
    .Cin(1'b0),
    .Y(nextState[0]),
    .Cout(Cout0)
);


//bit 1
wire Cout1;

dff dff1(
    .D(loadMuxOut[1]),
    .clk(clk),
    .Q(state[1]),
    .rst(rst)
);

full_adder fa1(
    .B(canCount),
    .A(state[1]),
    .Cin(Cout0),
    .Y(nextState[1]),
    .Cout(Cout1)
);


//bit 2
wire Cout2;

dff dff2(
    .D(loadMuxOut[2]),
    .clk(clk),
    .Q(state[2]),
    .rst(rst)
);

full_adder fa2(
    .B(canCount),
    .A(state[2]),
    .Cin(Cout1),
    .Y(nextState[2]),
    .Cout(Cout2)
);


//bit 3
wire Cout3;

dff dff3(
    .D(loadMuxOut[3]),
    .clk(clk),
    .Q(state[3]),
    .rst(rst)
);

full_adder fa3(
    .B(canCount),
    .A(state[3]),
    .Cin(Cout2),
    .Y(nextState[3]),
    .Cout(Cout3)
);


//bit 4
wire Cout4;

dff dff4(
    .D(loadMuxOut[4]),
    .clk(clk),
    .Q(state[4]),
    .rst(rst)
);

full_adder fa4(
    .B(canCount),
    .A(state[4]),
    .Cin(Cout3),
    .Y(nextState[4]),
    .Cout(Cout4)
);


//bit 5
dff dff5(
    .D(loadMuxOut[5]),
    .clk(clk),
    .Q(state[5]),
    .rst(rst)
);

full_adder fa5(
    .B(canCount),
    .A(state[5]),
    .Cin(Cout4),
    .Y(nextState[5])
);

endmodule