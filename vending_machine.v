module vending_machine(input clk,rst,input [1:0]coin,output reg product,change);

//using mealy fsm using coding style 4
//defining the state that is present state and next state

reg[1:0]ps,ns;

parameter IDLE = 2'b00,
          S1   = 2'b01,
          S2   = 2'b10;

//sequential logic for present state
 
always@(posedge clk)
begin
 if (rst)
   ps<=IDLE;
 else
   ps<=ns;
end 

//combinational logic for next state 

always@(ps,coin)
 begin
  ns = IDLE;
 case(ps)
  IDLE : if (coin==1)     ns = S1;
         else if(coin==2) ns = S2;
    S1 : if (coin==1)     ns = S2;
         else if(coin==2) ns = IDLE;
		 else             ns = S1;
	S2 : if ((coin==1)||(coin==2))    
                          ns = IDLE;
         else             ns = S2;
endcase
end

//sequential logic for OUTPUT

always@(posedge clk)
  begin
   product <= 1'b0;
   change <= 1'b0;
   case(ps)
       S1  : if (coin==2)
	         product <= 1;
	   S2  : if (coin==1)
			 product <= 1;
			else if (coin==2) 
			 begin
			 product <= 1;
			 change <= 1;
			 end
	endcase
  end
			 
endmodule

