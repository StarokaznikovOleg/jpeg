onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/CLK
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/RST
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/iram_fifo_afull
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/outif_almost_full
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/iram_wren
add wave -noupdate -radix hexadecimal -childformat {{/jpeg_tb/U_JpegEnc/iram_wdata(23) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(22) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(21) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(20) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(19) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(18) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(17) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(16) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(15) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(14) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(13) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(12) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(11) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(10) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(9) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(8) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(7) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(6) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(5) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(4) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(3) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(2) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(1) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/iram_wdata(0) -radix hexadecimal}} -subitemconfig {/jpeg_tb/U_JpegEnc/iram_wdata(23) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(22) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(21) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(20) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(19) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(18) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(17) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(16) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(15) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(14) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(13) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(12) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(11) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(10) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(9) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(8) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(7) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(6) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(5) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(4) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(3) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(2) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(1) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/iram_wdata(0) {-height 15 -radix hexadecimal}} /jpeg_tb/U_JpegEnc/iram_wdata
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/fdct_fifo_q
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/fdct_fifo_rd
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/zz_rd_addr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/zz_rden
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/zz_data
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/qua_rdaddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/qua_data
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/rle_rdaddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/rle_data
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/huf_fifo_empty
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/huf_rden
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/huf_amplitude
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/huf_size
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/huf_runlength
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/bs_buf_sel
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/bs_fifo_empty
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/bs_packed_byte
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/bs_rd_req
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/ram_wraddr
add wave -noupdate -radix hexadecimal /jpeg_tb/U_JpegEnc/ram_wren
add wave -noupdate -radix hexadecimal -childformat {{/jpeg_tb/U_JpegEnc/ram_byte(7) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/ram_byte(6) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/ram_byte(5) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/ram_byte(4) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/ram_byte(3) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/ram_byte(2) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/ram_byte(1) -radix hexadecimal} {/jpeg_tb/U_JpegEnc/ram_byte(0) -radix hexadecimal}} -subitemconfig {/jpeg_tb/U_JpegEnc/ram_byte(7) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/ram_byte(6) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/ram_byte(5) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/ram_byte(4) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/ram_byte(3) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/ram_byte(2) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/ram_byte(1) {-height 15 -radix hexadecimal} /jpeg_tb/U_JpegEnc/ram_byte(0) {-height 15 -radix hexadecimal}} /jpeg_tb/U_JpegEnc/ram_byte
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {62763605 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 234
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
WaveRestoreZoom {62942931 ps} {63435689 ps}
