module top (
    input x1, x2, x3, s0, s1,
    output xfe, xff
);
    mux3e dute(x1, x2, x3, s0, s1, xfe); // estrutural
    mux3f dutf(x1, x2, x3, s0, s1, xff); // funcional
endmodule 

// Estrutural
module mux3e (
    input x1, x2, x3, s0, s1,
    output f
);
    // Instancia e conecta os componentes abaixo
    wire w1;
    mux2 m1(w1, s0, x1, x2); // Seleciona entre x1 e x2 com s0
    mux2 m2(f,  s1, w1, x3); // Seleciona entre w1 e x3 com s1
endmodule

// Funcional
module mux3f (
    input x1, x2, x3, s0, s1,
    output f
);
    // Implementação condicional direta
    assign f = (s1 == 0) ? (s0 ? x2 : x1) : x3;
endmodule

// MUX 2:1 genérico
module mux2 (
    output f,
    input s, x1, x2
);
    assign f = s ? x2 : x1;
endmodule
