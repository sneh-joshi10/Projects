`timescale 1ns / 1ps  // Specify time unit and precision

module ATM_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [11:0] accNumber;
    reg [3:0] pin;
    reg [2:0] action;
    reg [15:0] amount;
    reg pinChange;
    reg [3:0] newPin;
    reg [11:0] destinationAcc;

    // Outputs
    wire [15:0] balance;
    wire transactionSuccess;
    wire pinSuccess;

    // Instantiate the ATM module
    ATM uut (
        .clk(clk),
        .rst(rst),
        .accNumber(accNumber),
        .pin(pin),
        .action(action),
        .amount(amount),
        .pinChange(pinChange),
        .newPin(newPin),
        .destinationAcc(destinationAcc),
        .balance(balance),
        .transactionSuccess(transactionSuccess),
        .pinSuccess(pinSuccess)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 100MHz clock
    end

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        accNumber = 12'hA1;
        pin = 4'h1;
        action = 3'b000;
        amount = 16'd0;
        pinChange = 0;
        newPin = 4'h0;
        destinationAcc = 12'h00;

        // Apply reset
        #5 rst = 1;   // Apply reset for a few cycles
        #10 rst = 0;

       
        #5;
       

        // Test Case 1: Balance Inquiry
        #10 accNumber = 12'hA1; pin = 4'h1; action = 3'b011; 
        #10; // Wait for a cycle

        

        // Test Case 2: Deposit
        #10 accNumber = 12'hA1; pin = 4'h1; action = 3'b101; amount = 16'd500; // Deposit 500
        #10; // Wait for a cycle

        

        // Test Case 3: Withdraw
        #10 accNumber = 12'hA1; pin = 4'h1; action = 3'b100; amount = 16'd200; // Withdraw 200
        #10; // Wait for a cycle

        

        // Test Case 4: Transfer
        #10 accNumber = 12'hA1; pin = 4'h1; action = 3'b110; amount = 16'd300; destinationAcc = 12'hB2; // Transfer 300 to account B2
        #10; // Wait for a cycle

        // Test Case 5: Change PIN
        #10 accNumber = 12'hA1; pin = 4'h1; action = 3'b111; pinChange = 1; newPin = 4'h9; // Change PIN to 9
        #10; // Wait for a cycle

        // End simulation after testing
        #10 $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("ATM_tb.vcd");  // VCD file to store waveform
        $dumpvars(0, ATM_tb);  // Dump the entire simulation variables
    end

endmodule
