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

  wire [1:0] sel = uio_in[1:0];
  wire [7:0] uo_out_proj[3:0];
 
  assign uo_out  = uo_out_proj[sel];
  assign uio_out = 0;
  assign uio_oe  = 0;

  tt_um_roy1707018_sensor proj1 (
      .rst_n(sel == 0 ? rst_n : 1'b0),
      .clk(clk),
      .ui_in(ui_in),
      .uo_out(uo_out_proj[1]),
      .ena(ena),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe)
  );

  tt_um_roy1707018_tdc proj2 (
      .rst_n(sel == 0 ? rst_n : 1'b0),
      .clk(clk),
      .ui_in({6'h00, uo_out_proj[0][1:0]}),
      .uo_out(uo_out_proj[1]),
      .ena(ena),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe)
  );

  tt_um_roy1707018_ro proj3 (
      .rst_n(sel == 2 ? rst_n : 1'b0),
      .clk(sel == 2 ? clk : 1'b0),
      .ui_in(sel == 2 ? {6'b0, ui_in[3:2]} : 8'b0),
      .uo_out(uo_out_proj[1]),
      .ena(ena),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe) 
  );

  tt_um_roy1707018_ro2 proj4 (
      .rst_n(sel == 3 ? rst_n : 1'b0),
      .clk(sel == 3 ? clk : 1'b0),
      .ui_in(sel == 3 ? {6'b0, ui_in[5:4]} : 8'b0),
      .uo_out(uo_out_proj[1]),
      .ena(ena),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe)
  );

  // List all unused inputs to prevent warnings
  wire _unused = &{ena,uio_in[7:2], 1'b0};

endmodule
