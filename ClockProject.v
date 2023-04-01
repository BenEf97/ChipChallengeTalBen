module ClockProject (clk, resetN,StartN, outSec ,outMin, outHour);
	input clk, resetN,StartN;
	output [5:0] outSec; //0 to 60
	output [5:0] outMin; // 0 to 60
	output [4:0] outHour; //0 to 24

	
	//do to- try with assign, wires
	
	
//Define the 4 states of the Traffic lights. used as parameters.
localparam reset_state = 0; //00:00:00
localparam secProg_state = 1; //Progressing the seconds
localparam minProg_state = 2; //Progressing the minutes
localparam hourProg_state = 3; //Progressing 

//Define the clock cycles duration of each state.
<<<<<<< HEAD
localparam sec_timeP=5; //1 sec
//localparam min_timeP=sec_timeP*60; //1 min
//localparam hour_timeP=min_timeP*60; //1 hour

=======
//localparam sec_timeP=50_000_000; //1 sec
localparam sec_timeP=1; //1 sec
>>>>>>> Merge-attempt


//Define the state and counter variables.
integer present_state, next_state;
integer present_counter, next_counter; //Counter for the time period
wire  SecCounter,MinCounter, HourCounter; //Seperate counter


//Implementation of the asynchronous and the synchronous processes.
always @ (posedge clk or negedge resetN)
	begin 
	
	//asynchronous process, reset==0
	if (!resetN) begin
		present_state <=reset_state;
		present_counter <=0;
	end
	
	//synchronous process, clock rise
	else begin
	present_state <= next_state;
	present_counter <= next_counter;
	end
end



//Combinatorical logic to set the next state and next counter values
always 
	begin
	
	//Default values
	next_state= present_state;
	next_counter=present_counter +1;
	
	case (present_state)
	
		reset_state: begin
			if (StartN) begin
				next_counter = 0;
				next_state = secProg_state;
				//rD1 <= Din1;
				//rD2 <= Din2;
			end
		end
		secProg_state: begin
			if (next_counter>= sec_timeP) begin
				
				SecCounter = SecCounter+1; //Increase Sec counter until 60
				
				if(SecCounter>=60) begin 
					next_state = minProg_state; //Move to min progression state
					SecCounter=0;
				end
				
				next_counter = 0;
			end
		end
		minProg_state: begin
			MinCounter = MinCounter + 1;
			if (MinCounter >= 60) begin
				next_state= hourProg_state; //Move to hour
				MinCounter=0;
			end
			else begin
				next_state= secProg_state; //Move back to seconds
			end
		end
		hourProg_state: begin
			HourCounter = HourCounter + 1;
			if (HourCounter >= 24) begin
				next_state= reset_state;
			end
			else begin
				next_state= secProg_state;
			end
		end
	endcase
	end

	

//Combinatorical logic to set the output lights
always
	begin 
	
	case (present_state)
		
		reset_state: begin
			outSec = 0;
			outMin = 0;
			outHour =0;
		end
		
		secProg_state: begin //Increasing seconds
			
			outSec = SecCounter;
				
		end
		
		minProg_state: begin //Increasing minutes
			

			outMin=MinCounter;
	
		end
		
		hourProg_state: begin //Increasing hours
		
			outHour=HourCounter;

		end
	endcase
end

endmodule