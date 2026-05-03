// 5. NAND Gate
module nand_gate(input a, b, output y);
  assign y = ~(a & b);
endmodule

module tb_nand_gate;
  reg a, b;
  wire y;

  nand_gate uut(a, b, y);

  initial begin
    $monitor("NAND: a=%b b=%b y=%b", a, b, y);
    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end
endmodule