-------------------------------------------------------------------------------
-- Title       : ROM for DCT matrix constant cosine coefficients (even part)
-- Design      : JPEG
-- Author      : Starokaznikov OV
-- Company     : Protei
-------------------------------------------------------------------------------
-- 5:4 = select matrix row (1 out of 4)
-- 3:0 = select precomputed MAC ( 1 out of 16)

library IEEE; 
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.STD_LOGIC_arith.all;
  use WORK.MDCT_PKG.all;

entity ROME is 
  port( 
       clk          : in  STD_LOGIC; 
       addr         : in  STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0); 
       datao        : out STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0) 
  );         
  
end ROME; 

architecture RTL of ROME is  
  
  type ROM_TYPE is array (0 to (2**ROMADDR_W)-1) 
            of STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
  constant rom : ROM_TYPE := 
    (
    (others => '0'),                				-- 00
     conv_std_logic_vector( AP,ROMDATA_W ),         -- 01  
     conv_std_logic_vector( AP,ROMDATA_W ),         -- 02
     conv_std_logic_vector( AP+AP,ROMDATA_W ),      -- 03
     conv_std_logic_vector( AP,ROMDATA_W ),         -- 04
     conv_std_logic_vector( AP+AP,ROMDATA_W ),      -- 05
     conv_std_logic_vector( AP+AP,ROMDATA_W ),      -- 06
     conv_std_logic_vector( AP+AP+AP,ROMDATA_W ),   -- 07
     conv_std_logic_vector( AP,ROMDATA_W ),         -- 08
     conv_std_logic_vector( AP+AP,ROMDATA_W ),      -- 09
     conv_std_logic_vector( AP+AP,ROMDATA_W ),      -- 10
     conv_std_logic_vector( AP+AP+AP,ROMDATA_W ),   -- 11
     conv_std_logic_vector( AP+AP,ROMDATA_W ),      -- 12
     conv_std_logic_vector( AP+AP+AP,ROMDATA_W ),   -- 13
     conv_std_logic_vector( AP+AP+AP,ROMDATA_W ),   -- 14
     conv_std_logic_vector( AP+AP+AP+AP,ROMDATA_W ),-- 15
                                     
                                     
     (others => '0'),                		   -- 00
     conv_std_logic_vector( BM,ROMDATA_W ),    -- 01       
     conv_std_logic_vector( CM,ROMDATA_W ),    -- 02     
     conv_std_logic_vector( CM+BM,ROMDATA_W ), -- 03     
     conv_std_logic_vector( CP,ROMDATA_W ),    -- 04     
     conv_std_logic_vector( CP+BM,ROMDATA_W ), -- 05     
     (others => '0'),                		   -- 06
     conv_std_logic_vector( BM,ROMDATA_W ),    -- 07     
     conv_std_logic_vector( BP,ROMDATA_W ),    -- 08     
     (others => '0'),                		   -- 09
     conv_std_logic_vector( BP+CM,ROMDATA_W ), -- 10     
     conv_std_logic_vector( CM,ROMDATA_W ),    -- 11     
     conv_std_logic_vector( BP+CP,ROMDATA_W ), -- 12     
     conv_std_logic_vector( CP,ROMDATA_W ),    -- 13     
     conv_std_logic_vector( BP,ROMDATA_W ),    -- 14     
     (others => '0'),                		   -- 15
                                     
                                     
     (others => '0'),                		   -- 00
     conv_std_logic_vector( AP,ROMDATA_W ),    -- 01     
     conv_std_logic_vector( AM,ROMDATA_W ),    -- 02     
     (others => '0'),                		   -- 03
     conv_std_logic_vector( AM,ROMDATA_W ),    -- 04     
     (others => '0'),                		   -- 05
     conv_std_logic_vector( AM+AM,ROMDATA_W ), -- 06     
     conv_std_logic_vector( AM,ROMDATA_W ),    -- 07     
     conv_std_logic_vector( AP,ROMDATA_W ),    -- 08     
     conv_std_logic_vector( AP+AP,ROMDATA_W ), -- 09     
     (others => '0'),                		   -- 10
     conv_std_logic_vector( AP,ROMDATA_W ),    -- 11     
     (others => '0'),                		   -- 12
     conv_std_logic_vector( AP,ROMDATA_W ),    -- 13     
     conv_std_logic_vector( AM,ROMDATA_W ),    -- 14     
     (others => '0'),                		   -- 15
                                     
                                     
     (others => '0'),                		   -- 00
     conv_std_logic_vector( CM,ROMDATA_W ),    -- 01      
     conv_std_logic_vector( BP,ROMDATA_W ),    -- 02      
     conv_std_logic_vector( BP+CM,ROMDATA_W ), -- 03     
     conv_std_logic_vector( BM,ROMDATA_W ),    -- 04     
     conv_std_logic_vector( BM+CM,ROMDATA_W ), -- 05     
     (others => '0'),                		   -- 06
     conv_std_logic_vector( CM,ROMDATA_W ),    -- 07     
     conv_std_logic_vector( CP,ROMDATA_W ),    -- 08     
     (others => '0'),                		   -- 09
     conv_std_logic_vector( CP+BP,ROMDATA_W ), -- 10     
     conv_std_logic_vector( BP,ROMDATA_W ),    -- 11     
     conv_std_logic_vector( CP+BM,ROMDATA_W ), -- 12     
     conv_std_logic_vector( BM,ROMDATA_W ),    -- 13     
     conv_std_logic_vector( CP,ROMDATA_W ),    -- 14     
     (others => '0')						   -- 15
     );                
  
begin 

  process(clk)
  begin
   if clk = '1' and clk'event then
    datao <= rom(CONV_INTEGER(UNSIGNED(addr)) ); 
   end if;
  end process;  
      
end RTL;    

                

