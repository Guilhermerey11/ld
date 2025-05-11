module top(
	input [3:0] sw, 
	output [3:0] led);

	assign led = sw;
	//assign led[0] = ~sw[0];
	assign led[0] = ~sw[0];  // Inverte o valor da chave 0 para o LED 0
	assign led[1] = sw[1];  
	assign led[2] = sw[2];  
	assign led[3] = sw[3]; 

endmodule
