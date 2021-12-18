-------------------------------------------------------------------------------
-- Title       : HostBFM
-- Design      : JPEG
-- Author      : Starokaznikov OV
-- Company     : Protei
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_TEXTIO.ALL;

library STD;
use STD.TEXTIO.ALL;  

library work;
use work.GPL_V2_Image_Pkg.ALL;
use WORK.MDCT_PKG.all;
use WORK.MDCTTB_PKG.all;
use work.JPEG_PKG.all;  

entity HostBFM is
	generic( raw_file : string:="test.raw"; h_size : integer:=640; v_size : integer:=480);
	port 
		(
		RST,CLK : in  std_logic;
		sof : out std_logic;
		jpeg_ready,jpeg_busy : in  std_logic;
		
		-- HOST DATA
		iram_wdata          : out std_logic_vector(C_PIXEL_BITS-1 downto 0);
		iram_wren           : out std_logic;
		fifo_almost_full    : in  std_logic; 
		
		sim_done           : out std_logic
		);
end entity HostBFM;

architecture RTL of HostBFM is
	
	signal num_comps   : integer;
	signal addr_inc    : integer := 0;
begin
	
	p_code : process
		
		--------------------------------------
		-- read text image data
		--------------------------------------
		procedure read_image is
			subtype byte is character;
			type binfile is file of byte;
			file infile : binfile;
			variable b : byte;
			variable s : std_logic_vector(7 downto 0);
			variable data_out  : std_logic_vector(31 downto 0);
			constant N           : integer := 8;
			constant MAX_COMPS   : integer := 3;
			variable inline      : LINE;
			variable tmp_int     : INTEGER := 0;
			variable y_size      : INTEGER := 0;
			variable x_size      : INTEGER := 0;
			variable matrix      : I_MATRIX_TYPE;
			variable x_blk_cnt   : INTEGER := 0;
			variable y_blk_cnt   : INTEGER := 0;
			variable n_lines_arr : N_LINES_TYPE;
			variable line_n      : INTEGER := 0;
			variable pix_n       : INTEGER := 0;
			variable x_n         : INTEGER := 0;
			variable y_n         : INTEGER := 0;
			variable data_word   : unsigned(31 downto 0);
			variable image_line  : STD_LOGIC_VECTOR(0 to MAX_COMPS*MAX_IMAGE_SIZE_X*IP_W-1);
			
			constant C_IMAGE_RAM_BASE : unsigned(31 downto 0) := X"0010_0000";
			
			variable x_cnt       : integer;
			variable data_word2  : unsigned(31 downto 0);
			variable num_comps_v : integer;
		begin
			num_comps_v:=3;
			y_size:=v_size;
			x_size:=h_size;	   
			
			num_comps <= num_comps_v;
			File_Open (infile, raw_file, read_mode);
			
			if y_size rem N > 0 then
				assert false
				report "ERROR: Image height dimension is not multiply of 8!"
				severity Failure;
			end if;
			if x_size rem N > 0 then
				assert false
				report "ERROR: Image width dimension is not multiply of 8!"
				severity Failure;
			end if;
			
			if x_size > C_MAX_LINE_WIDTH then
				assert false
				report "ERROR: Image width bigger than C_MAX_LINE_WIDTH in JPEG_PKG.VHD! " &
				"Increase C_MAX_LINE_WIDTH accordingly"
				severity Failure;
			end if;
			
			addr_inc <= 0;
			iram_wren <= '0';  
			
			while (not EndFile (infile)) loop
				Read (infile, B);
				s:=std_logic_vector (to_unsigned (byte'pos(B), s'length));  
				data_out(7 downto 0):= s;
				Read (infile, B);
				s := std_logic_vector (to_unsigned (byte'pos(B), s'length));  
				data_out(15 downto 8):=s;
				Read (infile, B);
				s := std_logic_vector (to_unsigned (byte'pos(B), s'length));  
				data_out(23 downto 16) := s;
				iram_wren  <= '0';
				iram_wdata <= (others => 'X');
				while(fifo_almost_full = '1') loop
					wait until rising_edge(clk);
				end loop;
				iram_wren <= '1';
				iram_wdata <= data_out(C_PIXEL_BITS-1 downto 0);
				wait until rising_edge(clk);
				addr_inc <= addr_inc + 1;
			end loop;
			iram_wren <= '0';
			File_Close (infile);
			
		end read_image; 
		
		type ROMQ_TYPE is array (0 to 64-1) 
		of unsigned(7 downto 0);
		
		constant qrom_lum : ROMQ_TYPE := 
		(
		-- 100%	luminance	   --20ms
		--		others => X"01"
		
		-- 85% luminance	 --9ms
		--		X"05", X"03", X"04", X"04",	X"04", X"03", X"05", X"04", 
		--		X"04", X"04", X"05", X"05",	X"05", X"06", X"07", X"0C",
		--		X"08", X"07", X"07", X"07",	X"07", X"0F", X"0B", X"0B", 
		--		X"09", X"0C", X"11", X"0F",	X"12", X"12", X"11", X"0F",
		--		X"11", X"11", X"13", X"16",	X"1C", X"17", X"13", X"14", 
		--		X"1A", X"15", X"11", X"11",	X"18", X"21", X"18", X"1A",
		--		X"1D", X"1D", X"1F", X"1F",	X"1F", X"13", X"17", X"22", 
		--		X"24", X"22", X"1E", X"24",	X"1C", X"1E", X"1F", X"1E"
		
		-- 75% luminance   --9ms
		X"08", X"06", X"06", X"07", X"06", X"05", X"08", X"07", 
		X"07", X"07", X"09", X"09", X"08", X"0A", X"0C", X"14",
		X"0D", X"0C", X"0B", X"0B", X"0C", X"19", X"12", X"13", 
		X"0F", X"14", X"1D", X"1A", X"1F", X"1E", X"1D", X"1A",
		X"1C", X"1C", X"20", X"24", X"2E", X"27", X"20", X"22", 
		X"2C", X"23", X"1C", X"1C", X"28", X"37", X"29", X"2C",
		X"30", X"31", X"34", X"34", X"34", X"1F", X"27", X"39", 
		X"3D", X"38", X"32", X"3C", X"2E", X"33", X"34", X"32"
		
		-- 50% luminance
		--		X"10", X"0B", X"0C", X"0E", X"0C", X"0A", X"10", X"0E", 
		--		X"0D", X"0E", X"12", X"11", X"10", X"13", X"18", X"28",
		--		X"1A", X"18", X"16", X"16", X"18", X"31", X"23", X"25", 
		--		X"1D", X"28", X"3A", X"33", X"3D", X"3C", X"39", X"33",
		--		X"38", X"37", X"40", X"48", X"5C", X"4E", X"40", X"44", 
		--		X"57", X"45", X"37", X"38", X"50", X"6D", X"51", X"57",
		--		X"5F", X"62", X"67", X"68", X"67", X"3E", X"4D", X"71", 
		--		X"79", X"70", X"64", X"78", X"5C", X"65", X"67", X"63"
		
		-- 15 %	luminance
		--		X"35", X"25", X"28", X"2F", X"28", X"21", X"35", X"2F", 
		--		X"2B", X"2F", X"3C", X"39", X"35", X"3F", X"50", X"85", 
		--		X"57", X"50", X"49", X"49", X"50", X"A3", X"75", X"7B", 
		--		X"61", X"85", X"C1", X"AA", X"CB", X"C8", X"BE", X"AA", 
		--		X"BA", X"B7", X"D5", X"F0", X"FF", X"FF", X"D5", X"E2", 
		--		X"FF", X"E6", X"B7", X"BA", X"FF", X"FF", X"FF", X"FF", 
		--		X"FF", X"FF", X"FF", X"FF", X"FF", X"CE", X"FF", X"FF", 
		--		X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF"      
		
		);
		
		constant qrom_chr : ROMQ_TYPE := 
		(
		-- 100%	chrominance
		--		others => X"01"		   
		
		-- 85% chrominance
		--		X"05", X"03", X"04", X"04",	X"04", X"03", X"05", X"04", 
		--		X"04", X"04", X"05", X"05",	X"05", X"06", X"07", X"0C",
		--		X"08", X"07", X"07", X"07",	X"07", X"0F", X"0B", X"0B", 
		--		X"09", X"0C", X"11", X"0F",	X"12", X"12", X"11", X"0F",
		--		X"11", X"11", X"13", X"16",	X"1C", X"17", X"13", X"14", 
		--		X"1A", X"15", X"11", X"11",	X"18", X"21", X"18", X"1A",
		--		X"1D", X"1D", X"1F", X"1F",	X"1F", X"13", X"17", X"22", 
		--		X"24", X"22", X"1E", X"24",	X"1C", X"1E", X"1F", X"1E"
		
		-- 75% chrominance
		X"09", X"09", X"09", X"0C", X"0B", X"0C", X"18", X"0D", 
		X"0D", X"18", X"32", X"21", X"1C", X"21", X"32", X"32", 
		X"32", X"32", X"32", X"32", X"32", X"32", X"32", X"32", 
		X"32", X"32", X"32", X"32", X"32", X"32", X"32", X"32", 
		X"32", X"32", X"32", X"32", X"32", X"32", X"32", X"32", 
		X"32", X"32", X"32", X"32", X"32", X"32", X"32", X"32", 
		X"32", X"32", X"32", X"32", X"32", X"32", X"32", X"32", 
		X"32", X"32", X"32", X"32", X"32", X"32", X"32", X"32"  
		
		-- 75? chrominance
		--		X"08", X"06", X"06", X"07", X"06", X"05", X"08", X"07", 
		--		X"07", X"07", X"09", X"09", X"08", X"0A", X"0C", X"14",
		--		X"0D", X"0C", X"0B", X"0B", X"0C", X"19", X"12", X"13", 
		--		X"0F", X"14", X"1D", X"1A", X"1F", X"1E", X"1D", X"1A",
		--		X"1C", X"1C", X"20", X"24", X"2E", X"27", X"20", X"22", 
		--		X"2C", X"23", X"1C", X"1C", X"28", X"37", X"29", X"2C",
		--		X"30", X"31", X"34", X"34", X"34", X"1F", X"27", X"39", 
		--		X"3D", X"38", X"32", X"3C", X"2E", X"33", X"34", X"32"
		
		-- 50% for chrominance
		--		X"11", X"12", X"12", X"18", X"15", X"18", X"2F", X"1A", 
		--		X"1A", X"2F", X"63", X"42", X"38", X"42", X"63", X"63",
		--		X"63", X"63", X"63", X"63", X"63", X"63", X"63", X"63", 
		--		X"63", X"63", X"63", X"63", X"63", X"63", X"63", X"63",
		--		X"63", X"63", X"63", X"63", X"63", X"63", X"63", X"63", 
		--		X"63", X"63", X"63", X"63", X"63", X"63", X"63", X"63",
		--		X"63", X"63", X"63", X"63", X"63", X"63", X"63", X"63", 
		--		X"63", X"63", X"63", X"63", X"63", X"63", X"63", X"63"
		
		-- 15 %	chrominance
		--		X"35", X"25", X"28", X"2F", X"28", X"21", X"35", X"2F", 
		--		X"2B", X"2F", X"3C", X"39", X"35", X"3F", X"50", X"85", 
		--		X"57", X"50", X"49", X"49", X"50", X"A3", X"75", X"7B", 
		--		X"61", X"85", X"C1", X"AA", X"CB", X"C8", X"BE", X"AA", 
		--		X"BA", X"B7", X"D5", X"F0", X"FF", X"FF", X"D5", X"E2", 
		--		X"FF", X"E6", X"B7", X"BA", X"FF", X"FF", X"FF", X"FF", 
		--		X"FF", X"FF", X"FF", X"FF", X"FF", X"CE", X"FF", X"FF", 
		--		X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF"      
		
		);
		variable data_read  : unsigned(31 downto 0);
		variable data_write : unsigned(31 downto 0);
		variable addr       : unsigned(31 downto 0);
	begin
		sim_done <= '0';
		iram_wren <= '0';
		sof<='0';
		while RST /= '0' loop
			wait until rising_edge(clk);
		end loop;
		wait until rising_edge(clk);
		while jpeg_busy/='0' loop
			wait until rising_edge(clk);
		end loop;	 
		wait until rising_edge(clk);
		sof<='1';
		wait until rising_edge(clk);
		sof<='0';
		wait until rising_edge(clk);
		read_image;   
		while jpeg_busy/='0' loop
			wait until rising_edge(clk);
		end loop;	 
		sim_done <= '1';
		wait;
	end process;
end architecture RTL;
