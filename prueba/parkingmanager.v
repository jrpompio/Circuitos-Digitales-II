module parkingmanager (
    input wire clk,
    input wire sensorA,
    input wire sensorB,
    input wire [7:0] pass,
    output wire gateState,
    output wire wrongPinAlarm,
    output wire blockAlarm
);

parameter standby =    6'b000001;
parameter carArrived = 6'b000010;
parameter secondTry =  6'b000100;
parameter thirdTry =   6'b001000;
parameter wrongPin =   6'b010000;
parameter rightPin =   6'b100000;

parameter mypass = 8'b00100110;   // B97026: 26 ---> 0010 0110
                                  // 0x26 = 8'b00100110

reg [5:0] state;
reg [5:0] nextState;

// ----------------------------------------------------------------------------
parameter gateClose = 3'b001;
parameter gateOpen = 3'b010;
parameter gateBlock = 3'b100;

reg [2:0] gstate;
reg [2:0] nextGstate;

// ----------------------------------------------------------------------------
// Reemplazando las salidas de reg por su relación a pines de los estados

assign gateState = gstate[1];
assign wrongPinAlarm = state[4];
assign blockAlarm = gstate[2];


initial begin
    state = standby;
    gstate = gateClose;
end

always @(posedge clk) begin
    state = nextState;
    gstate = nextGstate;
end


always begin   

case (state)
    standby: begin
        if (sensorA && gstate == gateClose) begin
             nextState = carArrived;
        end
        else begin
            nextState = standby;
        end
    end
    
    carArrived: begin
        if (mypass == pass) begin
          nextState = rightPin;
        end
        else if (pass != mypass) begin
          nextState = secondTry;
        end
        else begin
          nextState = carArrived;
        end
    end
    
    secondTry: begin
        if (mypass == pass) begin
            nextState = rightPin;
        end
        else if (pass != mypass) begin
            nextState = thirdTry;
        end
        else begin
            nextState = secondTry;
        end
    end

    thirdTry: begin
        if (mypass == pass) begin
            nextState = rightPin;
        end
        else if (pass != mypass) begin
            nextState = wrongPin;
        end
        else begin
            nextState = thirdTry;
        end
    end
    
    wrongPin: begin 
    if (mypass == pass) begin
        nextState = standby;
    end
    else begin
        nextState = wrongPin; 
    end
    end

    rightPin: begin 
    if (~sensorA && gstate == gateClose) begin
        nextState = standby;
    end
    else begin
        nextState = rightPin;
    end
    end

    default:begin
        nextState = standby;
    end
endcase


case (gstate)
    gateOpen: begin
      if (sensorB) begin
        nextGstate = gateClose;
      end
      else begin
        nextGstate = gateOpen;
      end
    end

    gateBlock: begin
        if (state == rightPin) begin
            nextGstate = gateClose;
        end
        else begin
            nextGstate = gateBlock; 
        end
    end

    gateClose: 
    begin
      if (sensorA && ~sensorB && state == rightPin) begin
      nextGstate = gateOpen;
      end
      else if (sensorA && sensorB) begin
      nextGstate = gateBlock;
      end
      else begin
      nextGstate = gateClose;
      end
    end
    default: begin
        nextGstate = gateClose;
    end
endcase

end

endmodule

