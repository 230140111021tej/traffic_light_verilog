module trafficlight(clock, in, hwy, normal);
    input clock, in;                // clock: system clock, in: car present on normal road
    output reg [2:0] hwy;           // hwy: traffic lights for highway [red, green, yellow]
    output reg [2:0] normal;        // normal: traffic lights for normal road [red, green, yellow]

    // State encoding
    parameter s0 = 3'd0,            // Highway green, normal red (default)
              s1 = 3'd1,            // Highway yellow, normal red (transition)
              s2 = 3'd2,            // Both red (all stop)
              s3 = 3'd3,            // Highway red, normal green (normal road flow)
              s4 = 3'd4;            // Highway red, normal yellow (transition)

    // Light encoding
    parameter red    = 3'b100,      // Red light
              green  = 3'b010,      // Green light
              yellow = 3'b001;      // Yellow light

    reg [2:0] state;                // Current state variable

    initial state = s0;             // Initial state: highway green, normal red

    // State transition logic (on clock edge)
    always @ (posedge clock)
        case (state)
            s0: if (in) state <= s1; else state <= s0;     // Wait for car on normal road
            s1: state <= s2;                               // Transition to all red
            s2: state <= s3;                               // Transition to normal green
            s3: if (in) state <= s3; else state <= s4;     // Stay green if more cars
            s4: state <= s0;                               // Transition back to highway green
            default: state <= s0;                          // Default to initial state
        endcase

    // Output logic based on state
    always @(state)
        case (state)
            s0: begin hwy <= green;  normal <= red;    end // Highway go, normal stop
            s1: begin hwy <= yellow; normal <= red;    end // Highway slow, normal stop
            s2: begin hwy <= red;    normal <= red;    end // All stop
            s3: begin hwy <= red;    normal <= green;  end // Highway stop, normal go
            s4: begin hwy <= red;    normal <= yellow; end // Highway stop, normal slow
            default: begin hwy <= green; normal <= red; end
        endcase
endmodule
