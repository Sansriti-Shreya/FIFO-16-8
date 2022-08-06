module vending_machine_tb();

reg clk,rst;
reg [1:0]coin;
wire product,change;

parameter IDLE = 2'b00,
            S1 = 2'b01,
            S2 = 2'b10,
			T  = 10;
			
vending_machine DUT(clk,rst,coin,product,change);

initial 
  begin
   clk = 1'b0;  
//initialized clock to 0 at time = 0 
   forever #(T/2) clk = ~clk;
// toggle after time 5 units as T=10
 end
  

task initialise;
  begin
	coin = 2'b00;
	#T;
  end
endtask

//initialise task for reset

task reset;
  begin
    rst = 1'b1;
	#T;
//10 units delay
    rst = 1'b0;
  end
endtask			

//initialise task for stimulus

task stimulus(input [1:0]p);
  begin
    @(negedge clk);
	coin = p;
  end
endtask

initial
 begin
 initialise;
 reset;
  repeat(12)
   stimulus({$random}%4); 
   #T;
 end
 
initial $monitor($time,"rst=%b,clk=%b,coin=%b,product=%b,change=%b",rst,clk,coin,product,change);
initial #200 $finish;

endmodule 
