-------------------------------------------------------------------------------
-- Title       : DC_CR_ROM Chrominance
-- Design      : JPEG
-- Author      : Starokaznikov OV
-- Company     : Protei
-------------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity DC_CR_ROM is
  port 
  (
        CLK                : in  std_logic;
        RST                : in  std_logic;
        VLI_size           : in  std_logic_vector(3 downto 0);
        
        VLC_DC_size        : out std_logic_vector(3 downto 0);
        VLC_DC             : out unsigned(10 downto 0)        
    );
end entity DC_CR_ROM;

architecture RTL of DC_CR_ROM is

begin

  -------------------------------------------------------------------
  -- DC-ROM
  -------------------------------------------------------------------
  p_DC_CR_ROM : process(CLK, RST)
  begin
    if RST = '1' then
      VLC_DC_size <= X"0";
      VLC_DC      <= (others => '0'); 
    elsif CLK'event and CLK = '1' then
      case VLI_size is 
        when X"0" =>
          VLC_DC_size <= X"2";
          VLC_DC      <= resize("00", VLC_DC'length); 
        when X"1" =>
          VLC_DC_size <= X"2";
          VLC_DC      <= resize("01", VLC_DC'length); 
        when X"2" =>
          VLC_DC_size <= X"2";
          VLC_DC      <= resize("10", VLC_DC'length); 
        when X"3" =>
          VLC_DC_size <= X"3";
          VLC_DC      <= resize("110", VLC_DC'length); 
        when X"4" =>
          VLC_DC_size <= X"4";
          VLC_DC      <= resize("1110", VLC_DC'length); 
        when X"5" =>
          VLC_DC_size <= X"5";
          VLC_DC      <= resize("11110", VLC_DC'length); 
        when X"6" =>
          VLC_DC_size <= X"6";
          VLC_DC      <= resize("111110", VLC_DC'length); 
        when X"7" =>
          VLC_DC_size <= X"7";
          VLC_DC      <= resize("1111110", VLC_DC'length); 
        when X"8" =>
          VLC_DC_size <= X"8";
          VLC_DC      <= resize("11111110", VLC_DC'length); 
        when X"9" =>
          VLC_DC_size <= X"9";
          VLC_DC      <= resize("111111110", VLC_DC'length); 
        when X"A" =>
          VLC_DC_size <= X"A";
          VLC_DC      <= resize("1111111110", VLC_DC'length); 
        when X"B" =>
          VLC_DC_size <= X"B";
          VLC_DC      <= resize("11111111110", VLC_DC'length); 
        when others =>
          VLC_DC_size <= X"0";
          VLC_DC      <= (others => '0'); 
      end case;
    end if;
  end process;

end architecture RTL;
