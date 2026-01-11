// Testbench for traffic light controller
// Used to check FSM working with car input

`include "traffic.v"

module tb1;
    reg clock, in;              // clock and car input
    wire [2:0] hwy;             // highway lights
    wire [2:0] normal;          // normal road lights

    // DUT
    trafficlight DUT(clock, in, hwy, normal);

    // clock generation
    always #10 clock = ~clock;

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb1);

        $monitor($time, " clock=%b, in=%b, hwy=%b, normal=%b",
                 clock, in, hwy, normal);

        // initial values
        clock = 0;
        in = 0;

        // car comes on normal road
        #50  in = 1;
        #100 in = 0;

        // another car
        #160 in = 1;
        #30  in = 0;

        #30 $finish;
    end
endmodule
