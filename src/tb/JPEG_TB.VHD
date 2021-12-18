-------------------------------------------------------------------------------
-- Title       : Testbench top-level
-- Design      : JPEG
-- Author      : Starokaznikov OV
-- Company     : Protei
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;  

library STD;
use STD.TEXTIO.ALL;  

library work;
use work.GPL_V2_Image_Pkg.ALL;
use WORK.MDCT_PKG.all;
use WORK.MDCTTB_PKG.all;
use work.JPEG_PKG.all;

entity JPEG_TB is
end JPEG_TB;

architecture TB of JPEG_TB is
	
	constant raw_file_source    : string := "test2.raw";	
	constant raw_h_size     	: integer := 640;	
	constant raw_v_size     	: integer := 480;	
	
	constant RAW_OUT     		: string := "test_out.raw";
	constant JTAG_OUT    		: string := "test_out.jpg";
	
	type char_file is file of character;
	file f_raw_bin       	: char_file;
	file f_JTAG_OUT      	: char_file;   
	
	signal RST,CLK : STD_LOGIC;
	signal sof,jpeg_ready,jpeg_busy : STD_LOGIC;
	signal image_hsize,image_vsize : std_logic_vector(15 downto 0);
	
	signal ram_byte          : std_logic_vector(7 downto 0);
	signal ram_wren          : std_logic;
	
	signal iram_waddr        : std_logic_vector(19 downto 0);
	signal iram_raddr        : std_logic_vector(19 downto 0);
	signal iram_wdata        : std_logic_vector(C_PIXEL_BITS-1 downto 0);
	signal iram_rdata        : std_logic_vector(C_PIXEL_BITS-1 downto 0);
	signal iram_wren         : std_logic;
	signal iram_rden         : std_logic;     
	signal sim_done          : std_logic;
	signal iram_fifo_afull   : std_logic;
	signal outif_almost_full : std_logic;
	--	signal count1            : integer range 0 to ((2**16)-1); --unsigned(15 downto 0);
begin
	------------------------------
	-- CLKGEN map
	U_ClkGen : entity work.ClkGen 
	port map
		(
		CLK            => CLK,                                              
		RST            => RST
		);
	------------------------------
	-- HOST Bus Functional Model
	U_HostBFM : entity work.HostBFM	 
	generic map( raw_file=>raw_file_source, h_size=>raw_h_size, v_size=>raw_v_size )
	port map
		(
		CLK            => CLK,
		RST            => RST,
		sof => sof,
		jpeg_ready => jpeg_ready,
		jpeg_busy => jpeg_busy,
		
		-- IRAM
		iram_wdata     => iram_wdata,
		iram_wren      => iram_wren,
		fifo_almost_full => iram_fifo_afull,
		
		sim_done       => sim_done
		);	 
		
	image_hsize<=conv_std_logic_vector(raw_h_size,16);	
	image_vsize<=conv_std_logic_vector(raw_v_size,16);	
	------------------------------
	-- JPEG ENCODER
	U_JpegEnc : entity work.JpegEnc
	port map
		(
		RST                => RST,
		CLK                => CLK,
		sof => sof,
		jpeg_ready => jpeg_ready,
		jpeg_busy => jpeg_busy,
		image_hsize=>image_hsize,
		image_vsize=>image_vsize,
		
		-- IMAGE RAM
		iram_wdata         => iram_wdata,
		iram_wren          => iram_wren,
		iram_fifo_afull    => iram_fifo_afull,
		
		-- OUT RAM
		ram_byte           => ram_byte,
		ram_wren           => ram_wren,  
--		ram_wraddr         => ram_wraddr,
		outif_almost_full  => outif_almost_full
		);
	
	p_capture : process
		variable fLine           : line;
		variable fLine_bin       : line;
	begin
		file_open(f_JTAG_OUT, JTAG_OUT, write_mode);
		file_open(f_raw_bin, RAW_OUT, write_mode);
		
		while sim_done /= '1' loop
			wait until rising_edge(CLK);
			
			if ram_wren = '1' then
				hwrite(fLine, ram_byte);
				write(fLine, string'(" "));
				write(f_JTAG_OUT, CHARACTER'VAL(conv_integer(ram_byte)));
			end if; 
			
			if iram_wren = '1' then
				write(f_raw_bin, CHARACTER'VAL(conv_integer(iram_wdata(7 downto 0))));
				write(f_raw_bin, CHARACTER'VAL(conv_integer(iram_wdata(15 downto 8))));
				write(f_raw_bin, CHARACTER'VAL(conv_integer(iram_wdata(23 downto 16))));
			end if; 
			
		end loop;
		file_close(f_JTAG_OUT);
		file_close(f_raw_bin);
		
		wait;  
	end process;
	
	outif_almost_full <= '0';
	----	backpressure : process(CLK, RST)
	----	begin
	----		if RST = '1' then
	----			outif_almost_full <= '0';
	----			count1 <= 0;
	----		elsif CLK'event and CLK = '1' then
	----			--if count1 = 10000 then
	----			--  count1 <= (others => '0');
	----			--  outif_almost_full <= not outif_almost_full;
	----			--else
	----			--  count1 <= count1 + 1;
	----			--end if;
	----		end if;
	----	end process;
	
end TB;
