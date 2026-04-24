//StopWatch: Modulo-60 Counter
//Counts from 0 upto 59, resets to 0 after 59
module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state     //6-bits to represent the highest number 59
);

/////////////////////////// (Luke) /////////////////////////////////////////
// TODO: MISSING EN IMPLEMENTATION. EN SHOULD WORK AS FOLLOWS:
// en=1: nextState = currentState + 1 (count)
// en=0: nextState = currentState (pause)
// Also important note: sw[0] determines what mode is currently running:
// sw[0]=0: stopwatch, sw[0]=1: timer
// sw[1] is used exclusively in stopwatch as a run/pause (1/0 enable signal)
////////////////////////////////////////////////////////////////////////////

//bit 0
wire D0;
wire Cout0;

dff dff0(
    .D(D0),
    .Clk(Clk),
    .Q(Bit0),
    .Reset(rst)
);

full_adder fa0(
    .B(en), // incorrect?
    .A(Bit0),
    .Cin(1'b0),
    .Y(D0),
    .Cout(Cout0)
);


//bit 1
wire D1;
wire Cout1;

dff dff1(
    .D(D1),
    .Clk(Clk),
    .Q(Bit1),
    .Reset(rst)
);

full_adder fa1(
    .B(1'b0),
    .A(Bit1),
    .Cin(Cout0),
    .Y(D1),
    .Cout(Cout1)
);


//bit 2
wire D2;
wire Cout2;

dff dff2(
    .D(D2),
    .Clk(Clk),
    .Q(Bit2),
    .Reset(rst)
);

full_adder fa2(
    .B(1'b0),
    .A(Bit2),
    .Cin(Cout1),
    .Y(D2),
    .Cout(Cout2)
);


//bit 3
wire D3;
wire Cout3;

dff dff3(
    .D(D3),
    .Clk(Clk),
    .Q(Bit3),
    .Reset(rst)
);

full_adder fa3(
    .B(1'b0),
    .A(Bit3),
    .Cin(Cout2),
    .Y(D3),
    .Cout(Cout3)
);


//bit 4
wire D4;
wire Cout4;

dff dff4(
    .D(D4),
    .Clk(Clk),
    .Q(Bit4),
    .Reset(rst)
);

full_adder fa4(
    .B(1'b0),
    .A(Bit4),
    .Cin(Cout3),
    .Y(D4),
    .Cout(Cout4)
);


//bit 5
wire D5;

dff dff5(
    .D(D5),
    .Clk(Clk),
    .Q(Bit5),
    .Reset(rst)
);

full_adder fa5(
    .B(1'b0),
    .A(Bit5),
    .Cin(Cout4),
    .Y(D5)
);
   
endmodule