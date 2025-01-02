// Design
// 8-bit barrel shifter

module Shifter(clk,load,rshift,lshift,shiftnum,inbit,in,out);
  input clk;
  input load;
  input rshift;
  input lshift;
  input [2:0] shiftnum;
  input inbit;
  input [7:0] in;
  
  output reg [7:0]out;
  
  wire clk;
  wire load;
  wire rshift;
  wire lshift;
  wire [2:0] shiftnum;
  wire inbit;
  wire [7:0] in;
  
  
    always@(posedge clk)begin
      
      if(load)begin
        out <= in;
      end
      
      else if(rshift)begin
        case(shiftnum)
          3'h0:out <= out;
          3'h1:out <= {inbit,out[7:1]};
          3'h2:out <= {inbit,inbit,out[7:2]};
          3'h3:out <= {inbit,inbit,inbit,out[7:3]};
          3'h4:out <= {inbit,inbit,inbit,inbit,out[7:4]};
          3'h5:out <= {inbit,inbit,inbit,inbit,inbit,out[7:5]};
          3'h6:out <= {inbit,inbit,inbit,inbit,inbit,inbit,out[7:6]};
          3'h7:out <= {inbit,inbit,inbit,inbit,inbit,inbit,inbit,out[7]};
        endcase
      end
      
      else if(lshift)begin
        case(shiftnum)
          3'h0:out <= out;
          3'h1:out <= {out[6:0],inbit};
          3'h2:out <= {out[5:0],inbit,inbit};
          3'h3:out <= {out[4:0],inbit,inbit,inbit};
          3'h4:out <= {out[3:0],inbit,inbit,inbit,inbit};
          3'h5:out <= {out[2:0],inbit,inbit,inbit,inbit,inbit};
          3'h6:out <= {out[1:0],inbit,inbit,inbit,inbit,inbit,inbit};
          3'h7:out <= {out[0],inbit,inbit,inbit,inbit,inbit,inbit,inbit};
        endcase
      end
    end
endmodule
