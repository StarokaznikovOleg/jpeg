-------------------------------------------------------------------------------
-- Title       : Quantizer Top level
-- Design      : JPEG
-- Author      : Starokaznikov OV
-- Company     : Protei
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.JPEG_PKG.all;

entity QUANT_TOP is
	port 
		(
		CLK                : in  std_logic;
		RST                : in  std_logic;
		-- CTRL
		start_pb           : in  std_logic;
		ready_pb           : out std_logic;
		qua_sm_settings    : in  T_SM_SETTINGS;
		
		-- RLE
		rle_buf_sel        : in  std_logic;
		rle_rdaddr         : in  std_logic_vector(5 downto 0);
		rle_data           : out std_logic_vector(11 downto 0);
		
		-- ZIGZAG
		zig_buf_sel        : out std_logic;
		zig_rd_addr        : out std_logic_vector(5 downto 0);
		zig_data           : in  std_logic_vector(11 downto 0)
		);
end entity QUANT_TOP;

architecture RTL of QUANT_TOP is
	component ram_DBUF
		port(
			clock : in STD_LOGIC;
			wraddress : in STD_LOGIC_VECTOR(6 downto 0);
			wren : in STD_LOGIC;
			data : in STD_LOGIC_VECTOR(11 downto 0);
			rdaddress : in STD_LOGIC_VECTOR(6 downto 0);
			q : out STD_LOGIC_VECTOR(11 downto 0));
	end component; 
	
	signal dbuf_data      : std_logic_vector(11 downto 0);
	signal dbuf_q         : std_logic_vector(11 downto 0);
	signal dbuf_we        : std_logic;
	signal dbuf_waddr     : std_logic_vector(6 downto 0);
	signal dbuf_raddr     : std_logic_vector(6 downto 0);
	signal zigzag_di      : std_logic_vector(11 downto 0);
	signal zigzag_divalid : std_logic;
	signal quant_dout     : std_logic_vector(11 downto 0);
	signal quant_dovalid  : std_logic;
	signal wr_cnt         : unsigned(5 downto 0);
	signal rd_cnt         : unsigned(5 downto 0);
	signal rd_en_d        : std_logic_vector(5 downto 0);
	signal rd_en          : std_logic;
	signal zig_buf_sel_s  : std_logic;
	signal zz_rd_addr     : std_logic_vector(5 downto 0);
	signal fifo_empty     : std_logic;

	begin
	
	zig_rd_addr <= std_logic_vector(rd_cnt);
	rle_data     <= dbuf_q;
	zig_buf_sel <= zig_buf_sel_s;
	
	zigzag_di      <= zig_data;
	zigzag_divalid <= rd_en_d(0);
	
	-------------------------------------------------------------------
	-- Quantizer
	-------------------------------------------------------------------
	U_quantizer : entity work.quantizer
	generic map
		( 
		SIZE_C        => 12,
		RAMQADDR_W    => 7,
		RAMQDATA_W    => 8
		)
	port map
		(
		rst      => RST,
		clk      => CLK,
		di       => zigzag_di,
		divalid  => zigzag_divalid,
		cmp_idx  => qua_sm_settings.cmp_idx,
		
		do       => quant_dout,
		dovalid  => quant_dovalid
		); 
	
	-------------------------------------------------------------------
	-- DBUF
	-------------------------------------------------------------------
	U_RAMZ : ram_DBUF
	port map
		(      
		clock         => CLK,
		wraddress       => dbuf_waddr,
		wren          => dbuf_we,
		data           => dbuf_data,
		rdaddress       => dbuf_raddr,
		q           => dbuf_q
		);
	
	dbuf_data  <= quant_dout;
	dbuf_waddr <= (not rle_buf_sel) & std_logic_vector(wr_cnt);
	dbuf_we    <= quant_dovalid;
	dbuf_raddr <= rle_buf_sel & rle_rdaddr;
	
	-------------------------------------------------------------------
	-- Counter1
	-------------------------------------------------------------------
	p_counter1 : process(CLK, RST)
	begin
		if RST = '1' then
			rd_en        <= '0';
			rd_en_d      <= (others => '0');
			rd_cnt       <= (others => '0');
		elsif CLK'event and CLK = '1' then
			rd_en_d <= rd_en_d(rd_en_d'length-2 downto 0) & rd_en;
			
			if start_pb = '1' then
				rd_cnt <= (others => '0');
				rd_en <= '1';       
			end if;
			
			if rd_en = '1' then
				if rd_cnt = 64-1 then
					rd_cnt <= (others => '0');
					rd_en  <= '0';
				else
					rd_cnt <= rd_cnt + 1;
				end if;
			end if;
			
		end if;
	end process;
	
	-------------------------------------------------------------------
	-- wr_cnt
	-------------------------------------------------------------------
	p_wr_cnt : process(CLK, RST)
	begin
		if RST = '1' then
			wr_cnt   <= (others => '0');
			ready_pb <= '0';
		elsif CLK'event and CLK = '1' then
			ready_pb <= '0';
			
			if start_pb = '1' then
				wr_cnt <= (others => '0');
			end if;
			
			if quant_dovalid = '1' then
				if wr_cnt = 64-1 then
					wr_cnt <= (others => '0');
				else
					wr_cnt <=wr_cnt + 1;
				end if;
				
				-- give ready ahead to save cycles!
				if wr_cnt = 64-1-3 then
					ready_pb <= '1';
				end if;
			end if;
		end if;
	end process;
	
	-------------------------------------------------------------------
	-- zig_buf_sel
	-------------------------------------------------------------------
	p_buf_sel : process(CLK, RST)
	begin
		if RST = '1' then
			zig_buf_sel_s   <= '0'; 
		elsif CLK'event and CLK = '1' then
			if start_pb = '1' then
				zig_buf_sel_s <= not zig_buf_sel_s;
			end if;
		end if;
	end process;
	
end architecture RTL;
