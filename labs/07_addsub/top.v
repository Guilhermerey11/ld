module top( 
  input [9:0] SW, // op=SW[9], x=SW[8:5], y=SW[4:1], "Erro" | res=SW[0]
  output [9:0] LEDR, // todos acessos em caso de erro
  output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0); // x | "Er" =HEX[5:4], y | "ro" =HEX[3:2], res=HEX[1:0]

  // 2. Instancie o somador/subtrator aqui para por no kit de FPGA

module top(
    input  [9:0] SW,                  // SW[9]: op, SW[8:5]: x, SW[4:1]: y, SW[0]: mostra entradas ou erro
    output [9:0] LEDR,                // LEDs acendem em caso de overflow
    output [6:0] HEX4, HEX3, HEX2, HEX1, HEX0 // Displays
);

    // Extração dos sinais
    wire op = SW[9];
    wire [3:0] x = SW[8:5];
    wire [3:0] y = SW[4:1];
    wire show_inputs = SW[0];

    wire [3:0] result;
    wire overflow;

    // Instância do somador/subtrator
    addsub4bits u1 (
        .a(x),
        .b(y),
        .sub(op),
        .s(result),
        .ov(overflow)
    );

    // Lógica dos LEDs
    assign LEDR = overflow ? 10'b1111111111 : 10'b0;

    // Saída do resultado nos dois displays da direita
    hex7seg hres1 (.in(result[3:0]), .out(HEX0));
    assign HEX1 = 7'b1111111; // Pode ser apagado ou reservado para extensão (ex: sinal)

    // Saída nos 4 dígitos da esquerda
    wire [6:0] hx, hy;
    hex7seg hx_disp (.in(x), .out(hx));
    hex7seg hy_disp (.in(y), .out(hy));

    // Mostrar "Erro" se overflow e SW[0] == 0
    assign HEX4 = (overflow && ~show_inputs) ? 7'b0001000 : hx; // "E"
    assign HEX3 = (overflow && ~show_inputs) ? 7'b0000110 : hy; // "r"
    assign HEX2 = (overflow && ~show_inputs) ? 7'b0000110 : 7'b1111111; // "r" ou apagado
    assign HEX1 = (overflow && ~show_inputs) ? 7'b1000111 : 7'b1111111; // "o" ou apagado

endmodule




endmodule
