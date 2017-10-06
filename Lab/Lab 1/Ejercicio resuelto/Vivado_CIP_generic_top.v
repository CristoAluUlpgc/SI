//
// Top module for generic CIP in Vivado
//
`timescale 1 ns / 1 ps

module top;
   // Top parameteres for DUT
   parameter integer C_S00_AXI_DATA_WIDTH = 32;
   parameter integer C_S00_AXI_ADDR_WIDTH = 4;

   // Add users top parameteres for DUT

   // End users top parameteres for DUT

   // Add users pop parameteres for tasks
   
   // End users pop parameteres for tasks

   // Ports of Axi Slave Bus Interface S00_AXI
   reg 		     s00_axi_aclk;
   reg 		     s00_axi_aresetn;
   reg [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr;
   reg [2 : 0] 			    s00_axi_awprot;
   reg 				    s00_axi_awvalid;
   wire 			    s00_axi_awready;
   reg [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata;
   reg [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb;
   reg 					s00_axi_wvalid;
   wire 				s00_axi_wready;
   wire [1 : 0] 			s00_axi_bresp;
   wire 				s00_axi_bvalid;
   reg 					s00_axi_bready;
   reg [C_S00_AXI_ADDR_WIDTH-1 : 0] 	s00_axi_araddr;
   reg [2 : 0] 				s00_axi_arprot;
   reg 					s00_axi_arvalid;
   wire 				s00_axi_arready;
   wire [C_S00_AXI_DATA_WIDTH-1 : 0] 	s00_axi_rdata;
   wire [1 : 0] 			s00_axi_rresp;
   wire 				s00_axi_rvalid;
   reg 					s00_axi_rready;
   
   // Add user inputs / wires
   wire [7:0] test_sieteseg,

   // Instantiation of Axi Bus Interface
   cip_gpio_rgb_v1_0 # ( 
		       .C_S00_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		       .C_S00_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
		       ) 
   cip_gpio_rgb_v1_0_inst (
                .sieteseg(test_sieteseg), // Chequear
			 .s00_axi_aclk(s00_axi_aclk),
			 .s00_axi_aresetn(s00_axi_aresetn),
			 .s00_axi_awaddr(s00_axi_awaddr),
			 .s00_axi_awprot(s00_axi_awprot),
			 .s00_axi_awvalid(s00_axi_awvalid),
			 .s00_axi_awready(s00_axi_awready),
			 .s00_axi_wdata(s00_axi_wdata),
			 .s00_axi_wstrb(s00_axi_wstrb),
			 .s00_axi_wvalid(s00_axi_wvalid),
			 .s00_axi_wready(s00_axi_wready),
			 .s00_axi_bresp(s00_axi_bresp),
			 .s00_axi_bvalid(s00_axi_bvalid),
			 .s00_axi_bready(s00_axi_bready),
			 .s00_axi_araddr(s00_axi_araddr),
			 .s00_axi_arprot(s00_axi_arprot),
			 .s00_axi_arvalid(s00_axi_arvalid),
			 .s00_axi_arready(s00_axi_arready),
			 .s00_axi_rdata(s00_axi_rdata),
			 .s00_axi_rresp(s00_axi_rresp),
			 .s00_axi_rvalid(s00_axi_rvalid),
			 .s00_axi_rready(s00_axi_rready)
			 );
	 
   // Add test logic here
    always #3
        s00_axi_aclk = ~s00_axi_aclk;

    initial s00_axi_aclk = 0;

    initial begin
      #31 s00_axi_aresetn = 1'b1;
      #153 s00_axi_aresetn = 1'b0;
      #234 s00_axi_aresetn = 1'b1;
    end
   // Test logic ends
   
   // Add user tasks
   
    //write_reg(0, "d")

   // Tasks
   task reset;
      begin
	 wait(!s00_axi_aresetn) @(posedge s00_axi_aclk);
	 
	 // AXI Interface
	 s00_axi_awaddr <= 0;
	 s00_axi_awprot <= 0;
	 s00_axi_awvalid <= 0;
	 s00_axi_wdata <= 0;
	 s00_axi_wstrb <= 0;
	 s00_axi_wvalid <= 0;
	 s00_axi_bready <= 0;
	 s00_axi_araddr <= 0;
	 s00_axi_arprot <= 0;
	 s00_axi_arvalid <= 0;
	 s00_axi_rready <= 0;
	 	 
	 wait(s00_axi_aresetn) @(posedge s00_axi_aclk);
      end
   endtask // reset
   
   task write_reg;
      input [2:0] regnum;
      input [31:0] data;
      begin
 	 s00_axi_awvalid <= 1'b1;
	 s00_axi_wvalid <= 1'b1;
	 s00_axi_awaddr <= regnum << 2;
	 s00_axi_wdata <= data;
	 s00_axi_wstrb <= 4'b1111;
	 while (!s00_axi_awready) @(posedge s00_axi_aclk);
	 s00_axi_awvalid <= 1'b0;
	 s00_axi_wvalid <= 1'b0;
      end
   endtask // reset
   
   // End user tasks
   
endmodule
