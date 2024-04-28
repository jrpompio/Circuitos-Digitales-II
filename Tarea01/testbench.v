`include "modulos/parkingmanager.v"

module testbench;

    wire clk, sensorA, sensorB,
    gateState, blockAlarm, wrongPinAlarm; 
    wire [7:0] pass;
    
test source(
    .clk(clk),
    .sensorA(sensorA),
    .sensorB(sensorB),
    .pass(pass),
    .gateState(gateState),
    .blockAlarm(blockAlarm),
    .wrongPinAlarm(wrongPinAlarm)
);

parkingmanager Uutmain(
    .clk(clk),
    .sensorA(sensorA),
    .sensorB(sensorB),
    .pass(pass),
    .gateState(gateState),
    .blockAlarm(blockAlarm),
    .wrongPinAlarm(wrongPinAlarm)
);


endmodule
