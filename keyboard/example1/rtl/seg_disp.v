module seg_disp(clk_50M,BCD_disp,seg_sel,seg_led);
    input clk_50M;
    input [7:0] BCD_disp;
    output [5:0] seg_sel;
    output [7:0] seg_led;
    //����ʱ�ӷ�Ƶģ��,�õ�����Ϊ1ms��ʱ��
    wire clk_1ms;
    clock_division #(
        .DIVCLK_CNTMAX(24_999)
    )
    my_clock_0(
        .clk_in(clk_50M),
        .divclk(clk_1ms)
    );
    //����������ģ��
    wire bit_disp;
    counter counter(
        .clk(clk_1ms),
        .cnt(bit_disp)
    );
    //������·������ģ��
    wire [3:0] data_disp;
    Mux Mux(
        .sel(bit_disp),
        .ina(BCD_disp[3:0]),
        .inb(BCD_disp[7:4]),
        .data_out(data_disp)
    );
    //���������λѡ����ģ��
    seg_sel_decoder seg_sel_decoder(
        .bit_disp(bit_disp),
        .seg_sel(seg_sel)
    );
    //��������ܶ�������ģ��
    seg_led_decoder seg_led_decoder(
        .data_disp(data_disp),
        .seg_led(seg_led)
    );
endmodule