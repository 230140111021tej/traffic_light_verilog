// Traffic light controller using FSM
// Highway gets priority unless car is present on normal road

module trafficlight(clock, in, hwy, normal);
    input clock, in;            // clock input, in = car on normal road
    output reg [2:0] hwy;       // highway lights [red, green, yellow]
    output reg [2:0] normal;    // normal road lights [red, green, yellow]

    // FSM states
    parameter s0 = 3'd0,        // highway green
              s1 = 3'd1,        // highway yellow
              s2 = 3'd2,        // both red
              s3 = 3'd3,        // normal road green
              s4 = 3'd4;        // normal road yellow

    // light codes
    parameter red    = 3'b100,
              green  = 3'b010,
              yellow = 3'b001;

    reg [2:0] state;            // current state

    initial state = s0;         // start with highway green

    // state change on clock
    always @(posedge clock)
        case (state)
            s0: if (in) state <= s1; else state <= s0;
            s1: state <= s2;
            s2: state <= s3;
            s3: if (in) state <= s3; else state <= s4;
            s4: state <= s0;
            default: state <= s0;
        endcase

    // output lights based on state
    always @(state)
        case (state)
            s0: begin hwy <= green;  normal <= red;    end
            s1: begin hwy <= yellow; normal <= red;    end
            s2: begin hwy <= red;    normal <= red;    end
            s3: begin hwy <= red;    normal <= green;  end
            s4: begin hwy <= red;    normal <= yellow; end
            default: begin hwy <= green; normal <= red; end
        endcase
endmodule
