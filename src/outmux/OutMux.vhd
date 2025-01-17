-------------------------------------------------------------------------------
-- Title       : Output Multiplexer
-- Design      : JPEG
-- Author      : Starokaznikov OV
-- Company     : Protei
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.JPEG_PKG.all;

entity OutMux is
	port 
		(
		CLK                : in  std_logic;
		RST                : in  std_logic;
		-- CTRL
		out_mux_ctrl       : in  std_logic;
		
		-- ByteStuffer
		bs_ram_byte        : in  std_logic_vector(7 downto 0);
		bs_ram_wren        : in  std_logic;
--		bs_ram_wraddr      : in  std_logic_vector(23 downto 0);
		
		-- JFIFGen
		jfif_ram_byte      : in  std_logic_vector(7 downto 0);
		jfif_ram_wren      : in  std_logic;
--		jfif_ram_wraddr    : in  std_logic_vector(23 downto 0);
		
		-- OUT RAM
		ram_byte           : out std_logic_vector(7 downto 0);
		ram_wren           : out std_logic
--		ram_wraddr         : out std_logic_vector(23 downto 0)
		);
end entity OutMux;

architecture RTL of OutMux is
	
begin
	-------------------------------------------------------------------
	-- Mux
	-------------------------------------------------------------------
	p_ctrl : process(CLK, RST)
	begin
		if RST = '1' then
			ram_byte     <= (others => '0');
			ram_wren     <= '0';
--			ram_wraddr   <= (others => '0');
		elsif CLK'event and CLK = '1' then
			if out_mux_ctrl = '0' then
				ram_byte   <= jfif_ram_byte;  
				ram_wren   <= jfif_ram_wren;  
--				ram_wraddr <= std_logic_vector(jfif_ram_wraddr);
			else
				ram_byte   <= bs_ram_byte;  
				ram_wren   <= bs_ram_wren;  
--				ram_wraddr <= bs_ram_wraddr;
			end if;        
		end if;
	end process;
	
end architecture RTL;
