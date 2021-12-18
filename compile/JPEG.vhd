-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : JPEG
-- Author      : olegs
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : c:\hw\JPEG\compile\JPEG.vhd
-- Generated   : Sun Oct  4 09:22:15 2020
-- From        : c:\hw\JPEG\src\JPEG.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
library work;
  use work.JPEG_PKG.all;

entity JPEG is
  port(
       CLK : in STD_LOGIC;
       OPB_RNW : in STD_LOGIC;
       OPB_select : in STD_LOGIC;
       RST : in STD_LOGIC;
       iram_wren : in STD_LOGIC;
       outif_almost_full : in STD_LOGIC;
       OPB_ABus : in STD_LOGIC_VECTOR(31 downto 0);
       OPB_BE : in STD_LOGIC_VECTOR(3 downto 0);
       OPB_DBus_in : in STD_LOGIC_VECTOR(31 downto 0);
       iram_wdata : in STD_LOGIC_VECTOR(C_PIXEL_BITS-1 downto 0);
       OPB_XferAck : out STD_LOGIC;
       OPB_errAck : out STD_LOGIC;
       OPB_retry : out STD_LOGIC;
       OPB_toutSup : out STD_LOGIC;
       iram_fifo_afull : out STD_LOGIC;
       ram_wren : out STD_LOGIC;
       OPB_DBus_out : out STD_LOGIC_VECTOR(31 downto 0);
       ram_byte : out STD_LOGIC_VECTOR(7 downto 0);
       ram_wraddr : out STD_LOGIC_VECTOR(23 downto 0)
  );
end JPEG;

architecture JPEG of JPEG is

---- Component declarations -----

component JpegEnc
  port (
       CLK : in STD_LOGIC;
       OPB_ABus : in STD_LOGIC_VECTOR(31 downto 0);
       OPB_BE : in STD_LOGIC_VECTOR(3 downto 0);
       OPB_DBus_in : in STD_LOGIC_VECTOR(31 downto 0);
       OPB_RNW : in STD_LOGIC;
       OPB_select : in STD_LOGIC;
       RST : in STD_LOGIC;
       iram_wdata : in STD_LOGIC_VECTOR(C_PIXEL_BITS-1 downto 0);
       iram_wren : in STD_LOGIC;
       outif_almost_full : in STD_LOGIC;
       OPB_DBus_out : out STD_LOGIC_VECTOR(31 downto 0);
       OPB_XferAck : out STD_LOGIC;
       OPB_errAck : out STD_LOGIC;
       OPB_retry : out STD_LOGIC;
       OPB_toutSup : out STD_LOGIC;
       iram_fifo_afull : out STD_LOGIC;
       ram_byte : out STD_LOGIC_VECTOR(7 downto 0);
       ram_wraddr : out STD_LOGIC_VECTOR(23 downto 0);
       ram_wren : out STD_LOGIC
  );
end component;

begin

----  Component instantiations  ----

U1 : JpegEnc
  port map(
       CLK => CLK,
       OPB_ABus => OPB_ABus,
       OPB_BE => OPB_BE,
       OPB_DBus_in => OPB_DBus_in,
       OPB_DBus_out => OPB_DBus_out,
       OPB_RNW => OPB_RNW,
       OPB_XferAck => OPB_XferAck,
       OPB_errAck => OPB_errAck,
       OPB_retry => OPB_retry,
       OPB_select => OPB_select,
       OPB_toutSup => OPB_toutSup,
       RST => RST,
       iram_fifo_afull => iram_fifo_afull,
       iram_wdata => iram_wdata( C_PIXEL_BITS-1 downto 0 ),
       iram_wren => iram_wren,
       outif_almost_full => outif_almost_full,
       ram_byte => ram_byte,
       ram_wraddr => ram_wraddr,
       ram_wren => ram_wren
  );


end JPEG;
