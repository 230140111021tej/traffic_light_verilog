// Purpose: Testbench for the Traffic Light Controller FSM in Verilog.
//          Simulates different car arrival patterns and monitors light outputs.


`include "traffic.v"

module tb1;
    reg clock, in;                  // clock: simulation clock, in: car arrival
    wire [2:0] hwy;                 // highway lights
    wire [2:0] normal;              // normal road lights

    // Instantiate DUT
    trafficlight DUT(clock, in, hwy, normal);

    // Generate clock pulse every 10 time units
    always #10 clock = ~clock;

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb1);

        $monitor($time, " clock=%b, in=%b, hwy=%b, normal=%b", clock, in, hwy, normal);

        // Initial conditions
        clock = 1'b0; in = 1'b0;

        // Stimulus: simulate car arrival and departures at various intervals
        #50  in = 1'b1;    // Car arrives on normal road
        #100 in = 1'b0;    // Car departs
        #160 in = 1'b1;    // Another car arrives
        #30  in = 1'b0;    // Car departs
        #30  $finish;      // End simulation
    end
endmodule
