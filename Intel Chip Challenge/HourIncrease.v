module HourIncrease(CarryInHour, resetN, OutHour);
input CarryInHour, resetN;
output [4:0] OutHour;

reg [4:0] counter;


always @(posedge CarryInHour or negedge resetN) begin

	     // Asynchronous process, resetN==0:
    if (!resetN) begin
		  //resets the counter, reset overflow output.
        counter <= 0;
	end
    else if (counter == 23) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end
end

assign OutHour = counter;

endmodule