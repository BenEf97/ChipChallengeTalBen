module SecIncrease(CarryInSec,resetN, OutSec, ovflwSec);
input CarryInSec, resetN;
output [5:0] OutSec;
output reg ovflwSec;

reg [5:0] counter;

always @(posedge CarryInSec or negedge resetN) begin

		// Asynchronous process, resetN==0:
    if (!resetN) begin
		//resets the counter, reset overflow output.
        counter <= 0;
        ovflwSec <= 0;
	 end
	 
    else if (counter == 59) begin //Reached the limit, send the overflow as an output for the minute increase.
        counter <= 0;
        ovflwSec <= 1;
    end else begin
        counter <= counter + 1;
        ovflwSec <= 0;
    end
end

assign OutSec = counter;

endmodule