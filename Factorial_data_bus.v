module data_bus #(parameter w=8 )
 (
    i_N , i_clk , i_rst , i_wa , i_wb , o_z , o_a
);
    input  [w-1:0] i_N ;
    input i_clk , i_rst ;
    input [1:0] i_wa,i_wb;
    output wire o_z ;
    output wire [((2*w)-1):0] o_a ;

reg [((2*w)-1):0]  A ;
reg [w-1:0] B ;

always @(posedge i_clk or negedge i_rst ) begin
    
if (!i_rst) begin
    A <= 0;
    B <= 0;
end
else
begin
  
    if (i_wa == 2'b00)
        A <= A ;
    else if (i_wa == 2'b01)
        A <= A*B ;
    else if (i_wa == 2'b10)
            A <= 1 ;        

   case (i_wb)
    2'b00: B <= i_N;
    2'b01: B <= B-1;
    2'b10: B <= B ;
    default: B <= B ;
   endcase         
end

end

assign o_z = B == 0 ? 1'b1 : 1'b0 ;
assign o_a = A ; 


endmodule

