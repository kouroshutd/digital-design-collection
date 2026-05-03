// 6. NOR Gate
module nor_gate(input a, b, output y);
  assign y = ~(a | b);
endmodule

module tb_nor_gate;
  reg a, b;
  wire y;

  nor_gate uut(a, b, y);

  initial begin
    $monitor("NOR: a=%b b=%b y=%b", a, b, y);
    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end
endmodule
