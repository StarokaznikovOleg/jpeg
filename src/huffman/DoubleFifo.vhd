-------------------------------------------------------------------------------
-- Title       : DoubleFifo
-- Design      : JPEG
-- Author      : Starokaznikov OV
-- Company     : Protei
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DoubleFifo is
	port 
		(
		CLK                : in  std_logic;
		RST                : in  std_logic;
		-- HUFFMAN
		data_in            : in  std_logic_vector(7 downto 0);
		wren               : in  std_logic;
		-- BYTE STUFFER
		buf_sel            : in  std_logic;
		rd_req             : in  std_logic;
		fifo_empty         : out std_logic;
		data_out           : out std_logic_vector(7 downto 0)
		);
end entity DoubleFifo;

architecture RTL of DoubleFifo is
	
	component fifo_huffman
		port (
			aclr : in STD_LOGIC;
			clock : in STD_LOGIC;
			data : in STD_LOGIC_VECTOR(7 downto 0);
			wrreq : in STD_LOGIC;
			q : out STD_LOGIC_VECTOR(7 downto 0);
			rdreq : in STD_LOGIC;
			usedw : out STD_LOGIC_VECTOR(7 downto 0);
			full : out STD_LOGIC;
			empty : out STD_LOGIC
			);
	end component;
	
	signal fifo1_rd      : std_logic;
	signal fifo1_wr      : std_logic;
	signal fifo1_q       : std_logic_vector(7 downto 0);
	signal fifo1_full    : std_logic;
	signal fifo1_empty   : std_logic;
	signal fifo1_count   : std_logic_vector(7 downto 0);
	
	signal fifo2_rd      : std_logic;
	signal fifo2_wr      : std_logic;
	signal fifo2_q       : std_logic_vector(7 downto 0);
	signal fifo2_full    : std_logic;
	signal fifo2_empty   : std_logic;
	signal fifo2_count   : std_logic_vector(7 downto 0);
	
	signal fifo_data_in  : std_logic_vector(7 downto 0);

	begin
	
	-------------------------------------------------------------------
	-- FIFO 1
	-------------------------------------------------------------------
	U_FIFO_1 : fifo_huffman
	port map(
		aclr => RST,
		clock => CLK,
		data => fifo_data_in,
		wrreq => fifo1_wr,
		q => fifo1_q,
		rdreq => fifo1_rd,
		usedw => fifo1_count,
		full => fifo1_full,
		empty => fifo1_empty
		);	
	
	-------------------------------------------------------------------
	-- FIFO 2
	-------------------------------------------------------------------
	U_FIFO_2 : fifo_huffman
	port map(
		aclr => RST,
		clock => CLK,
		data => fifo_data_in,
		wrreq => fifo2_wr,
		q => fifo2_q,
		rdreq => fifo2_rd,
		usedw => fifo2_count,
		full => fifo2_full,
		empty => fifo2_empty
		);	
	
	-------------------------------------------------------------------
	-- mux2
	-------------------------------------------------------------------
	p_mux2 : process(CLK, RST)
	begin
		if RST = '1' then
			fifo1_wr <= '0';
			fifo2_wr <= '0';
			fifo_data_in <= (others => '0');
		elsif CLK'event and CLK = '1' then
			if buf_sel = '0' then
				fifo1_wr <= wren;
			else
				fifo2_wr <= wren;
			end if;
			fifo_data_in <= data_in;
		end if;
	end process;
	
	-------------------------------------------------------------------
	-- mux3
	-------------------------------------------------------------------
	p_mux3 : process(CLK, RST)
	begin
		if RST = '1' then
			data_out   <= (others => '0');
			fifo1_rd   <= '0';
			fifo2_rd   <= '0';
			fifo_empty <= '0';
		elsif CLK'event and CLK = '1' then
			if buf_sel = '1' then
				data_out   <= fifo1_q;
				fifo1_rd   <= rd_req;
				fifo_empty <= fifo1_empty;
			else
				data_out <= fifo2_q;
				fifo2_rd <= rd_req;
				fifo_empty <= fifo2_empty;
			end if;
		end if;
	end process;
	
end architecture RTL;
