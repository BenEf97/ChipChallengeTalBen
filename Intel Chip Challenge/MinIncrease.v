module MinIncrease(CarryInMin,resetN, OutMin, ovflwMin);
input CarryInMin, resetN;
output [5:0] OutMin;
output reg ovflwMin;

reg [5:0] counter;

always @(posedge CarryInMin or negedge resetN) begin
	     // Asynchronous process, resetN==0:
    if (!resetN) begin
		  //resets the counter, reset overflow output.
        counter <= 0;
        ovflwMin <= 0;
    end
	else if (counter == 59) begin
        counter <= 0;
        ovflwMin <= 1;
    end else begin
        counter <= counter + 1;
        ovflwMin <= 0;
    end
end

assign OutMin = counter;

endmodule