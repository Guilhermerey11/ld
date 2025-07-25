module top(
    input CLOCK_50,       // Clock de 50 MHz da placa
    output [9:0] LEDR     // Saída para os 10 LEDs
);

    // Contador de 32 bits
    reg [31:0] count;     // Correção: 'reg' no lugar de 'integer'

    // Incrementa o contador a cada borda de subida do clock
    always @(posedge CLOCK_50)
        count <= count + 1;

    /*
        Frequência de saída de cada bit do contador:
        count[0]  = 25 MHz
        count[1]  = 12.5 MHz
        count[2]  = 6.25 MHz
        ...
        count[9]  ≈ 48.8 kHz
        count[22] ≈ 11.9 Hz
        count[24] ≈ 2.98 Hz
        count[31] ≈ 0.023 Hz
    */

    // ====== MODOS DE EXIBIÇÃO (escolha apenas 1) ======

    // Modo 1: LEDs mostram os 10 bits menos significativos do contador
    assign LEDR = count[9:0];

    // Modo 2: LEDs mostram os 10 bits mais significativos (piscar mais lento)
    // assign LEDR = count[31:22];

    // Modo 3: Todos os LEDs piscam juntos com base em 1 único bit
    // assign LEDR = {10{count[24]}};

endmodule
