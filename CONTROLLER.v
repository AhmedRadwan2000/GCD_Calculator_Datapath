module controller (clk, rst, go, a_gt_b, 
					a_eq_b, a_lt_b, a_ld, 
					b_ld, a_sel, b_sel, 
					output_en, done);

input clk, rst;
input go;
input a_gt_b, a_eq_b, a_lt_b;
output reg a_sel, b_sel, a_ld, b_ld, done, output_en;


parameter s0 = 0;
parameter s1 = 1;
parameter s2 = 2;
parameter s3 = 3;
parameter s4 = 4;
parameter s5 = 5;

reg[3:0] ns, cs;

always @(rst or clk)
begin
	if (rst == 1)
		begin
			cs = 0;
		end
	else cs <= ns;
end

always @(clk)
begin
	case (cs)
		s0:
			begin
				if (go == 1)
					begin
						ns = s1;
					end
				else ns = s0;
			end
		s1:ns = s2;
		s2:
			begin
				#10;
				if (a_gt_b == 1) ns = s3;
				else if (a_lt_b == 1) ns = s4;
				else ns = s5;
			end
		s3:ns = s2;
		s4:ns = s2;
		s5:ns = s0;
	endcase
end


always @(clk)
begin
	case (cs)
		s0:{a_sel, b_sel, a_ld, b_ld, done, output_en} = 6'b000_010;				
		s1:{a_sel, b_sel, a_ld, b_ld, done, output_en} = 6'b111_100;
		s2:{a_sel, b_sel, a_ld, b_ld, done, output_en} = 6'b000_000;
		s3:{a_sel, b_sel, a_ld, b_ld, done, output_en} = 6'b001_000;
		s4:{a_sel, b_sel, a_ld, b_ld, done, output_en} = 6'b000_100;
		s5:{a_sel, b_sel, a_ld, b_ld, done, output_en} = 6'b000_011;
	endcase
end
endmodule	

