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

  // --------- real code --------- //

  // states
  private val (start :: x_loop_start :: y_to_0 :: y_loop_start
    :: border_and_black_pixel :: black_neighbor :: to_black
    :: to_white :: ypp :: xpp :: done :: Nil) = Enum(11)
  // registers: x, y, in, 4 nabo, out
  private val stateReg = RegInit(start)
  private val xReg = RegInit(0.U(32.W));
  private val yReg = RegInit(0.U(32.W));
  private val inImageReg = RegInit(0.U(32.W)); // in_image(x, y)
  private val inImageLeftReg = RegInit(0.U(32.W)); // in_image(x-1, y)
  private val inImageRightReg = RegInit(0.U(32.W)); // in_image(x+1, y)
  private val inImageTopReg = RegInit(0.U(32.W)); // in_image(x, y+1)
  private val inImageDownReg = RegInit(0.U(32.W)); // in_image(x, y-1)

  // FSMD switch
  switch(stateReg) {
    is(start) {
      when(io.start) {
        stateReg := x_loop_start;
      }
    }

    is(x_loop_start) {
      xReg := 0.U
      stateReg := Mux(xReg < 20.U, y_to_0, done);
    }

    is(y_to_0) {
      yReg := 0.U
      stateReg := y_loop_start;
    }

    is(y_loop_start) {
      // this line comes from ypp state, but is pushed to this state to keep ypp 1 cycle long
      inImageTopReg := read(xReg, yReg + 1.U);

      stateReg := Mux(yReg < 20.U, border_and_black_pixel, xpp);
    }

    is(border_and_black_pixel) {
      // this line comes from ypp state, but is pushed to this state to keep ypp 1 cycle long
      inImageTopReg := read(xReg, yReg - 1.U);

      val on_border = (xReg === 0.U || xReg === 19.U || yReg === 0.U || yReg === 19.U);
      val is_black = inImageReg === 0.U;
      stateReg := Mux(!on_border,
        Mux(is_black,
          to_black,
          black_neighbor),
        xpp);
    }

    is(black_neighbor) {
      val has_black_neighbor = (
        inImageLeftReg  === 0.U &&
        inImageRightReg === 0.U &&
        inImageTopReg   === 0.U &&
        inImageDownReg  === 0.U );
      stateReg := Mux(has_black_neighbor, to_black, to_white);
    }

    is(to_black) {
      // A pixel at coordinates (x, y) is stored at the address x + 20 ∗ y in the DataMemory.
      io.writeEnable := true.B
      io.address := (xReg + 20.U * yReg + 400.U) //out image
      io.dataWrite := 255.U

      stateReg := ypp;
    }

    is(to_white) {
      // A pixel at coordinates (x, y) is stored at the address x + 20 ∗ y in the DataMemory.
      io.writeEnable := true.B
      io.address := (xReg + 20.U * yReg + 400.U) //out image
      io.dataWrite := 0.U

      stateReg := ypp;
    }

    is(ypp) {
      yReg := yReg + 1.U
      inImageLeftReg := inImageReg;
      inImageReg := inImageRightReg;
      inImageRightReg := read(xReg + 1.U, yReg);
      // top og down updateres i de efterfølgende states

      stateReg := y_loop_start;
    }

    is(xpp) {
      xReg := xReg + 1.U

      stateReg := x_loop_start;
    }

    is(done) {
      io.done := true.B
      stateReg := done
    }
  }


  private def read(x: UInt, y: UInt): UInt = {
    io.address := x + 20.U * y;
    return io.dataRead;
  }
  /*
  During this phase, the tester reads
  the data memory from address 0 to 799 to retrieve the original image
  and the processed one. The original image is expected to be stored from
  address 0 to 399 as explained earlier. The processed image is expected to
  be stored by your program from address 400 to 799. This means that the
  processed pixel at coordinates (x, y) is stored at the address x+20∗y+400.
  */

}






