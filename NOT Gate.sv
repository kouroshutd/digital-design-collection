// 3. NOT Gate
module not_gate(input a, output y);
  assign y = ~a;
endmodule

module tb_not_gate;
  reg a;
  wire y;

  not_gate uut(a, y);

  initial begin
    $monitor("NOT: a=%b y=%b", a, y);
    a=0; #10;
    a=1; #10;
    $finish;
  end
endmodule
