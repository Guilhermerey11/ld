module top(
  input [1:0] SW, // Entradas x e y, representadas por SW[1] e SW[0]
  output [6:0] HEX0 // Saídas para os segmentos do display de 7 segmentos (a, b, c, d, e, f, g)
);

  // Declaração dos fios (wires) internos para conectar os módulos
  wire w0; // Conecta a saída S0 do Adder à entrada s0 do Display
  wire w1; // Conecta a saída V1 do Adder à entrada s1 do Display


  adder my_adder (
    .a0(SW[1]), 
    .b0(SW[0]),
    .s0(w0),    
    .v1(w1)    
  );


  display my_display (
    .s0(w0),   
    .s1(w1),      
    .a(HEX0[6]), 
    .b(HEX0[5]), 
    .c(HEX0[4]),  
    .d(HEX0[3]), 
    .e(HEX0[2]),  
    .f(HEX0[1]),  
    .g(HEX0[0])   
  );

endmodule
