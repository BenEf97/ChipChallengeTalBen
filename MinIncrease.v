module MinIncrease(CarryInMin, OutMin, ovflwMin);
input CarryInMin;
output [5:0] OutMin;
output reg ovflwMin;

reg [5:0] counter;
//reg ovflwMin;

always @(posedge CarryInMin) begin
    if (counter == 59) begin
        counter <= 0;
        ovflwMin <= 1;
    end else begin
        counter <= counter + 1;
        ovflwMin <= 0;
    end
end

assign OutMin = counter;

endmodule