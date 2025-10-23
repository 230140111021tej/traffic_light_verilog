module trafficlight(clock,in,hwy,normal);
input clock,in;
output reg [2:0]hwy; 
output reg [2:0]normal;
parameter s0 = 3'd0, s1 = 3'd1, s2 = 3'd2, s3 = 3'd3, s4 = 3'd4;
parameter red=3'b100, green=3'b010, yellow=3'b001;
reg [2:0] state;
initial state = s0;
always @ (posedge clock)
case (state)
s0: if(in) state <= s1; else state <= s0;  // stay if no car
s1: state <= s2;
s2: state <= s3;
s3: if(in) state <= s3; else state <= s4;  // stay if more cars
s4: state <= s0;default: state <= s0;
endcase
always @(state)
case(state)
s0: begin hwy <= green;  normal <= red;    end
s1: begin hwy <= yellow; normal <= red;    end
s2: begin hwy <= red;    normal <= red;    end
s3: begin hwy <= red;    normal <= green;  end
s4: begin hwy <= red;    normal <= yellow; end
default: begin hwy <= green; normal <= red; end
endcase
endmodule
