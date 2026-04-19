`timescale 1ns/1ps // (unit/precision) единицы/минимальный шаг  

module alu_register_tb();

localparam WIDTH = 8;

reg clk_i; //объявление дорожек на плате в симуляции
reg arstn_i;
reg valid_i;
reg [WIDTH-1:0] first_i; 
reg [WIDTH-1:0] second_i;
reg [1:0] opcode_i;

wire valid_o;
wire [WIDTH-1:0] result_o;

alu_register #( //создание инстанса
    .WIDTH(WIDTH)
) alu_reg_inst (
    .clk_i (clk_i),
    .arstn_i (arstn_i),
    .valid_i (valid_i),
    .first_i (first_i),
    .second_i (second_i),
    .opcode_i (opcode_i),
    .valid_o (valid_o),
    .result_o (result_o)
);

always begin //создание тактового сигнала //always - всегда работает во время жизни tb
    clk_i = 1'b0; #5;
    clk_i = 1'b1; #5;
end

initial begin //initial - работает один раз с запуском проги
    $dumpvars; //запись изменений всех переменных внутри модуля
    arstn_i = 0;
    valid_i = 0;
    first_i = 0;
    second_i = 0;
    opcode_i = 0;

    #10 
    arstn_i = 0;
    #10

    @(posedge clk_i); #1;
    arstn_i = 1;
    first_i = 8'd1;
    second_i = 8'd2;
    valid_i = 1;
    opcode_i = 2'b00;

    @(posedge clk_i); #1;
    valid_i = 0; 

    @(posedge clk_i); #1;
    valid_i = 1;
    opcode_i = 2'b01;

    @(posedge clk_i); #1;
    valid_i = 0; 

    @(posedge clk_i); #1;
    valid_i = 1;
    opcode_i = 2'b10;

    @(posedge clk_i); #1;
    valid_i = 0; 

    #5;
    arstn_i = 0;
    #10;
    arstn_i = 1;
    #5;
    
    @(posedge clk_i); #1;
    valid_i = 1;
    opcode_i = 2'b11;

    #50

    $finish;
end
endmodule