//========================================================
// Módulo: top
// Projeto: Piscar LEDs com clock de 50 MHz (DE10-Lite, por exemplo)
// Autor: Passarão
// Descrição: Usa um contador de 32 bits para gerar sinais
//            mais lentos e piscar LEDs visivelmente.
//========================================================

module top (
    input CLOCK_50,           // Clock de entrada de 50 MHz
    output [9:0] LEDR         // Vetor de LEDs (LEDR[9:0])
);

    // Declaração do contador
    reg [31:0] count;

    // Sempre que houver borda de subida do clock, incrementa
    always @(posedge CLOCK_50) begin
        count <= count + 1;
    end

    /*
     * Observações:
     * Cada bit do contador divide a frequência do clock:
     * count[0]  = 25 MHz
     * count[1]  = 12.5 MHz
     * ...
     * count[24] = aproximadamente 3 Hz
     */

    // Atribui os bits mais altos aos LEDs — piscará visivelmente
    assign LEDR = count[31:22];  // Usa 10 bits para piscar gradualmente

    // Alternativas:
    // assign LEDR = {10{count[24]}}; // Todos piscam juntos (em ~3 Hz)
    // assign LEDR = 10'b0000000001 << count[25]; // "LED correndo"

endmodule
