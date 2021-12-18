# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
 set PROJDIR C:/hw/JPEG
 set QSYS_SIMDIR $PROJDIR/quartus
# #
# # Source the generated IP simulation script.
 source $QSYS_SIMDIR/mentor/msim_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
# #
# # Call command to compile the Quartus EDA simulation library.
 dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
 com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #

#  vcom -check_synthesis -work work $PROJDIR/src/BufFifo/SUB_RAMZ.VHD
#  vlog -vlog01compat -work work $PROJDIR/src/JFIFGen/HeaderRAM.v
#  vcom -check_synthesis -work work $PROJDIR/src/mdct/RAM.VHD
#  vcom -check_synthesis -work work $PROJDIR/src/common/RAMZ.VHD
#  vcom -check_synthesis -work work $PROJDIR/src/common/FIFO.vhd

  vlog -vlog01compat -work work $PROJDIR/ip/fifo_FDCT/sim/fifo_FDCT.v
  vlog -vlog01compat -work work $PROJDIR/ip/fifo_huffman/sim/fifo_huffman.v
  vlog -vlog01compat -work work $PROJDIR/ip/fifo_rle/sim/fifo_rle.v
  vlog -vlog01compat -work work $PROJDIR/ip/fifo_ZIGZAG/sim/fifo_ZIGZAG.v
  vlog -vlog01compat -work work $PROJDIR/ip/ram_DBUF/sim/ram_DBUF.v
  vlog -vlog01compat -work work $PROJDIR/ip/ram_FRAM1/sim/ram_FRAM1.v
  vlog -vlog01compat -work work $PROJDIR/ip/ram_header/sim/ram_header.v
  vlog -vlog01compat -work work $PROJDIR/ip/ram_MDCT/sim/ram_MDCT.v
  vlog -vlog01compat -work work $PROJDIR/ip/ram_picture/sim/ram_picture.v
  vlog -vlog01compat -work work $PROJDIR/ip/ram_RAMQ/sim/ram_RAMQ.v

  vcom -check_synthesis -work work $PROJDIR/src/common/SingleSM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/common/JPEG_PKG.vhd
  vcom -check_synthesis -work work $PROJDIR/src/zigzag/ZIGZAG.VHD
  vcom -check_synthesis -work work $PROJDIR/src/zigzag/ZZ_TOP.VHD
  vcom -check_synthesis -work work $PROJDIR/src/rle/RleDoubleFifo.vhd
  vcom -check_synthesis -work work $PROJDIR/src/rle/RLE.VHD
  vcom -check_synthesis -work work $PROJDIR/src/rle/RLE_TOP.VHD
  vcom -check_synthesis -work work $PROJDIR/src/quantizer/ROMR.vhd
  vcom -check_synthesis -work work $PROJDIR/src/quantizer/ROMQ.vhd
  vcom -check_synthesis -work work $PROJDIR/src/quantizer/s_divider.vhd
  vcom -check_synthesis -work work $PROJDIR/src/quantizer/r_divider.vhd
  vcom -check_synthesis -work work $PROJDIR/src/quantizer/QUANTIZER.vhd
  vcom -check_synthesis -work work $PROJDIR/src/quantizer/QUANT_TOP.VHD
  vcom -check_synthesis -work work $PROJDIR/src/outmux/OutMux.vhd
  vcom -check_synthesis -work work $PROJDIR/src/mdct/MDCT_PKG.vhd
  vcom -check_synthesis -work work $PROJDIR/src/mdct/ROMO.VHD
  vcom -check_synthesis -work work $PROJDIR/src/mdct/ROME.VHD


  vcom -check_synthesis -work work $PROJDIR/src/mdct/DCT2D.VHD
  vcom -check_synthesis -work work $PROJDIR/src/mdct/DCT1D.vhd
  vcom -check_synthesis -work work $PROJDIR/src/mdct/DBUFCTL.VHD
  vcom -check_synthesis -work work $PROJDIR/src/mdct/MDCT.VHD
  vcom -check_synthesis -work work $PROJDIR/src/mdct/FDCT.vhd
  vcom -check_synthesis -work work $PROJDIR/src/JFIFGen/JFIFGen.vhd
  vcom -check_synthesis -work work $PROJDIR/src/iramif/IRAMIF.vhd
  vcom -check_synthesis -work work $PROJDIR/src/huffman/DoubleFifo.vhd
  vcom -check_synthesis -work work $PROJDIR/src/huffman/DC_ROM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/huffman/DC_CR_ROM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/huffman/AC_ROM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/huffman/AC_CR_ROM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/huffman/Huffman.vhd
  vcom -check_synthesis -work work $PROJDIR/src/hostif/HostIF.vhd
  vcom -check_synthesis -work work $PROJDIR/src/control/CtrlSM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/bytestuffer/ByteStuffer.vhd
  vcom -check_synthesis -work work $PROJDIR/src/BufFifo/SUB_FIFO.vhd
  vcom -check_synthesis -work work $PROJDIR/src/BufFifo/BUF_FIFO.vhd
  vcom -check_synthesis -work work $PROJDIR/src/top/JpegEnc.vhd
  vcom -check_synthesis -work work $PROJDIR/src/tb/RAMSIM.VHD
  vcom -check_synthesis -work work $PROJDIR/src/tb/MDCTTB_PKG.vhd
  vcom -check_synthesis -work work $PROJDIR/src/tb/GPL_V2_Image_pkg.vhd
  vcom -check_synthesis -work work $PROJDIR/src/tb/HostBFM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/tb/DCT_TROM.vhd
  vcom -check_synthesis -work work $PROJDIR/src/tb/ClkGen.vhd
  vcom -check_synthesis -work work $PROJDIR/src/tb/JPEG_TB.VHD
  
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
 set TOP_LEVEL_NAME JPEG_TB
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
 elab
# #
# # Run the simulation.
# add wave *
 view structure
 view signals
# run -a
# #
# # Report success to the shell.
# exit -code 0
