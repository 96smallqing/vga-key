module vga_control_module
(
    Temp,CLK, RSTn,
	 Ready_Sig, Column_Addr_Sig, Row_Addr_Sig,
	 Red_Sig, Green_Sig, Blue_Sig
);
    input CLK;
	 input RSTn;
	 input Temp;
	 input Ready_Sig;
	 input [10:0]Column_Addr_Sig;
	 input [10:0]Row_Addr_Sig;
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	
	 /**********************************/
	 reg [2:0] rgb;
	 //wire Temp;	
	 //reg flag;
//	 always @ ( posedge CLK or negedge RSTn )
//	     if( !RSTn )
//		  begin     isRectangle <= 1'b0;isRectangle1 <= 1'b0;isRectangle2 <= 1'b0;
//		  end
//		  else if( Column_Addr_Sig > 11'd0 && Row_Addr_Sig < 11'd200 )
//            isRectangle <= 1'b1;
//		  else if( Column_Addr_Sig > 11'd0 && Row_Addr_Sig < 11'd400 && Row_Addr_Sig >=11'd200 )
//            isRectangle1 <= 1'b1;
//		  else if( Column_Addr_Sig > 11'd0 && Row_Addr_Sig < 11'd600 && Row_Addr_Sig >=11'd400 )
//            isRectangle2 <= 1'b1;
//		  else
//		   begin   isRectangle <= 1'b0;isRectangle1 <= 1'b0;isRectangle2 <= 1'b0;end
		always @(posedge CLK or negedge RSTn )		
			if( !RSTn)
				rgb<=3'b000;
			else if(Temp==1'b1)
				rgb<=3'b001;
//			else if(Pin_Out[1]==1'b1)
//				rgb<=3'b010;
//			else if(Pin_Out[2]==1'b1)
//				rgb<=3'b101;
//			else if(Pin_Out[3]==1'b1)
//				rgb<=3'b100;
			else rgb<=3'b100;
			
	/************************************/
	
	assign {Red_Sig,Green_Sig,Blue_Sig}=Ready_Sig?rgb:3'b000;	
//	 assign Red_Sig = Ready_Sig && isRectangle ? 1'b1 : (Ready_Sig && isRectangle1 ? 1'b0 : 1'b0);
//	 assign Green_Sig = Ready_Sig && isRectangle ? 1'b0 : ( Ready_Sig && isRectangle1 ? 1'b0 : 1'b0);
//	 assign Blue_Sig = Ready_Sig && isRectangle ? 1'b1 : (Ready_Sig && isRectangle1 ? 1'b1 : 1'b0);
	 
	/***********************************/

	 
	/***********************************/

endmodule
