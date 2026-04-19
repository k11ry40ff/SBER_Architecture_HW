module alu_register #( //список параметров (метаданные(данные о данных))
    parameter WIDTH = 8
)(
    input clk_i, //(clock input) - входной тактовый сигнал
    input arstn_i, //(reset) a - асинхронный, n - негативная полярность(активный при нуле)
    input valid_i,
    input [WIDTH-1:0] first_i, 
    input [WIDTH-1:0] second_i,
    input [1:0] opcode_i,
    output reg valid_o,
    output reg [WIDTH-1:0] result_o
);

//реализация триггеров ниже

always @(posedge clk_i) begin //@(...) - ждать события 
    if (valid_i) begin        //posedge - положительный фронт (0 -> 1)
        case (opcode_i)       //negedge - отрицательный фронт (1 -> 0)
        2'b00: result_o <= first_i + second_i;
        2'b01: result_o <= ~(first_i & second_i);
        2'b10: result_o <= second_i <<<  first_i;
        2'b11: result_o <= (second_i != first_i);
        endcase
    end
end

always @(posedge clk_i or negedge arstn_i) begin
    if (!arstn_i) begin
        valid_o <= 1'b0;
    end else begin
        valid_o <= valid_i;
    end 
end

endmodule