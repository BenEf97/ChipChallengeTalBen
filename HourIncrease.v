module HourIncrease(CarryInHour, OutHour);
input CarryInHour;
output [4:0] OutHour;
//output reg ovflwHour;

reg [4:0] counter;


always @(posedge CarryInHour) begin
    if (counter == 23) begin
        counter <= 0;
        //ovflwHour <= 1;
    end else begin
        counter <= counter + 1;
        //ovflwHour <= 0;
    end
end

assign OutHour = counter;

endmodule