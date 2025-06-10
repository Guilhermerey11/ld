module top( 
  input [9:0] SW, // op=SW[9], x=SW[8:5], y=SW[4:1], "Erro" | res=SW[0]
  output [9:0] LEDR, // todos acessos em caso de erro
  output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0); // x | "Er" =HEX[5:4], y | "ro" =HEX[3:2], res=HEX[1:0]

  // 2. Instancie o somador/subtrator aqui para por no kit de FPGA

  // Extração dos sinais

    Wire op = SW[9];

    Wire [3:0] x = SW[8:5];

    Wire [3:0] y = SW[4:1];

    Wire show_inputs = SW[0];



  // 2. Instancie o somador/subtrator aqui para por no kit de FPGA

    Wire [3:0] result;

    Wire overflow;



    // Instância do somador/subtrator

    Addsub4bits u1 (

        .a(x),

        .b(y),

        .sub(op),

        .s(result),

        .ov(overflow)

    );



    // Lógica dos LEDs

    Assign LEDR = overflow ? 10’b1111111111 : 10’b0;



    // Saída do resultado nos dois displays da direita

    Hex7seg hres1 (.in(result[3:0]), .out(HEX0));

    Assign HEX1 = 7’b1111111; // Pode ser apagado ou reservado para extensão (ex: sinal)



    // Saída nos 4 dígitos da esquerda

    Wire [6:0] hx, hy;

    Hex7seg hx_disp (.in(x), .out(hx));

    Hex7seg hy_disp (.in(y), .out(hy));



    // Mostrar “Erro” se overflow e SW[0] == 0

    Assign HEX4 = (overflow && ~show_inputs) ? 7’b0001000 : hx; // “E”

    Assign HEX3 = (overflow && ~show_inputs) ? 7’b0000110 : hy; // “r”

    Assign HEX2 = (overflow && ~show_inputs) ? 7’b0000110 : 7’b1111111; // “r” ou apagado

    Assign HEX1 = (overflow && ~show_inputs) ? 7’b1000111 : 7’b1111111; // “o” ou apagado

endmodule
