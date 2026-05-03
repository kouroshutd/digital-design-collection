// 4. XOR Gate
module xor_gate(input a, b, output y);
  assign y = a ^ b;
endmodule

module tb_xor_gate;
  reg a, b;
  wire y;

  xor_gate uut(a, b, y);

  initial begin
    $monitor("XOR: a=%b b=%b y=%b", a, b, y);
    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end
endmodule
