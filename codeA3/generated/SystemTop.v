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
`endif // RANDOMIZE_REG_INIT
  reg [15:0] reg1; // @[Accelerator.scala 18:21]
  reg [15:0] reg2; // @[Accelerator.scala 19:21]
  reg [3:0] _T; // @[Accelerator.scala 37:33]
  reg [31:0] _T_1; // @[Accelerator.scala 38:29]
  reg [31:0] _T_2; // @[Accelerator.scala 39:29]
  reg [31:0] _T_3; // @[Accelerator.scala 40:35]
  reg [31:0] _T_4; // @[Accelerator.scala 41:39]
  reg [31:0] _T_5; // @[Accelerator.scala 42:40]
  reg [31:0] _T_6; // @[Accelerator.scala 43:38]
  wire  _T_8 = 4'h0 == _T; // @[Conditional.scala 37:30]
  wire  _T_9 = 4'h1 == _T; // @[Conditional.scala 37:30]
  wire  _T_10 = _T_1 < 32'h14; // @[Accelerator.scala 56:28]
  wire  _T_12 = 4'h2 == _T; // @[Conditional.scala 37:30]
  wire  _T_13 = 4'h3 == _T; // @[Conditional.scala 37:30]
  wire [31:0] _T_15 = _T_2 + 32'h1; // @[Accelerator.scala 66:40]
  wire [36:0] _T_16 = 32'h14 * _T_15; // @[Accelerator.scala 135:28]
  wire [36:0] _GEN_99 = {{5'd0}, _T_1}; // @[Accelerator.scala 135:21]
  wire [36:0] _T_18 = _GEN_99 + _T_16; // @[Accelerator.scala 135:21]
  wire  _T_19 = _T_2 < 32'h14; // @[Accelerator.scala 68:28]
  wire  _T_21 = 4'h4 == _T; // @[Conditional.scala 37:30]
  wire [31:0] _T_23 = _T_2 - 32'h1; // @[Accelerator.scala 73:40]
  wire [36:0] _T_24 = 32'h14 * _T_23; // @[Accelerator.scala 135:28]
  wire [36:0] _T_26 = _GEN_99 + _T_24; // @[Accelerator.scala 135:21]
  wire  _T_27 = _T_1 == 32'h0; // @[Accelerator.scala 75:29]
  wire  _T_28 = _T_1 == 32'h13; // @[Accelerator.scala 75:45]
  wire  _T_29 = _T_27 | _T_28; // @[Accelerator.scala 75:37]
  wire  _T_30 = _T_2 == 32'h0; // @[Accelerator.scala 75:62]
  wire  _T_31 = _T_29 | _T_30; // @[Accelerator.scala 75:54]
  wire  _T_32 = _T_2 == 32'h13; // @[Accelerator.scala 75:78]
  wire  _T_33 = _T_31 | _T_32; // @[Accelerator.scala 75:70]
  wire  _T_34 = _T_3 == 32'h0; // @[Accelerator.scala 76:33]
  wire  _T_35 = ~_T_33; // @[Accelerator.scala 77:23]
  wire  _T_38 = 4'h5 == _T; // @[Conditional.scala 37:30]
  wire  _T_39 = _T_4 == 32'h0; // @[Accelerator.scala 86:25]
  wire  _T_40 = _T_5 == 32'h0; // @[Accelerator.scala 87:25]
  wire  _T_41 = _T_39 & _T_40; // @[Accelerator.scala 86:33]
  wire  _T_42 = _T_6 == 32'h0; // @[Accelerator.scala 88:25]
  wire  _T_43 = _T_41 & _T_42; // @[Accelerator.scala 87:33]
  wire  _T_47 = 4'h6 == _T; // @[Conditional.scala 37:30]
  wire [36:0] _T_48 = 32'h14 * _T_2; // @[Accelerator.scala 96:34]
  wire [36:0] _T_50 = _GEN_99 + _T_48; // @[Accelerator.scala 96:27]
  wire [36:0] _T_52 = _T_50 + 37'h190; // @[Accelerator.scala 96:41]
  wire  _T_53 = 4'h7 == _T; // @[Conditional.scala 37:30]
  wire  _T_59 = 4'h8 == _T; // @[Conditional.scala 37:30]
  wire [31:0] _T_63 = _T_1 + 32'h1; // @[Accelerator.scala 115:36]
  wire [36:0] _GEN_103 = {{5'd0}, _T_63}; // @[Accelerator.scala 135:21]
  wire [36:0] _T_66 = _GEN_103 + _T_48; // @[Accelerator.scala 135:21]
  wire  _T_67 = 4'h9 == _T; // @[Conditional.scala 37:30]
  wire  _T_70 = 4'ha == _T; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_1 = _T_70 ? 16'h1 : reg2; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_5 = _T_67 ? reg2 : _GEN_1; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_9 = _T_59 ? _T_66 : 37'h0; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_13 = _T_59 ? reg2 : _GEN_5; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_15 = _T_53 ? _T_52 : _GEN_9; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_16 = _T_53 ? 16'h0 : reg1; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_23 = _T_53 ? reg2 : _GEN_13; // @[Conditional.scala 39:67]
  wire  _GEN_24 = _T_47 | _T_53; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_25 = _T_47 ? _T_52 : _GEN_15; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_26 = _T_47 ? 16'hff : _GEN_16; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_33 = _T_47 ? reg2 : _GEN_23; // @[Conditional.scala 39:67]
  wire  _GEN_35 = _T_38 ? 1'h0 : _GEN_24; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_36 = _T_38 ? 37'h0 : _GEN_25; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_37 = _T_38 ? reg1 : _GEN_26; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_43 = _T_38 ? reg2 : _GEN_33; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_44 = _T_21 ? _T_26 : _GEN_36; // @[Conditional.scala 39:67]
  wire  _GEN_47 = _T_21 ? 1'h0 : _GEN_35; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_48 = _T_21 ? reg1 : _GEN_37; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_54 = _T_21 ? reg2 : _GEN_43; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_55 = _T_13 ? _T_18 : _GEN_44; // @[Conditional.scala 39:67]
  wire  _GEN_58 = _T_13 ? 1'h0 : _GEN_47; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_59 = _T_13 ? reg1 : _GEN_48; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_65 = _T_13 ? reg2 : _GEN_54; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_68 = _T_12 ? 37'h0 : _GEN_55; // @[Conditional.scala 39:67]
  wire  _GEN_70 = _T_12 ? 1'h0 : _GEN_58; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_71 = _T_12 ? reg1 : _GEN_59; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_76 = _T_12 ? reg2 : _GEN_65; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_80 = _T_9 ? 37'h0 : _GEN_68; // @[Conditional.scala 39:67]
  wire  _GEN_82 = _T_9 ? 1'h0 : _GEN_70; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_83 = _T_9 ? reg1 : _GEN_71; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_87 = _T_9 ? reg2 : _GEN_76; // @[Conditional.scala 39:67]
  wire [36:0] _GEN_91 = _T_8 ? 37'h0 : _GEN_80; // @[Conditional.scala 40:58]
  wire [15:0] _GEN_94 = _T_8 ? reg1 : _GEN_83; // @[Conditional.scala 40:58]
  wire [15:0] _GEN_98 = _T_8 ? reg2 : _GEN_87; // @[Conditional.scala 40:58]
  assign io_done = _GEN_98[0]; // @[Accelerator.scala 25:11 Accelerator.scala 28:11 Accelerator.scala 128:15]
  assign io_address = _GEN_91[15:0]; // @[Accelerator.scala 23:14 Accelerator.scala 135:16 Accelerator.scala 135:16 Accelerator.scala 96:18 Accelerator.scala 105:18 Accelerator.scala 135:16]
  assign io_writeEnable = _T_8 ? 1'h0 : _GEN_82; // @[Accelerator.scala 22:18 Accelerator.scala 95:22 Accelerator.scala 104:22]
  assign io_dataWrite = {{16'd0}, _GEN_94}; // @[Accelerator.scala 24:16 Accelerator.scala 97:20 Accelerator.scala 106:20]
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
  reg1 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  reg2 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  _T = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  _T_1 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  _T_2 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  _T_3 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  _T_4 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  _T_5 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  _T_6 = _RAND_8[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      reg1 <= 16'h0;
    end else begin
      reg1 <= io_dataRead[15:0];
    end
    if (reset) begin
      reg2 <= 16'h0;
    end else begin
      reg2 <= {{15'd0}, io_start};
    end
    if (reset) begin
      _T <= 4'h0;
    end else if (_T_8) begin
      if (io_start) begin
        _T <= 4'h1;
      end
    end else if (_T_9) begin
      if (_T_10) begin
        _T <= 4'h2;
      end else begin
        _T <= 4'ha;
      end
    end else if (_T_12) begin
      _T <= 4'h3;
    end else if (_T_13) begin
      if (_T_19) begin
        _T <= 4'h4;
      end else begin
        _T <= 4'h9;
      end
    end else if (_T_21) begin
      if (_T_35) begin
        if (_T_34) begin
          _T <= 4'h6;
        end else begin
          _T <= 4'h5;
        end
      end else begin
        _T <= 4'h9;
      end
    end else if (_T_38) begin
      if (_T_43) begin
        _T <= 4'h6;
      end else begin
        _T <= 4'h7;
      end
    end else if (_T_47) begin
      _T <= 4'h8;
    end else if (_T_53) begin
      _T <= 4'h8;
    end else if (_T_59) begin
      _T <= 4'h3;
    end else if (_T_67) begin
      _T <= 4'h1;
    end else if (_T_70) begin
      _T <= 4'ha;
    end
    if (reset) begin
      _T_1 <= 32'h0;
    end else if (!(_T_8)) begin
      if (_T_9) begin
        _T_1 <= 32'h0;
      end else if (!(_T_12)) begin
        if (!(_T_13)) begin
          if (!(_T_21)) begin
            if (!(_T_38)) begin
              if (!(_T_47)) begin
                if (!(_T_53)) begin
                  if (!(_T_59)) begin
                    if (_T_67) begin
                      _T_1 <= _T_63;
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
      _T_2 <= 32'h0;
    end else if (!(_T_8)) begin
      if (!(_T_9)) begin
        if (_T_12) begin
          _T_2 <= 32'h0;
        end else if (!(_T_13)) begin
          if (!(_T_21)) begin
            if (!(_T_38)) begin
              if (!(_T_47)) begin
                if (!(_T_53)) begin
                  if (_T_59) begin
                    _T_2 <= _T_15;
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      _T_3 <= 32'h0;
    end else if (!(_T_8)) begin
      if (!(_T_9)) begin
        if (!(_T_12)) begin
          if (!(_T_13)) begin
            if (!(_T_21)) begin
              if (!(_T_38)) begin
                if (!(_T_47)) begin
                  if (!(_T_53)) begin
                    if (_T_59) begin
                      _T_3 <= _T_5;
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
      _T_4 <= 32'h0;
    end else if (!(_T_8)) begin
      if (!(_T_9)) begin
        if (!(_T_12)) begin
          if (!(_T_13)) begin
            if (!(_T_21)) begin
              if (!(_T_38)) begin
                if (!(_T_47)) begin
                  if (!(_T_53)) begin
                    if (_T_59) begin
                      _T_4 <= _T_3;
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
      _T_5 <= 32'h0;
    end else if (!(_T_8)) begin
      if (!(_T_9)) begin
        if (!(_T_12)) begin
          if (!(_T_13)) begin
            if (!(_T_21)) begin
              if (!(_T_38)) begin
                if (!(_T_47)) begin
                  if (!(_T_53)) begin
                    if (_T_59) begin
                      _T_5 <= io_dataRead;
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
      _T_6 <= 32'h0;
    end else if (!(_T_8)) begin
      if (!(_T_9)) begin
        if (!(_T_12)) begin
          if (_T_13) begin
            _T_6 <= io_dataRead;
          end else if (_T_21) begin
            _T_6 <= io_dataRead;
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
