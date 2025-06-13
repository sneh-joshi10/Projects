`timescale 1ns / 1ps  // Specify time unit and precision

`define TRUE 1'b1
`define FALSE 1'b0
`define PIN_SIZE 4
`define ACCOUNT_SIZE 12
`define BALANCE_SIZE 16
`define MAX_ACCOUNTS 10

module ATM(
    input clk,
    input rst,
    input [`ACCOUNT_SIZE-1:0] accNumber,
    input [`PIN_SIZE-1:0] pin,
    input [2:0] action,
    input [`BALANCE_SIZE-1:0] amount,
    input pinChange,
    input [`PIN_SIZE-1:0] newPin,
    input [`ACCOUNT_SIZE-1:0] destinationAcc,
    output reg [`BALANCE_SIZE-1:0] balance,
    output reg transactionSuccess,
    output reg pinSuccess
);

    // Randomly initialized database
    reg [`ACCOUNT_SIZE-1:0] acc_database [`MAX_ACCOUNTS-1:0];
    reg [`PIN_SIZE-1:0] pin_database [`MAX_ACCOUNTS-1:0];
    reg [`BALANCE_SIZE-1:0] balance_database [`MAX_ACCOUNTS-1:0];
    reg [3:0] failedAttempts [`MAX_ACCOUNTS-1:0];

    reg [3:0] accIndex;
    reg [3:0] destIndex;
    reg accountFound;
    integer i;

    reg [2:0] currentState, nextState;

    parameter IDLE = 3'd0,
              AUTHENTICATE = 3'd1,
              MAIN_MENU = 3'd2,
              BALANCE_INQUIRY = 3'd3,
              DEPOSIT = 3'd4,
              WITHDRAW = 3'd5,
              TRANSFER = 3'd6,
              CHANGE_PIN = 3'd7;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Initialize 5 sample accounts
            acc_database[0] <= 12'hA1; pin_database[0] <= 4'h1; balance_database[0] <= 16'd1000; failedAttempts[0] <= 0;
            acc_database[1] <= 12'hB2; pin_database[1] <= 4'h2; balance_database[1] <= 16'd2000; failedAttempts[1] <= 0;
            acc_database[2] <= 12'hC3; pin_database[2] <= 4'h3; balance_database[2] <= 16'd3000; failedAttempts[2] <= 0;
            acc_database[3] <= 12'hD4; pin_database[3] <= 4'h4; balance_database[3] <= 16'd4000; failedAttempts[3] <= 0;
            acc_database[4] <= 12'hE5; pin_database[4] <= 4'h5; balance_database[4] <= 16'd5000; failedAttempts[4] <= 0;

            currentState <= IDLE;
            transactionSuccess <= `FALSE;
            pinSuccess <= `FALSE;
            balance <= 0;
        end else begin
            currentState <= nextState;
            transactionSuccess <= `FALSE;
            pinSuccess <= `FALSE;
            balance <= balance_database[accIndex]; // Update balance output immediately
        end
    end

    always @* begin
        nextState = currentState;
        accountFound = `FALSE;
        accIndex = 0;
        destIndex = 4'd15; // invalid default

        // Search for account
        for (i = 0; i < `MAX_ACCOUNTS; i = i + 1) begin
            if (accNumber == acc_database[i]) begin
                accIndex = i;
                accountFound = `TRUE;
            end
        end

        case (currentState)
            IDLE: if (accountFound) nextState = AUTHENTICATE;
                    else nextState = IDLE;

            AUTHENTICATE: begin
                if (pin == pin_database[accIndex] && failedAttempts[accIndex] < 3) begin
                    nextState = MAIN_MENU;
                    failedAttempts[accIndex] = 0;
                end else begin
                    if (failedAttempts[accIndex] < 3)
                        failedAttempts[accIndex] = failedAttempts[accIndex] + 1;
                    nextState = IDLE;
                end
            end

            MAIN_MENU: begin
                case (action)
                    3'b011: nextState = BALANCE_INQUIRY;
                    3'b100: nextState = WITHDRAW;
                    3'b101: nextState = DEPOSIT;
                    3'b110: nextState = TRANSFER;
                    3'b111: nextState = CHANGE_PIN;
                    default: nextState = MAIN_MENU;
                endcase
            end

            BALANCE_INQUIRY: begin
                transactionSuccess = `TRUE;  // Indicating that balance i
                nextState = MAIN_MENU;
            end

            DEPOSIT: begin
                balance_database[accIndex] = balance_database[accIndex] + amount;
                transactionSuccess = `TRUE;
                nextState = MAIN_MENU;
            end

            WITHDRAW: begin
                if (balance_database[accIndex] >= amount) begin
                    balance_database[accIndex] = balance_database[accIndex] - amount;
                    transactionSuccess = `TRUE;
                end
                nextState = MAIN_MENU;
            end

            TRANSFER: begin
                for (i = 0; i < `MAX_ACCOUNTS; i = i + 1) begin
                    if (destinationAcc == acc_database[i]) destIndex = i;
                end
                if (destIndex != 4'd15 && balance_database[accIndex] >= amount) begin
                    balance_database[accIndex] = balance_database[accIndex] - amount;
                    balance_database[destIndex] = balance_database[destIndex] + amount;
                    transactionSuccess = `TRUE;
                end
                nextState = MAIN_MENU;
            end

            CHANGE_PIN: begin
                if (pinChange) begin
                    pin_database[accIndex] = newPin;
                    pinSuccess = `TRUE;
                end
                nextState = MAIN_MENU;
            end

            default: nextState = IDLE;
        endcase
    end
endmodule

