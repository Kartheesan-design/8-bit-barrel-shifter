// Testbench

module tb();
  
  reg clock;
  reg load;
  reg rshift;
  reg lshift;
  reg [2:0] numbits;
  reg shift_in;
  reg [7:0] in_data;
  wire [7:0] out_data;
  
  reg [7:0] expected_data;
  reg [7:0] previous_data;
  integer cycle_count;
  
  Shifter shifter(
    .clk(clock),
    .load(load),
    .rshift(rshift),
    .lshift(lshift),
    .shiftnum(numbits),
    .inbit(shift_in),
    .in(in_data),
    .out(out_data)
  );
  
  initial begin
    cycle_count = 0;
    clock = 0;
    load = 0;
    rshift = 0;
    lshift = 0;
  end
  
  always #100 clock = ~clock;
  
  always @(negedge clock)begin
    if(out_data !== expected_data)begin
      $display("\n ERROR at time %0t",$time);
      $display("load input = %b",load);
      $display("rshift input = %b",rshift);
      $display("lshift input = %b",lshift);
      $display("numbits input = %b",numbits);
      $display("input bit = %b",shift_in);
      $display("input data = %h",in_data);
      $display("previous output = %h",previous_data);
      $display("expected output = %h",expected_data);
      $display("actual output = %h\n",out_data);
      $stop;
    end
    
    case(cycle_count)
      1:begin
        in_data = 8'b10101010;
        expected_data = 8'b10101010;
        load = 1'b1;
        $display("expected output = %h",expected_data);
        #1000
      	$display("actual output = %h\n",out_data);
      end
      
      2:begin
        in_data = 8'bx;
        shift_in = 1'b1;
        numbits = 3'h3;
        expected_data = 8'b11110101;
        load = 1'b0;
        rshift = 1'b1;
        $display("expected output = %h",expected_data);
        #150
      	$display("actual output = %h\n",out_data);
      end
      
      3:begin
        shift_in = 1'b0;
        numbits = 3'h1;
        expected_data = 8'b01111010;
        $display("expected output = %h",expected_data);
        #150
      	$display("actual output = %h\n",out_data);
      end
      
      4:begin
        numbits = 3'h0;
        expected_data = 8'b01111010;
        $display("expected output = %h",expected_data);
        #150
      	$display("actual output = %h\n",out_data);
      end
      
      5:begin
        shift_in = 1'b1;
        numbits = 3'h7;
        expected_data = 8'b11111110;
        $display("expected output = %h",expected_data);
        #150
      	$display("actual output = %h\n",out_data);
      end
      
      6:begin
        shift_in = 1'b0;
        rshift = 1'b0;
        lshift = 1'b1;
        numbits = 3'h2;
        expected_data = 8'b11111000;
        $display("expected output = %h",expected_data);
        #150
      	$display("actual output = %h\n",out_data);
      end
      
      7:begin
        shift_in = 1'b1;
        numbits = 3'h5;
        expected_data = 8'b00011111;
        $display("expected output = %h",expected_data);
        #150
      	$display("actual output = %h\n",out_data);
      end
      
      8:begin
        in_data = 8'b11000011;
        expected_data = 8'b11000011;
        load = 1'b1;
        $display("expected output = %h",expected_data);
        #150
      	$display("actual output = %h\n",out_data);
      end
      
      9:begin 
        $display("\nSimulation complete - no errors\n");
        $finish;
      end
    endcase
    
    previous_data = out_data;
    
    cycle_count = cycle_count + 1;
  end
endmodule
