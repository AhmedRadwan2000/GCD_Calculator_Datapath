module testbench;

reg clk_t, rst_t, go_t;
reg [7:0] in1_t;
reg [7:0] in2_t;


wire[7:0] out_t;
wire done_t;


gcd_machine gcd (clk_t, rst_t, go_t, in1_t, in2_t, out_t, done_t);



always
	begin
		clk_t <= 0;
		#25;
		clk_t <= 1;
		#25;
		
	end
	
initial
	begin
		rst_t = 1;
		go_t = 0;
		#50;
		rst_t = 0;

		in1_t = 20;
		in2_t = 15; 
		
		#50;
		go_t = 1;
		while (done_t == 1)
		begin
			#10;
		end
		go_t = 0;
		while (done_t != 1)
		begin
			#10;
		end
		#50;
      	$display("done = %b out = %b", done_t, out_t);

		in1_t = 35;
		in2_t = 14; 
		
		#50;
		go_t = 1;
		while (done_t == 1)
		begin
			#10;
		end
		go_t = 0;
		while (done_t != 1)
		begin
			#10;
		end
		#50;
      	$display("done = %b out = %b", done_t, out_t);
	end
endmodule