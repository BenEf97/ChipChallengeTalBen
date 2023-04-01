module SecIncrease(CarryInSec, OutSec, ovflwSec);
input CarryInSec;
output [5:0] OutSec;
output reg ovflwSec;

reg [5:0] counter;
//reg ovflwSec;

always @(posedge CarryInSec) begin
    if (counter == 59) begin
        counter <= 0;
        ovflwSec <= 1;
    end else begin
        counter <= counter + 1;
        ovflwSec <= 0;
    end
end

assign OutSec = counter;

endmodule