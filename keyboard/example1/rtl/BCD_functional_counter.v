module BCD_functional_counter(
    input clk,                    //ʱ���ź�����
    input [3:0] mode,             //����ģʽ�ź�����
    input [3:0] BCD_preset,       //Ԥ�������ź�����
    output [3:0] BCD_out,         //4bitBCD�����
    input bcin,                   //���ڼ������ź�����
    output reg bcout              //���ڼ������ź����
    );
    parameter preset = 4'b0001;
    parameter clear = 4'b0010;
    parameter up = 4'b0100;
    parameter down = 4'b1000; 
    reg [3:0] cnt = 0;
    //BCD��������������
    always @ (posedge clk) 
        case(mode)
            preset : cnt <= BCD_preset;
            clear : cnt <= 0;
            up : if(bcin) begin 
                     if(cnt == 4'd9)
                         cnt <= 0;
                     else
                         cnt <= cnt + 1'b1;
                 end
            down : if(bcin) begin
                       if(cnt == 4'd0)
                           cnt <= 4'd9;
                       else
                           cnt <= cnt - 1'b1;
                   end
            default : cnt <= cnt;
        endcase
    assign BCD_out = cnt;      //BCD����ֵ���
    //�����źţ���λ���/��λ�����
    always@(*) begin
        if(mode == up)
            bcout = bcin && (cnt == 4'd9);
        else if(mode == down)
            bcout = bcin && (cnt == 4'd0);
        else
            bcout = 1'b0;
    end
endmodule
