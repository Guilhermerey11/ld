module top(
    input CLOCK_50,       // Clock de 50 MHz da placa
    output [9:0] LEDR     // Saída para os 10 LEDs
);


    reg [31:0] count;     

    always @(posedge CLOCK_50)
        count <= count + 1;  
    assign LEDR = count[9:0];



endmodule
