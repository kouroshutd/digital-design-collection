module trafficFSM (
input logic clk,
input logic reset,
input logic ta, tb,
output logic [1:0] la, lb
);
typedef enum logic [1:0] {S0, S1, S2, S3} statetype;
statetype state, nextstate;
localparam logic [1:0] GREEN = 2'b00;
localparam logic [1:0] YELLOW = 2'b01;
localparam logic [1:0] RED = 2'b10;
// State register
always_ff @(posedge clk or posedge reset) begin
if (reset)
state <= S0;
else
state <= nextstate;
end
// Next-state logic
always_comb begin
case (state)
S0: begin
if (ta)
nextstate = S0;
else
nextstate = S1;
end
S1: begin
nextstate = S2;
end
S2: begin
if (tb)
nextstate = S2;
else
nextstate = S3;
end
S3: begin
nextstate = S0;
end
default: begin
nextstate = S0;
end
endcase
end
// Output logic
always_comb begin
case (state)
S0: begin
la = GREEN;
lb = RED;
end
S1: begin
la = YELLOW;
lb = RED;
end
S2: begin
la = RED;
lb = GREEN;
end
S3: begin
la = RED;
lb = YELLOW;
end
default: begin
la = RED;
lb = RED;
end
endcase
end
endmodule

module trafficFSM_tb;
logic clk;
logic reset;
logic ta, tb;
logic [1:0] la, lb;
localparam logic [1:0] GREEN = 2'b00;
localparam logic [1:0] YELLOW = 2'b01;
localparam logic [1:0] RED = 2'b10;
integer errors;
// Instantiate DUT
trafficFSM dut (
.clk(clk),
.reset(reset),
.ta(ta),
.tb(tb),
.la(la),
.lb(lb)
);
// Clock generation
always #5 clk = ~clk;
// Check output task
task check_outputs;
input logic [1:0] expected_la;
input logic [1:0] expected_lb;
input string testname;
begin
if (la !== expected_la || lb !== expected_lb) begin
$display("ERROR: %s", testname);
$display("Expected la=%b lb=%b, got la=%b lb=%b",
expected_la, expected_lb, la, lb);
errors = errors + 1;
end
else begin
$display("PASS: %s", testname);
end
end
endtask
initial begin
clk = 0;
reset = 1;
ta = 0;
tb = 0;
errors = 0;
// Apply reset
repeat (2) @(posedge clk);
#1;
check_outputs(GREEN, RED, "Reset state S0: A green, B red");
reset = 0;
// S0: stay in S0 while ta = 1
ta = 1;
tb = 0;
@(posedge clk);
#1;
check_outputs(GREEN, RED, "S0 stays S0 when ta = 1");
// S0 -> S1 when ta = 0
ta = 0;
@(posedge clk);
#1;
check_outputs(YELLOW, RED, "S0 to S1 when ta = 0");
// S1 -> S2
@(posedge clk);
#1;
check_outputs(RED, GREEN, "S1 to S2");
// S2: stay in S2 while tb = 1
tb = 1;
@(posedge clk);
#1;
check_outputs(RED, GREEN, "S2 stays S2 when tb = 1");
// S2 -> S3 when tb = 0
tb = 0;
@(posedge clk);
#1;
check_outputs(RED, YELLOW, "S2 to S3 when tb = 0");
// S3 -> S0
@(posedge clk);
#1;
check_outputs(GREEN, RED, "S3 to S0");
// Final result
if (errors == 0)
$display("All tests passed.");
else
$display("%0d tests failed.", errors);
$finish;
end
endmodule
