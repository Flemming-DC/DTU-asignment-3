module DataMemory(
  input         clock,
  input  [15:0] io_address,
  input         io_writeEnable,
  input  [31:0] io_dataWrite,
  output [31:0] io_dataRead,
  input         io_testerEnable,
  input  [15:0] io_testerAddress,
  output [31:0] io_testerDataRead,
  input         io_testerWriteEnable,
  input  [31:0] io_testerDataWrite
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] memory [0:65535]; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_2_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_2_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_1_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_1_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_1_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_1_en; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_3_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_3_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_3_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_3_en; // @[DataMemory.scala 18:20]
  wire [31:0] _GEN_5 = io_testerWriteEnable ? io_testerDataWrite : memory__T_data; // @[DataMemory.scala 27:32]
  wire [31:0] _GEN_11 = io_writeEnable ? io_dataWrite : memory__T_2_data; // @[DataMemory.scala 37:26]
  assign memory__T_addr = io_testerAddress;
  assign memory__T_data = memory[memory__T_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_2_addr = io_address;
  assign memory__T_2_data = memory[memory__T_2_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_1_data = io_testerDataWrite;
  assign memory__T_1_addr = io_testerAddress;
  assign memory__T_1_mask = 1'h1;
  assign memory__T_1_en = io_testerEnable & io_testerWriteEnable;
  assign memory__T_3_data = io_dataWrite;
  assign memory__T_3_addr = io_address;
  assign memory__T_3_mask = 1'h1;
  assign memory__T_3_en = io_testerEnable ? 1'h0 : io_writeEnable;
  assign io_dataRead = io_testerEnable ? 32'h0 : _GEN_11; // @[DataMemory.scala 26:17 DataMemory.scala 34:17 DataMemory.scala 40:19]
  assign io_testerDataRead = io_testerEnable ? _GEN_5 : 32'h0; // @[DataMemory.scala 24:23 DataMemory.scala 30:25 DataMemory.scala 36:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(memory__T_1_en & memory__T_1_mask) begin
      memory[memory__T_1_addr] <= memory__T_1_data; // @[DataMemory.scala 18:20]
    end
    if(memory__T_3_en & memory__T_3_mask) begin
      memory[memory__T_3_addr] <= memory__T_3_data; // @[DataMemory.scala 18:20]
    end
  end
endmodule
module Accelerator(
  input         clock,
  input         reset,
  input         io_start,
  output        io_done,
  input  [31:0] io_dataRead,
  output [15:0] io_address,
  output        io_writeEnable,
  output [31:0] io_dataWrite
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stateReg; // @[Accelerator.scala 55:25]
  reg [31:0] xReg; // @[Accelerator.scala 56:21]
  reg [31:0] yReg; // @[Accelerator.scala 57:21]
  reg [31:0] inImageReg; // @[Accelerator.scala 58:27]
  reg [31:0] inImageLeftReg; // @[Accelerator.scala 59:31]
  reg [31:0] inImageRightReg; // @[Accelerator.scala 60:32]
  reg [31:0] inImageTopReg; // @[Accelerator.scala 61:30]
  reg [31:0] inImageDownReg; // @[Accelerator.scala 62:31]
  reg [31:0] debugReg; // @[Accelerator.scala 64:25]
  reg [31:0] debugRegVal; // @[Accelerator.scala 65:28]
  wire  _T = 4'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 4'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = xReg < 32'h14; // @[Accelerator.scala 81:28]
  wire  _T_4 = 4'h2 == stateReg; // @[Conditional.scala 37:30]
  wire [5:0] _T_5 = 5'h14 * 5'h1; // @[Accelerator.scala 185:28]
  wire [6:0] _T_6 = {{1'd0}, _T_5}; // @[Accelerator.scala 185:21]
  wire  _T_8 = 4'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [31:0] _T_10 = xReg + 32'h1; // @[Accelerator.scala 100:36]
  wire [36:0] _T_11 = 32'h14 * yReg; // @[Accelerator.scala 185:28]
  wire [36:0] _GEN_115 = {{5'd0}, _T_10}; // @[Accelerator.scala 185:21]
  wire [36:0] _T_13 = _GEN_115 + _T_11; // @[Accelerator.scala 185:21]
  wire  _T_14 = yReg < 32'h14; // @[Accelerator.scala 103:28]
  wire  _T_16 = 4'h4 == stateReg; // @[Conditional.scala 37:30]
  wire [31:0] _T_18 = yReg + 32'h1; // @[Accelerator.scala 112:40]
  wire [36:0] _T_19 = 32'h14 * _T_18; // @[Accelerator.scala 185:28]
  wire [36:0] _GEN_116 = {{5'd0}, xReg}; // @[Accelerator.scala 185:21]
  wire [36:0] _T_21 = _GEN_116 + _T_19; // @[Accelerator.scala 185:21]
  wire  _T_22 = xReg == 32'h0; // @[Accelerator.scala 114:29]
  wire  _T_23 = xReg == 32'h13; // @[Accelerator.scala 114:45]
  wire  _T_24 = _T_22 | _T_23; // @[Accelerator.scala 114:37]
  wire  _T_25 = yReg == 32'h0; // @[Accelerator.scala 114:62]
  wire  _T_26 = _T_24 | _T_25; // @[Accelerator.scala 114:54]
  wire  _T_27 = yReg == 32'h13; // @[Accelerator.scala 114:78]
  wire  _T_28 = _T_26 | _T_27; // @[Accelerator.scala 114:70]
  wire  _T_29 = inImageReg == 32'h0; // @[Accelerator.scala 115:33]
  wire  _T_30 = ~_T_28; // @[Accelerator.scala 116:23]
  wire [2:0] _T_31 = _T_29 ? 3'h6 : 3'h5; // @[Accelerator.scala 117:12]
  wire  _T_33 = 4'h5 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_34 = inImageLeftReg == 32'h0; // @[Accelerator.scala 128:29]
  wire [5:0] _GEN_3 = _T_34 ? 6'h33 : 6'h5; // @[Accelerator.scala 128:38]
  wire  _T_35 = inImageRightReg == 32'h0; // @[Accelerator.scala 129:30]
  wire [5:0] _GEN_4 = _T_35 ? 6'h34 : _GEN_3; // @[Accelerator.scala 129:39]
  wire  _T_36 = inImageTopReg == 32'h0; // @[Accelerator.scala 130:28]
  wire [5:0] _GEN_5 = _T_36 ? 6'h35 : _GEN_4; // @[Accelerator.scala 130:37]
  wire  _T_37 = inImageDownReg == 32'h0; // @[Accelerator.scala 131:29]
  wire [5:0] _GEN_6 = _T_37 ? 6'h36 : _GEN_5; // @[Accelerator.scala 131:38]
  wire  _T_40 = _T_34 | _T_35; // @[Accelerator.scala 135:33]
  wire  _T_42 = _T_40 | _T_36; // @[Accelerator.scala 136:33]
  wire  _T_44 = _T_42 | _T_37; // @[Accelerator.scala 137:33]
  wire [2:0] _T_45 = _T_44 ? 3'h6 : 3'h7; // @[Accelerator.scala 139:22]
  wire [5:0] _GEN_7 = _T_44 ? 6'h2 : _GEN_6; // @[Accelerator.scala 140:33]
  wire  _T_46 = 4'h6 == stateReg; // @[Conditional.scala 37:30]
  wire [36:0] _T_49 = _GEN_116 + _T_11; // @[Accelerator.scala 146:27]
  wire [36:0] _T_51 = _T_49 + 37'h190; // @[Accelerator.scala 146:41]
  wire  _T_52 = debugReg == 32'h2; // @[Accelerator.scala 151:22]
  wire  _T_53 = 4'h7 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_59 = 4'h8 == stateReg; // @[Conditional.scala 37:30]
  wire [31:0] _T_61 = xReg - 32'h1; // @[Accelerator.scala 164:35]
  wire [36:0] _GEN_119 = {{5'd0}, _T_61}; // @[Accelerator.scala 185:21]
  wire [36:0] _T_66 = _GEN_119 + _T_19; // @[Accelerator.scala 185:21]
  wire  _T_69 = 4'h9 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_72 = 4'ha == stateReg; // @[Conditional.scala 37:30]
  wire  _GEN_13 = _T_69 ? 1'h0 : _T_72; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_14 = _T_59 ? _T_66 : {{5'd0}, debugReg}; // @[Conditional.scala 39:67]
  wire  _GEN_19 = _T_59 ? 1'h0 : _GEN_13; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_21 = _T_53 ? _T_51 : _GEN_14; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_22 = _T_53 ? 32'hff : debugRegVal; // @[Conditional.scala 39:67]
  wire  _GEN_27 = _T_53 ? 1'h0 : _GEN_19; // @[Conditional.scala 39:67]
  wire  _GEN_28 = _T_46 | _T_53; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_29 = _T_46 ? _T_51 : _GEN_21; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_30 = _T_46 ? 32'h0 : _GEN_22; // @[Conditional.scala 39:67]
  wire  _GEN_36 = _T_46 ? 1'h0 : _GEN_27; // @[Conditional.scala 39:67]
  wire  _GEN_40 = _T_33 ? 1'h0 : _GEN_28; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_41 = _T_33 ? {{5'd0}, debugReg} : _GEN_29; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_42 = _T_33 ? debugRegVal : _GEN_30; // @[Conditional.scala 39:67]
  wire  _GEN_46 = _T_33 ? 1'h0 : _GEN_36; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_48 = _T_16 ? _T_21 : _GEN_41; // @[Conditional.scala 39:67]
  wire  _GEN_53 = _T_16 ? 1'h0 : _GEN_40; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_54 = _T_16 ? debugRegVal : _GEN_42; // @[Conditional.scala 39:67]
  wire  _GEN_58 = _T_16 ? 1'h0 : _GEN_46; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_59 = _T_8 ? _T_13 : _GEN_48; // @[Conditional.scala 39:67]
  wire  _GEN_67 = _T_8 ? 1'h0 : _GEN_53; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_68 = _T_8 ? debugRegVal : _GEN_54; // @[Conditional.scala 39:67]
  wire  _GEN_72 = _T_8 ? 1'h0 : _GEN_58; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_75 = _T_4 ? {{31'd0}, _T_6[5:0]} : _GEN_59; // @[Conditional.scala 39:67]
  wire  _GEN_83 = _T_4 ? 1'h0 : _GEN_67; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_84 = _T_4 ? debugRegVal : _GEN_68; // @[Conditional.scala 39:67]
  wire  _GEN_86 = _T_4 ? 1'h0 : _GEN_72; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_90 = _T_1 ? {{5'd0}, debugReg} : _GEN_75; // @[Conditional.scala 39:67]
  wire  _GEN_97 = _T_1 ? 1'h0 : _GEN_83; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_98 = _T_1 ? debugRegVal : _GEN_84; // @[Conditional.scala 39:67]
  wire  _GEN_100 = _T_1 ? 1'h0 : _GEN_86; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_106 = _T ? {{5'd0}, debugReg} : _GEN_90; // @[Conditional.scala 40:58]
  assign io_done = _T ? 1'h0 : _GEN_100; // @[Accelerator.scala 36:11 Accelerator.scala 178:15]
  assign io_address = _GEN_106[15:0]; // @[Accelerator.scala 34:14 Accelerator.scala 66:14 Accelerator.scala 185:16 Accelerator.scala 185:16 Accelerator.scala 185:16 Accelerator.scala 146:18 Accelerator.scala 157:18 Accelerator.scala 185:16]
  assign io_writeEnable = _T ? 1'h0 : _GEN_97; // @[Accelerator.scala 33:18 Accelerator.scala 145:22 Accelerator.scala 156:22]
  assign io_dataWrite = _T ? debugRegVal : _GEN_98; // @[Accelerator.scala 35:16 Accelerator.scala 67:16 Accelerator.scala 147:20 Accelerator.scala 158:20]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  xReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  yReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  inImageReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  inImageLeftReg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  inImageRightReg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  inImageTopReg = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  inImageDownReg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  debugReg = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  debugRegVal = _RAND_9[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 4'h0;
    end else if (_T) begin
      if (io_start) begin
        stateReg <= 4'h1;
      end
    end else if (_T_1) begin
      if (_T_2) begin
        stateReg <= 4'h2;
      end else begin
        stateReg <= 4'ha;
      end
    end else if (_T_4) begin
      stateReg <= 4'h3;
    end else if (_T_8) begin
      if (_T_14) begin
        stateReg <= 4'h4;
      end else begin
        stateReg <= 4'h9;
      end
    end else if (_T_16) begin
      if (_T_30) begin
        stateReg <= {{1'd0}, _T_31};
      end else begin
        stateReg <= 4'h8;
      end
    end else if (_T_33) begin
      stateReg <= {{1'd0}, _T_45};
    end else if (_T_46) begin
      stateReg <= 4'h8;
    end else if (_T_53) begin
      stateReg <= 4'h8;
    end else if (_T_59) begin
      stateReg <= 4'h3;
    end else if (_T_69) begin
      stateReg <= 4'h1;
    end else if (_T_72) begin
      stateReg <= 4'ha;
    end
    if (reset) begin
      xReg <= 32'h0;
    end else if (_T) begin
      if (io_start) begin
        xReg <= 32'h0;
      end
    end else if (!(_T_1)) begin
      if (!(_T_4)) begin
        if (!(_T_8)) begin
          if (!(_T_16)) begin
            if (!(_T_33)) begin
              if (!(_T_46)) begin
                if (!(_T_53)) begin
                  if (!(_T_59)) begin
                    if (_T_69) begin
                      xReg <= _T_10;
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      yReg <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (_T_4) begin
          yReg <= 32'h0;
        end else if (!(_T_8)) begin
          if (!(_T_16)) begin
            if (!(_T_33)) begin
              if (!(_T_46)) begin
                if (!(_T_53)) begin
                  if (_T_59) begin
                    yReg <= _T_18;
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      inImageReg <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_4)) begin
          if (!(_T_8)) begin
            if (_T_16) begin
              inImageReg <= inImageTopReg;
            end
          end
        end
      end
    end
    if (reset) begin
      inImageLeftReg <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (_T_4) begin
          inImageLeftReg <= 32'h0;
        end else if (!(_T_8)) begin
          if (!(_T_16)) begin
            if (!(_T_33)) begin
              if (!(_T_46)) begin
                if (!(_T_53)) begin
                  if (_T_59) begin
                    inImageLeftReg <= io_dataRead;
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      inImageRightReg <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_4)) begin
          if (_T_8) begin
            inImageRightReg <= io_dataRead;
          end
        end
      end
    end
    if (reset) begin
      inImageTopReg <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (_T_4) begin
          inImageTopReg <= io_dataRead;
        end else if (!(_T_8)) begin
          if (_T_16) begin
            inImageTopReg <= io_dataRead;
          end
        end
      end
    end
    if (reset) begin
      inImageDownReg <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (_T_4) begin
          inImageDownReg <= 32'h0;
        end else if (_T_8) begin
          inImageDownReg <= inImageReg;
        end
      end
    end
    if (reset) begin
      debugReg <= 32'h0;
    end else if (_T) begin
      if (io_start) begin
        debugReg <= 32'h0;
      end
    end else if (!(_T_1)) begin
      if (!(_T_4)) begin
        if (!(_T_8)) begin
          if (!(_T_16)) begin
            if (_T_33) begin
              debugReg <= {{26'd0}, _GEN_7};
            end else if (_T_46) begin
              if (_T_52) begin
                debugReg <= 32'h3;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      debugRegVal <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_4)) begin
          if (!(_T_8)) begin
            if (!(_T_16)) begin
              if (_T_33) begin
                debugRegVal <= inImageLeftReg;
              end
            end
          end
        end
      end
    end
  end
endmodule
module SystemTop(
  input         clock,
  input         reset,
  input         io_start,
  output        io_done,
  input         io_testerDataMemEnable,
  input  [15:0] io_testerDataMemAddress,
  output [31:0] io_testerDataMemDataRead,
  input         io_testerDataMemWriteEnable,
  input  [31:0] io_testerDataMemDataWrite
);
  wire  dataMemory_clock; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_address; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_writeEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataWrite; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerEnable; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_testerAddress; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerWriteEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataWrite; // @[SystemTop.scala 18:26]
  wire  accelerator_clock; // @[SystemTop.scala 19:27]
  wire  accelerator_reset; // @[SystemTop.scala 19:27]
  wire  accelerator_io_start; // @[SystemTop.scala 19:27]
  wire  accelerator_io_done; // @[SystemTop.scala 19:27]
  wire [31:0] accelerator_io_dataRead; // @[SystemTop.scala 19:27]
  wire [15:0] accelerator_io_address; // @[SystemTop.scala 19:27]
  wire  accelerator_io_writeEnable; // @[SystemTop.scala 19:27]
  wire [31:0] accelerator_io_dataWrite; // @[SystemTop.scala 19:27]
  DataMemory dataMemory ( // @[SystemTop.scala 18:26]
    .clock(dataMemory_clock),
    .io_address(dataMemory_io_address),
    .io_writeEnable(dataMemory_io_writeEnable),
    .io_dataWrite(dataMemory_io_dataWrite),
    .io_dataRead(dataMemory_io_dataRead),
    .io_testerEnable(dataMemory_io_testerEnable),
    .io_testerAddress(dataMemory_io_testerAddress),
    .io_testerDataRead(dataMemory_io_testerDataRead),
    .io_testerWriteEnable(dataMemory_io_testerWriteEnable),
    .io_testerDataWrite(dataMemory_io_testerDataWrite)
  );
  Accelerator accelerator ( // @[SystemTop.scala 19:27]
    .clock(accelerator_clock),
    .reset(accelerator_reset),
    .io_start(accelerator_io_start),
    .io_done(accelerator_io_done),
    .io_dataRead(accelerator_io_dataRead),
    .io_address(accelerator_io_address),
    .io_writeEnable(accelerator_io_writeEnable),
    .io_dataWrite(accelerator_io_dataWrite)
  );
  assign io_done = accelerator_io_done; // @[SystemTop.scala 23:11]
  assign io_testerDataMemDataRead = dataMemory_io_testerDataRead; // @[SystemTop.scala 34:28]
  assign dataMemory_clock = clock;
  assign dataMemory_io_address = accelerator_io_address; // @[SystemTop.scala 28:25]
  assign dataMemory_io_writeEnable = accelerator_io_writeEnable; // @[SystemTop.scala 30:29]
  assign dataMemory_io_dataWrite = accelerator_io_dataWrite; // @[SystemTop.scala 29:27]
  assign dataMemory_io_testerEnable = io_testerDataMemEnable; // @[SystemTop.scala 36:30]
  assign dataMemory_io_testerAddress = io_testerDataMemAddress; // @[SystemTop.scala 33:31]
  assign dataMemory_io_testerWriteEnable = io_testerDataMemWriteEnable; // @[SystemTop.scala 37:35]
  assign dataMemory_io_testerDataWrite = io_testerDataMemDataWrite; // @[SystemTop.scala 35:33]
  assign accelerator_clock = clock;
  assign accelerator_reset = reset;
  assign accelerator_io_start = io_start; // @[SystemTop.scala 24:24]
  assign accelerator_io_dataRead = dataMemory_io_dataRead; // @[SystemTop.scala 27:27]
endmodule
