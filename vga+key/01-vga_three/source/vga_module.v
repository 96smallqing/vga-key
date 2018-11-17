module vga_module
(
    CLK, RSTn,
    VSYNC_Sig, HSYNC_Sig,
	 Red_Sig, Green_Sig, Blue_Sig ,Pin_In, Pin_Out
);

    input CLK;
	 input RSTn;
	 input [3:0]Pin_In;
	 output[3:0] Pin_Out;
	 output VSYNC_Sig;
	 output HSYNC_Sig;
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	 
	 /*************************************/
	 
	 wire CLK_40Mhz;
	 wire [3:0]H2L_Sig;
	 wire [3:0]L2H_Sig;
	 
	 pll_module U1
	 (
	     .inclk0( CLK ),    // input - from top
		  .c0( CLK_40Mhz )   // output - inter global
	 );
	 
	 /**************************************/
	 
	 wire [10:0]Column_Addr_Sig;
	 wire [10:0]Row_Addr_Sig;
	 wire Ready_Sig;
	 wire temp;
	 sync_module U2
	 (
	     .CLK( CLK_40Mhz ),
		  .RSTn( RSTn ),
		  .VSYNC_Sig( VSYNC_Sig ),   // output - to U3
		  .HSYNC_Sig( HSYNC_Sig ),   // output - to U3
		  .Column_Addr_Sig( Column_Addr_Sig ), // output - to U3
		  .Row_Addr_Sig( Row_Addr_Sig ),       // output - to U3
		  .Ready_Sig( Ready_Sig )              // output - to U3
	 );
	 
	 /******************************************/
	 
	 vga_control_module U3
	 (
			.Temp( temp ),
	     .CLK( CLK_40Mhz ),
		  .RSTn( RSTn ),
		  .Ready_Sig( Ready_Sig ),             // input - from U2
		  .Column_Addr_Sig( Column_Addr_Sig ), // input - from U2
		  .Row_Addr_Sig( Row_Addr_Sig ),       // input - from U2
		  .Red_Sig( Red_Sig ),      // output - to top
		  .Green_Sig( Green_Sig ),  // output - to top
		  .Blue_Sig( Blue_Sig )     // output - to top
	 );
	 
	 /*******************************************/
	 	 detect_module anjian
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Pin_In( Pin_In[0] ),   // input - from top
		  .H2L_Sig( H2L_Sig[0] ), // output - to U2
		  .L2H_Sig( L2H_Sig[0])  // output - to U2
	 );
	 
	 /**************************/

	 delay_module anjian1
	 (
		   .Temp( temp ),
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .H2L_Sig( H2L_Sig[0] ), // input - from U1
		  .L2H_Sig( L2H_Sig[0] ), // input - from U1
		  .Pin_Out( Pin_Out[0] )  // output - to top
	 );
	 
	 

endmodule
