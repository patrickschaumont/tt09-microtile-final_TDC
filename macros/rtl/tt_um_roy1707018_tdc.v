`default_nettype none

module tt_um_roy1707018_tdc (

	     
    input  wire [7:0] ui_in,    // Dedicated inputs (we'll use ui_in[1:0] for mux control)
    output wire [7:0] uo_out,   // Dedicated outputs (8-bit output of time count)
   // input  wire [7:0] uio_in,   // IOs: Input path
   // output wire [7:0] uio_out,  // IOs: Output path
    //output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    //input  wire       ena,      // Don't use (used for power gating)
    input  wire       clk,      // System clock
    input  wire       rst_n     // Active-low reset
);

endmodule
