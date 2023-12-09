module fsm (
    input  wire             z_out,
    input  wire             clk,
    input  wire             rst,
    output reg   [1:0]      wa,
    output reg   [1:0]      wb,
    output reg done 
);

reg [1:0] current_State, next_state;

localparam s0 = 2'b00,
           s1 = 2'b01,
           s2 = 2'b10;

// state transition

always @( posedge clk or negedge rst )
    begin
        if (!rst)
            begin
                current_State <= s0;
            end 
        else
            begin
                current_State <= next_state;
            end
    end

// Next state

always @(*)
    begin
        case (current_State)

        s0 : begin
                  next_state =  s1;
             end   
        s1 : begin
                  if (z_out == 1'b0)  
                  next_state =  s1;
                  else
                  next_state =  s2;
             end 
        s2 : begin
                next_state =  s2;
             end  
        default : next_state =  s0;
    endcase // current_State
    end

// output 

always @(*)
    begin
        done =0;
        case (current_State)

        s0 : begin
                wa = 2'b10;
                wb = 2'b00;
             end   
        s1 : begin
                wa = 2'b01;
                wb = 2'b01;
             end 
        s2 : begin
                wa = 2'b00;
                wb = 2'b10;
                done =1;
             end  
        default : begin
                wa = 2'b00;
                wb = 2'b10; 
                end
        endcase
    end



endmodule