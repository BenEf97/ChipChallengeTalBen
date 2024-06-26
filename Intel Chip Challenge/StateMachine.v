module StateMachine(clk, resetN, enable, ovflw);
input clk, resetN, enable;
output reg ovflw;
// States definitions:
localparam IDLE = 0;
localparam CountUp = 1;
localparam OverFlow = 2;

// Seconds to count to:
localparam Sec_time = 50_000_000; //50Mhz clock

// Registers and counter:
reg [2:0] present_state, next_state;
reg [25:0] counter;


// Sequential block to define the state registers and the counter registers:
always @ (posedge clk or negedge resetN) begin


    // Asynchronous process, resetN==0:
    if (!resetN) begin
		  //returns to IDLE
        present_state <= IDLE;
		  //resets the counter, reset overflow output.
        counter <= 0;
        ovflw <= 0;
    end
    // Synchronous process, clock rise:
    else begin
        present_state <= next_state;
        if (enable)
            counter <= counter + 1;
        if (present_state == OverFlow) begin
            counter <= 0;
            ovflw <= 1;
        end else
            ovflw <= 0;
    end
end

// Combinational block to compute the next state:
always @* begin
    case (present_state)
        IDLE: begin
            if (enable)
                next_state = CountUp;
            else
                next_state = IDLE;
        end
        CountUp: begin
            if (enable) begin
                if (counter == Sec_time-1) // Count to 50 million
                    next_state = OverFlow;
                else
                    next_state = CountUp;
            end else
                next_state = IDLE;
        end
        OverFlow: begin
            if (enable)
                next_state = CountUp;
            else
                next_state = IDLE;
        end
    endcase
end

endmodule
