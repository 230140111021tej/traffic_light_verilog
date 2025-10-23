//testbench
`include "traffic.v"
module tb1;
reg clock,in;
wire [2:0]hwy; wire[2:0]normal;
trafficlight DUT(clock,in,hwy,normal);
always #10 clock = ~clock;
initial
begin
$dumpfile("traffic.vcd");
$dumpvars(0,tb1);
$monitor ($time,"clock=%b,in=%b,hwy=%b,normal=%b",clock,in,hwy,normal);
clock =1'b0; in=1'b0;
#50 in = 1'b1;
#100 in = 1'b0;
#160 in = 1'b1;
#30 in=1'b0;
#30 $finish;
end
endmodule
