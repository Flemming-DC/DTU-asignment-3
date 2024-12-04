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
  /*
  val reg1 = RegInit(0.U(16.W))
  val reg2 = RegInit(0.U(16.W))

  reg1 := io.dataRead
  io.writeEnable := false.B
  io.address := 0.U(16.W)
  io.dataWrite := reg1
  io.done := false.B

  reg2 := io.start
  io.done := reg2
  */
  // --------- real code --------- //
  // defaults
  io.writeEnable := false.B;
  io.address := 0.U(16.W);
  io.dataWrite := 0.U(16.W);
  io.done := false.B

  // states
  val start = 0.U;
  val x_loop_start = 1.U;
  val y_to_0 = 2.U;
  val y_loop_start = 3.U;
  val border_and_black_pixel = 4.U;
  val black_neighbor = 5.U;
  val to_black = 6.U;
  val to_white = 7.U;
  val ypp = 8.U;
  val xpp = 9.U;
  val done = 10.U;

  //val (start :: x_loop_start :: y_to_0 :: y_loop_start // 4
  //  :: border_and_black_pixel :: black_neighbor :: to_black // 7
  //  :: to_white :: ypp :: xpp :: done :: Nil) = Enum(11)
  // registers
  val stateReg = RegInit(start)
  val xReg = RegInit(0.U(32.W));
  val yReg = RegInit(0.U(32.W));
  val inImageReg = RegInit(0.U(32.W)); // in_image(x, y)
  val inImageLeftReg = RegInit(0.U(32.W)); // in_image(x-1, y)
  val inImageRightReg = RegInit(0.U(32.W)); // in_image(x+1, y)
  val inImageTopReg = RegInit(0.U(32.W)); // in_image(x, y+1)
  val inImageDownReg = RegInit(0.U(32.W)); // in_image(x, y-1)

  val debugReg = RegInit(0.U(32.W));
  val debugRegVal = RegInit(0.U(32.W));
  io.address := debugReg;
  io.dataWrite := debugRegVal;

  // FSMD switch
  switch(stateReg) {
    is(start) {
      when(io.start) {
        xReg := 0.U
        stateReg := x_loop_start;
        debugReg := 0.U;

      }
    }

    is(x_loop_start) {
      stateReg := Mux(xReg < 20.U, y_to_0, done);
    }

    is(y_to_0) {
      inImageLeftReg := 0.U;
      inImageReg := read(0.U, 0.U);
      inImageRightReg := read(1.U, 0.U);

      yReg := 0.U
      stateReg := y_loop_start;
    }

    is(y_loop_start) {
      //inImageLeftReg := read(xReg - 1.U, yReg); // inImageReg;
      //inImageReg := read(xReg, yReg); // inImageRightReg;
      //inImageRightReg := read(xReg + 1.U, yReg);
      //inImageTopReg := read(xReg, yReg + 1.U);
      //inImageDownReg := read(xReg, yReg - 1.U);
      // top og down updateres i de efterfølgende states
      inImageRightReg := read(xReg + 1.U, yReg);
      inImageDownReg := inImageReg;

      stateReg := Mux(yReg < 20.U, border_and_black_pixel, xpp);
    }

    is(border_and_black_pixel) {
      // this line comes from ypp state, but is pushed to this state to keep ypp 1 cycle long
      //inImageTopReg := read(xReg, yReg + 1.U);
      //inImageLeftReg := inImageReg;
      //inImageReg := inImageRightReg;
      inImageLeftReg := read(xReg - 1.U, yReg);
      inImageReg := inImageTopReg;

      val on_border = (xReg === 0.U || xReg === 19.U || yReg === 0.U || yReg === 19.U);
      val is_black = inImageReg === 0.U;
      stateReg := Mux(!on_border,
        Mux(is_black,
          to_black,
          black_neighbor),
        ypp);
    }

    is(black_neighbor) {
      // this line comes from ypp state, but is pushed to this state to keep ypp 1 cycle long
      //inImageDownReg := read(xReg, yReg - 1.U);

      debugReg := 5.U;
      when (inImageLeftReg  === 0.U) { debugReg := 51.U }
      when (inImageRightReg  === 0.U) { debugReg := 52.U }
      when (inImageTopReg  === 0.U) { debugReg := 53.U }
      when (inImageDownReg  === 0.U) { debugReg := 54.U }
      debugRegVal := inImageLeftReg;

      val has_black_neighbor = (
        inImageLeftReg  === 0.U ||
        inImageRightReg === 0.U ||
        inImageTopReg   === 0.U ||
        inImageDownReg  === 0.U );
      stateReg := Mux(has_black_neighbor, to_black, to_white);
      when (has_black_neighbor) { debugReg := 2.U }
    }

    is(to_black) {
      // A pixel at coordinates (x, y) is stored at the address x + 20 ∗ y in the DataMemory.
      io.writeEnable := true.B
      io.address := (xReg + 20.U * yReg + 400.U) //out image
      io.dataWrite := 0.U // Erode

      stateReg := ypp;

      when (debugReg === 2.U) { debugReg := 3.U }
    }

    is(to_white) {
      // A pixel at coordinates (x, y) is stored at the address x + 20 ∗ y in the DataMemory.
      io.writeEnable := true.B
      io.address := (xReg + 20.U * yReg + 400.U) //out image
      io.dataWrite := 255.U

      stateReg := ypp;
    }

    is(ypp) {
      inImageTopReg := read(xReg, yReg + 1.U);

      yReg := yReg + 1.U

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






