----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2020 16:11:09
-- Design Name: 
-- Module Name: vga - video_circuit
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.game_def.all;
entity vga is
  Port (vgaRed,vgaBlue,vgaGreen: out std_logic_vector(3 downto 0);
        Hsync,Vsync,frameInit: out std_logic;
        player: in player;
        aliens: in alien;
        missiles: in missile;
        rst,clk: in std_logic);
end vga;

architecture video_circuit of vga is
component sync_vga is
Port (row,col: out std_logic_vector(9 downto 0);
        Hsync,Vsync,visible: out std_logic;
        rst,clk: in std_logic);
end component;
signal row,col:std_logic_vector(9 downto 0);
signal visible:std_logic;
begin
sync: sync_vga port map(row=>row,col=>col,Hsync=>Hsync,Vsync=>Vsync,visible=>visible,rst=>rst,clk=>clk);
paint:process(row,col,visible,player,aliens,missiles)
begin
if unsigned(row)=0 and unsigned(col)=0 then
    frameInit<='1';
else
    frameInit<='0';
end if;
if visible='1' then
  if(unsigned(aliens.x)+40>unsigned(col)and unsigned(col)>unsigned(aliens.x))and(unsigned(row)>unsigned(aliens.y)and unsigned(row)<(unsigned(aliens.y)+40)) then
        vgaRed<="0000";
        vgaGreen<="0000";
        vgaBlue<="1111";
   elsif ((unsigned(player.x)+40>unsigned(col)) and unsigned(col)>unsigned(player.x)) and unsigned(row)>440 then
        vgaRed<="0000";
        vgaGreen<="1111";
        vgaBlue<="0000";
   elsif (missiles.onFlight='1'and((unsigned(missiles.x)+5>unsigned(col)) and unsigned(col)>unsigned(missiles.x)) and (unsigned(row)<unsigned(missiles.y)and unsigned(row)>(unsigned(missiles.y)-10)))  then
        vgaRed<="1111";
        vgaGreen<="0000";
        vgaBlue<="0000";
  else
  vgaRed<="1111";
  vgaGreen<="1111";
  vgaBlue<="1111";
  end if;
  
else
    vgaRed<="0000";
    vgaGreen<="0000";
    vgaBlue<="0000";
end if;
end process;
end video_circuit;
