import chisel3._
import chisel3.util._

class Accelerator extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val done = Output(Bool())

    val dataRead = Input(UInt (32.W))
    val address = Output(UInt (16.W))
    val writeEnable = Output(Bool ())
    val dataWrite = Output(UInt (32.W))

  })
  // states
  // val start :: Nil = Enum(1)
  // registers: x, y, in, 4 nabo, out
  // val stateReg = RegInit(start)


  // --------- minimal compilerbar accelerator --------- //
  val reg1 = RegInit(0.U(16.W))
  val reg2 = RegInit(0.U(16.W))

  reg1 := io.dataRead
  io.writeEnable := false.B
  io.address := 0.U(16.W)
  io.dataWrite := reg1
  io.done := false.B

  reg2 := io.start
  io.done := reg2

}
