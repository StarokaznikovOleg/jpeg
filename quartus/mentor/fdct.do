onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/RST
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/CLK
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/ready_pb
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/start_pb
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fdct_sm_settings
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/sof
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/img_size_x
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/img_size_y
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fram1_waddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fram1_we
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fram1_data
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fram1_raddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fram1_q
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fifo1_wr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fifo_data_in
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fifo1_full
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fifo1_empty
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fifo1_count
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fifo1_q
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/fifo1_rd
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/dbuf_waddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/dbuf_we
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/dbuf_data
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/dbuf_raddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/dbuf_q
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/zz_rd_addr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/zz_rden
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_FDCT/zz_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {59953871 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 320
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {60535505 ps} {60747431 ps}
