
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE10_LITE_Golden_Top(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		     [3:0]		VGA_B,
	output		     [3:0]		VGA_G,
	output		          		VGA_HS,
	output		     [3:0]		VGA_R,
	output		          		VGA_VS,

	//////////// Accelerometer //////////
	output		          		GSENSOR_CS_N,
	input 		     [2:1]		GSENSOR_INT,
	output		          		GSENSOR_SCLK,
	inout 		          		GSENSOR_SDI,
	inout 		          		GSENSOR_SDO,

	//////////// Arduino //////////
	inout 		    [15:0]		ARDUINO_IO,
	inout 		          		ARDUINO_RESET_N,

	//////////// GPIO, GPIO connect to GPIO Default //////////
	inout 		    [35:0]		GPIO,
	
	
	
	//debug- these are temporary outputs for the waveflow.
	//debug state machine
	output tempCarryOverOut,
	output [31:0] tempCountOut,
	
	//debug sec increase
	output [5:0] tempSecOut,
	output tempcarryoversec,
	
	//debug min increase
	output [5:0] tempMinOut,
	output tempcarryoverMin,
	
	//debug hour increase
	output [4:0] tempHourOut
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

//CarryOver wire from the state machine. Whenever it finishes a cycle, carryOver==1.
wire carryOver;

//Wire for seconds
wire [5:0] SecWire;

//Wire for carryover seconds, forward to minutes.
wire carryOverSec;

//wire for minutes
wire [5:0] MinWire;

//wire for carryover minutes, forward to hours.
wire carryOverMin;

//Wire for hours
wire [4:0] HourWire;

//temporary count wire for debug.
wire [31:0] tempCountWire;

//=======================================================
//  Structural coding
//=======================================================

//Notes: after turnning back on enable there is a delay of 1 cycle. need to check it.	
StateMachine sm(.clk(MAX10_CLK1_50), .resetN(KEY[0]), .enable(SW[0]), .cnt(tempCountWire),.ovflw(carryOver));


//Sec increase
SecIncrease SecIn(.CarryInSec(carryOver), .OutSec(SecWire), .ovflwSec(carryOverSec));

//Min increase
MinIncrease MinIn(.CarryInMin(carryOverSec), .OutMin(MinWire), .ovflwMin(carryOverMin));

//Hour Increase
HourIncrease HourIn(.CarryInHour(carryOverMin), .OutHour(HourWire));


//HEXDRV HEXDRV0(.switch(SecWire[3:0]),.segments(HEX0));


//debugging the outputs
assign tempCarryOverOut = carryOver;
assign tempCountOut = tempCountWire;
assign tempSecOut = SecWire;
assign tempcarryoversec = carryOverSec;
assign tempMinOut = MinWire;
assign tempcarryoverMin = carryOverMin;
assign tempHourOut = HourWire;

//assign LEDR[0] = ~(SW[0] & SW[1]);
//assign LEDR[1] = ~KEY[0] | ~KEY[1] ;

//HEXDRV HEXDRV1 (.switch(SW[9:6]),.segments(HEX5));

//HEXDRV HEXDRV2 (.switch(SW[5:2]),.segments(HEX0));


endmodule