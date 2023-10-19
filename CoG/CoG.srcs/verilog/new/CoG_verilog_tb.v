`include "CoG.vhd"
//`include "type_package.vhd"
//set time to 1 us timesteps, and 1 ns precisions
`timescale 1us/1ns
 
module CoG_uvm_tb; 
//initilaizte signals for simujlation here 
reg r_CLOCK    = 1'b0;
reg [7:0] r_array_in [0:2][0:2][0:2]; //3D-array input
reg [255:0] r_CoG [0:2]; //Center of Gravity output

// Instantiate the Unit Under Test (UUT)
tutorial_led_blink UUT 
(
.i_clock(r_CLOCK),
.o_led_drive(w_LED_DRIVE)
);   
//switch clock every 20 us   
always #20 r_CLOCK <= !r_CLOCK;
     
initial begin //begin simulation here

#200000 // 0.2 seconds
r_array_in[0][0][0] <= 1; 

#200000 // 0.2 seconds
r_array_in[1][1][1] <= 2; 

#200000 // 0.2 seconds
r_array_in[2][2][2] <= 200; 
 
$display("Test Complete");
end
   
endmodule // tutorial_led_blink_tb