/* Generated by Yosys 0.9 (git sha1 1979e0b) */

(* top =  1  *)
(* src = "parkingmanager.v:1" *)
module parkingmanager(clk, sensorA, sensorB, pass, gateState, wrongPinAlarm, blockAlarm);
  wire _000_;
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  (* src = "parkingmanager.v:8" *)
  output blockAlarm;
  (* src = "parkingmanager.v:2" *)
  input clk;
  (* src = "parkingmanager.v:6" *)
  output gateState;
  (* init = 3'h1 *)
  (* src = "parkingmanager.v:29" *)
  reg [2:0] gstate = 3'h1;
  (* src = "parkingmanager.v:30" *)
  wire [2:0] nextGstate;
  (* src = "parkingmanager.v:22" *)
  wire [5:0] nextState;
  (* src = "parkingmanager.v:5" *)
  input [7:0] pass;
  (* src = "parkingmanager.v:3" *)
  input sensorA;
  (* src = "parkingmanager.v:4" *)
  input sensorB;
  (* init = 6'h01 *)
  (* src = "parkingmanager.v:21" *)
  reg [5:0] state = 6'h01;
  (* src = "parkingmanager.v:7" *)
  output wrongPinAlarm;
  NOT _078_ (
    .A(gstate[1]),
    .Y(_011_)
  );
  NOT _079_ (
    .A(state[0]),
    .Y(_012_)
  );
  NOT _080_ (
    .A(state[1]),
    .Y(_013_)
  );
  NOT _081_ (
    .A(state[2]),
    .Y(_014_)
  );
  NOT _082_ (
    .A(state[3]),
    .Y(_015_)
  );
  NOT _083_ (
    .A(state[4]),
    .Y(_016_)
  );
  NOT _084_ (
    .A(state[5]),
    .Y(_017_)
  );
  NOT _085_ (
    .A(sensorA),
    .Y(_018_)
  );
  NOT _086_ (
    .A(pass[1]),
    .Y(_019_)
  );
  NOR _087_ (
    .A(state[0]),
    .B(state[1]),
    .Y(_020_)
  );
  NAND _088_ (
    .A(_012_),
    .B(_013_),
    .Y(_021_)
  );
  NOR _089_ (
    .A(state[2]),
    .B(state[3]),
    .Y(_022_)
  );
  NAND _090_ (
    .A(_014_),
    .B(_015_),
    .Y(_023_)
  );
  NOR _091_ (
    .A(_021_),
    .B(_023_),
    .Y(_024_)
  );
  NOR _092_ (
    .A(state[4]),
    .B(_017_),
    .Y(_025_)
  );
  NAND _093_ (
    .A(_024_),
    .B(_025_),
    .Y(_026_)
  );
  NOT _094_ (
    .A(_026_),
    .Y(_027_)
  );
  NAND _095_ (
    .A(_011_),
    .B(gstate[2]),
    .Y(_028_)
  );
  NOR _096_ (
    .A(gstate[0]),
    .B(_028_),
    .Y(_029_)
  );
  NAND _097_ (
    .A(_026_),
    .B(_029_),
    .Y(_030_)
  );
  NOR _098_ (
    .A(gstate[1]),
    .B(gstate[2]),
    .Y(_031_)
  );
  NAND _099_ (
    .A(gstate[0]),
    .B(_031_),
    .Y(_032_)
  );
  NOT _100_ (
    .A(_032_),
    .Y(_033_)
  );
  NOR _101_ (
    .A(_011_),
    .B(gstate[2]),
    .Y(_034_)
  );
  NOR _102_ (
    .A(gstate[0]),
    .B(sensorB),
    .Y(_035_)
  );
  NAND _103_ (
    .A(_034_),
    .B(_035_),
    .Y(_036_)
  );
  NAND _104_ (
    .A(_032_),
    .B(_036_),
    .Y(_037_)
  );
  NOT _105_ (
    .A(_037_),
    .Y(_038_)
  );
  NAND _106_ (
    .A(_030_),
    .B(_038_),
    .Y(_039_)
  );
  NAND _107_ (
    .A(_018_),
    .B(_033_),
    .Y(_040_)
  );
  NOR _108_ (
    .A(sensorB),
    .B(_032_),
    .Y(_041_)
  );
  NAND _109_ (
    .A(_026_),
    .B(_041_),
    .Y(_042_)
  );
  NAND _110_ (
    .A(_040_),
    .B(_042_),
    .Y(_043_)
  );
  NOT _111_ (
    .A(_043_),
    .Y(_044_)
  );
  NAND _112_ (
    .A(_039_),
    .B(_044_),
    .Y(nextGstate[0])
  );
  NOR _113_ (
    .A(_018_),
    .B(_032_),
    .Y(_045_)
  );
  NOR _114_ (
    .A(sensorB),
    .B(_026_),
    .Y(_046_)
  );
  NAND _115_ (
    .A(_045_),
    .B(_046_),
    .Y(_047_)
  );
  NAND _116_ (
    .A(_036_),
    .B(_047_),
    .Y(nextGstate[1])
  );
  NAND _117_ (
    .A(sensorB),
    .B(_045_),
    .Y(_048_)
  );
  NAND _118_ (
    .A(_030_),
    .B(_048_),
    .Y(nextGstate[2])
  );
  NOR _119_ (
    .A(state[4]),
    .B(state[5]),
    .Y(_049_)
  );
  NOT _120_ (
    .A(_049_),
    .Y(_050_)
  );
  NAND _121_ (
    .A(_013_),
    .B(_022_),
    .Y(_051_)
  );
  NAND _122_ (
    .A(state[0]),
    .B(_049_),
    .Y(_052_)
  );
  NOR _123_ (
    .A(_051_),
    .B(_052_),
    .Y(_053_)
  );
  NAND _124_ (
    .A(_045_),
    .B(_053_),
    .Y(_054_)
  );
  NOT _125_ (
    .A(_054_),
    .Y(nextState[1])
  );
  NOR _126_ (
    .A(_021_),
    .B(_050_),
    .Y(_055_)
  );
  NAND _127_ (
    .A(_020_),
    .B(_049_),
    .Y(_056_)
  );
  NAND _128_ (
    .A(_014_),
    .B(state[3]),
    .Y(_057_)
  );
  NOR _129_ (
    .A(_056_),
    .B(_057_),
    .Y(_058_)
  );
  NOR _130_ (
    .A(_016_),
    .B(state[5]),
    .Y(_059_)
  );
  NAND _131_ (
    .A(_024_),
    .B(_059_),
    .Y(_060_)
  );
  NOT _132_ (
    .A(_060_),
    .Y(_061_)
  );
  NOR _133_ (
    .A(_058_),
    .B(_061_),
    .Y(_062_)
  );
  NAND _134_ (
    .A(_012_),
    .B(state[1]),
    .Y(_063_)
  );
  NOR _135_ (
    .A(_023_),
    .B(_063_),
    .Y(_064_)
  );
  NAND _136_ (
    .A(_049_),
    .B(_064_),
    .Y(_065_)
  );
  NOR _137_ (
    .A(_014_),
    .B(state[3]),
    .Y(_066_)
  );
  NAND _138_ (
    .A(state[2]),
    .B(_015_),
    .Y(_067_)
  );
  NOR _139_ (
    .A(_056_),
    .B(_067_),
    .Y(_068_)
  );
  NAND _140_ (
    .A(_055_),
    .B(_066_),
    .Y(_069_)
  );
  NOR _141_ (
    .A(_058_),
    .B(_068_),
    .Y(_070_)
  );
  NAND _142_ (
    .A(_065_),
    .B(_070_),
    .Y(_071_)
  );
  NAND _143_ (
    .A(_026_),
    .B(_060_),
    .Y(_072_)
  );
  NOR _144_ (
    .A(_071_),
    .B(_072_),
    .Y(_073_)
  );
  NAND _145_ (
    .A(_054_),
    .B(_073_),
    .Y(_074_)
  );
  NOR _146_ (
    .A(_026_),
    .B(_040_),
    .Y(_075_)
  );
  NOR _147_ (
    .A(pass[7]),
    .B(_019_),
    .Y(_076_)
  );
  NAND _148_ (
    .A(pass[2]),
    .B(pass[5]),
    .Y(_077_)
  );
  NOT _149_ (
    .A(_077_),
    .Y(_000_)
  );
  NAND _150_ (
    .A(_076_),
    .B(_000_),
    .Y(_001_)
  );
  NOR _151_ (
    .A(pass[0]),
    .B(pass[3]),
    .Y(_002_)
  );
  NOR _152_ (
    .A(pass[4]),
    .B(pass[6]),
    .Y(_003_)
  );
  NAND _153_ (
    .A(_002_),
    .B(_003_),
    .Y(_004_)
  );
  NOR _154_ (
    .A(_001_),
    .B(_004_),
    .Y(_005_)
  );
  NOT _155_ (
    .A(_005_),
    .Y(_006_)
  );
  NOR _156_ (
    .A(_060_),
    .B(_006_),
    .Y(_007_)
  );
  NOR _157_ (
    .A(_075_),
    .B(_007_),
    .Y(_008_)
  );
  NAND _158_ (
    .A(_074_),
    .B(_008_),
    .Y(nextState[0])
  );
  NOR _159_ (
    .A(_065_),
    .B(_005_),
    .Y(nextState[2])
  );
  NOR _160_ (
    .A(_069_),
    .B(_005_),
    .Y(nextState[3])
  );
  NOR _161_ (
    .A(_062_),
    .B(_005_),
    .Y(nextState[4])
  );
  NAND _162_ (
    .A(_027_),
    .B(_040_),
    .Y(_009_)
  );
  NAND _163_ (
    .A(_071_),
    .B(_005_),
    .Y(_010_)
  );
  NAND _164_ (
    .A(_009_),
    .B(_010_),
    .Y(nextState[5])
  );
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      state[0] <= nextState[0];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      state[1] <= nextState[1];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      state[2] <= nextState[2];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      state[3] <= nextState[3];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      state[4] <= nextState[4];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      state[5] <= nextState[5];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      gstate[0] <= nextGstate[0];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      gstate[1] <= nextGstate[1];
  (* src = "parkingmanager.v:47" *)
  always @(posedge clk)
      gstate[2] <= nextGstate[2];
  assign blockAlarm = gstate[2];
  assign gateState = gstate[1];
  assign wrongPinAlarm = state[4];
endmodule
