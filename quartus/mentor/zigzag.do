onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/RST
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/CLK
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/start_pb
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/ready_pb
add wave -noupdate -radix hexadecimal -childformat {{/jpeg_tb/U_JpegEnc/U_ZZ_TOP/zig_sm_settings.x_cnt -radix hexadecimal} {/jpeg_tb/U_JpegEnc/U_ZZ_TOP/zig_sm_settings.y_cnt -radix hexadecimal} {/jpeg_tb/U_JpegEnc/U_ZZ_TOP/zig_sm_settings.cmp_idx -radix hexadecimal}} -subitemconfig {/jpeg_tb/U_JpegEnc/U_ZZ_TOP/zig_sm_settings.x_cnt {-radix hexadecimal} /jpeg_tb/U_JpegEnc/U_ZZ_TOP/zig_sm_settings.y_cnt {-radix hexadecimal} /jpeg_tb/U_JpegEnc/U_ZZ_TOP/zig_sm_settings.cmp_idx {-radix hexadecimal}} /jpeg_tb/U_JpegEnc/U_ZZ_TOP/zig_sm_settings
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/fdct_buf_sel
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/fdct_rd_addr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/fdct_data
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/fdct_rden
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/U_zigzag/fifo_data_in
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/U_zigzag/fifo_wr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/U_zigzag/fifo_count
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/U_zigzag/fifo_empty
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/U_zigzag/fifo_full
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/U_zigzag/fifo_rden
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/U_zigzag/fifo_q
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/dbuf_waddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/dbuf_we
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/dbuf_data
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/dbuf_raddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/dbuf_q
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/qua_buf_sel
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/qua_rdaddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/U_ZZ_TOP/qua_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60551416 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 393
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
WaveRestoreZoom {60514872 ps} {60981489 ps}
