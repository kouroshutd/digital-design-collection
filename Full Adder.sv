// 10. Full Adder
module full_adder(input a, b, cin, output sum, cout);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module tb_full_adder;
  reg a, b, cin;
  wire sum, cout;

  full_adder uut(a, b, cin, sum, cout);

  initial begin
    $monitor("Full Adder: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
    a=0; b=0; cin=0; #10;
    a=0; b=0; cin=1; #10;
    a=0; b=1; cin=0; #10;
    a=0; b=1; cin=1; #10;
    a=1; b=0; cin=0; #10;
    a=1; b=0; cin=1; #10;
    a=1; b=1; cin=0; #10;
    a=1; b=1; cin=1; #10;
    $finish;
  end
endmodule
