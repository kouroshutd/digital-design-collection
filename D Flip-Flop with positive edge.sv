// D Flip-Flop with positive edge clock and active-high reset
module d_ff(
  input clk,
  input reset,
  input d,
  output reg q
);

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 1'b0;
    else
      q <= d;
  end

endmodule

module tb_d_ff;

  reg clk, reset, d;
  wire q;

  d_ff uut (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $monitor("time=%0t clk=%b reset=%b d=%b q=%b",
             $time, clk, reset, d, q);

    reset = 1; d = 0; #10;
    reset = 0;

    d = 1; #10;
    d = 0; #10;
    d = 1; #10;
    d = 0; #10;

    reset = 1; #10;
    reset = 0; d = 1; #10;

    $finish;
  end

endmodule