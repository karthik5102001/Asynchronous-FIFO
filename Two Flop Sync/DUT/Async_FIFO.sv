module Async_fifo #(parameter Width=4)
      (wclk,rclk,wreset,r_rst,wdata,wen,ren,rdata,full,empty);
	input wclk,rclk;
	input wreset,r_rst;
	input [Width-1:0] wdata;
	input wen,ren;
	output [Width-1:0] rdata;
	output full;
	output empty;

    // Extra wires
    localparam Address=2**Width;
    wire [Width-1:0] Read_Data;
   
	// WRITE Side

	// Wires to write pointer module
	wire full_from_full_logic;
	wire [Address:0] wrt_ptr_to_b2g;
	wire [Address:0] red_ptr_from_g2b_sync;

	// Wire to binary to gray from write pointer side to dff
	wire [Address:0] wrt_ptr_from_b2g_2_dff;

	// Wire to Dff to gray to binary
    //	wire [Width-1:0] Dff_to_Dff_wrt_ptr;
	wire [Address:0] Dff_to_g2b_wrt_ptr;

	// Wire to write pointer to memory
	wire [Width-1:0] wrt_ptr_2_memory;
	
	wire [Address:0] wrt_ptr_from_g2b_sync;

	// READ Side

	// Wires to read pointer module
	wire empty_from_empty_logic;
	wire [Address:0] red_ptr_to_b2g;
//	wire [Width-1:0] wrt_ptr_from_b2g_sync;

	// Wire to binary to gray from read pointer side to dff
	wire [Address:0] rd_ptr_from_b2g_2_dff;

	// Wire to Dff to gray to binary
//	wire [Width-1:0] Dff_to_Dff_rd_ptr;
	wire [Address:0] Dff_to_g2b_rd_ptr;

	// Wire to read pointer to memory
//	wire [Width-1:0] rd_ptr_2_memory;

	// Wire to and logic
	wire and_of_wen_full_wrt_ptr_side;
	
	write_ptr_full_logic  #(Address) WRITE_POINTER (wclk,wreset,wen,red_ptr_from_g2b_sync,wrt_ptr_to_b2g,full_from_full_logic);
	b2g  #(Address) BINARY_TO_GRAY_FROM_WRITE_POINTER (wrt_ptr_to_b2g,wrt_ptr_from_b2g_2_dff);
	dff_sync  #(Address) B2G_2_DFF_FROM_WRTPTR(rclk,r_rst,wrt_ptr_from_b2g_2_dff,Dff_to_g2b_wrt_ptr);  // going to read pointer module
	g2b  #(Address) GRAY_TO_BINARY_FROM_WRTIE_PTR_TO_RD_PTR (Dff_to_g2b_wrt_ptr,wrt_ptr_from_g2b_sync);
	
	read_ptr_empty_logic  #(Address) READ_POINTER (rclk,r_rst,ren,wrt_ptr_from_g2b_sync,red_ptr_to_b2g,empty_from_empty_logic);
    b2g  #(Address) BINARY_TO_GRAY_FROM_READ_POINTER(red_ptr_to_b2g,rd_ptr_from_b2g_2_dff);
	dff_sync #(Address) B2G_2_DFF_FROM_RDPTR  (wclk,wreset,rd_ptr_from_b2g_2_dff,Dff_to_g2b_rd_ptr);
	g2b  #(Address) GRAY_TO_BINARY_FROM_WRITE_POINTER (Dff_to_g2b_rd_ptr,red_ptr_from_g2b_sync);

    memory #(Width,Address) MEMORY_MODULE (wdata,Read_Data,wclk,wreset,rclk,r_rst,wrt_ptr_to_b2g,red_ptr_to_b2g,wen,ren,full_from_full_logic,empty_from_empty_logic);

	assign full = full_from_full_logic;
	assign empty = empty_from_empty_logic;
	assign rdata = Read_Data;

endmodule

