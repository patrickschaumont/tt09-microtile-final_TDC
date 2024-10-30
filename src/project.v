`default_nettype none

module tt_um_micro_tiles_container (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [7:0] uo_out_proj;

  assign uo_out  = uo_out_proj;
  assign uio_out = 0;
  assign uio_oe  = 0;

  tt_um_microtile proj1 (
      .rst_n(sel == 0 ? rst_n : 1'b0),
      .clk(sel == 0 ? clk : 1'b0),
      .ui_in(sel == 0 ? ui_in : 8'h00),
      .uo_out(uo_out_proj)
  );

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[7:0], 1'b0};

endmodule
