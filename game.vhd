----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2020 10:32:10
-- Design Name: 
-- Module Name: game - game_circuit
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
entity game is
 Port (movingleft,movingright,shoot,rst,clk: in std_logic;
       vgaRed,vgaBlue,vgaGreen: out std_logic_vector(3 downto 0);
        Hsync,Vsync:out std_logic);
end game;

architecture game_circuit of game is
component vga is
 Port (vgaRed,vgaBlue,vgaGreen: out std_logic_vector(3 downto 0);
        Hsync,Vsync,frameInit: out std_logic;
        player: in player;
        aliens: in alien;
        missiles: in missile;
        rst,clk: in std_logic);
end component;
signal update: std_logic;
signal player: player:=(x=>"0100000000",resistance=>"11");
signal missiles: missile:=(x=>"0000000000",y=>"0000001010",onFlight=>'0');
signal aliens: alien:=(x=>"0000000000",y=>"0000000000",isDead=>'0',num=>"000",movingright=>'1',alien_type=>common);
begin
vgaPort: vga port map(vgaRed=>vgaRed,vgaBlue=>vgaBlue,vgaGreen=>vgaGreen,Hsync=>Hsync,Vsync=>Vsync,frameInit=>update,player=>player,aliens=>aliens,missiles=>missiles,rst=>rst,clk=>clk);
aliencontrol:process(update,aliens)
begin
if(rising_edge(update)) then
if(aliens.movingright='1'and unsigned(aliens.x)<600) then
    aliens.x<= std_logic_vector(unsigned(aliens.x)+1);
elsif(unsigned(aliens.x)>0) then 
    aliens.x<= std_logic_vector(unsigned(aliens.x)-1);
end if;
if(aliens.movingright='1'and unsigned(aliens.x)=600) then
    aliens.movingright<='0';
    aliens.y <= std_logic_vector(unsigned(aliens.y)+40);
elsif aliens.movingright='0'and unsigned(aliens.x)=0 then
    aliens.movingright<='1';
    aliens.y <= std_logic_vector(unsigned(aliens.y)+40);
if unsigned(aliens.y)>400 then
    aliens.x<="0000000000";
    aliens.y<="0000000000";
    aliens.movingright<='1';
  end if;
end if;
end if;
end process;
playercontrol:process(update,player,shoot)
begin
if(rising_edge(update)) then
if(movingright='1' and unsigned(player.x)<605) then
    player.x<= std_logic_vector(unsigned(player.x)+1);
elsif(movingleft='1' and unsigned(player.x)>35) then
    player.x<= std_logic_vector(unsigned(player.x)-1);
end if;
if(shoot='1'and missiles.onFlight='0') then
    missiles.x<=std_logic_vector(unsigned(player.x)+17);
    missiles.onFlight <='1';
    missiles.y<= std_logic_vector(to_unsigned(440,10));
    end if;
 if(missiles.onFlight='1' and unsigned(missiles.y)>10) then
    missiles.y<= std_logic_vector(unsigned(missiles.y)-5);
 end if;
 if(missiles.onFlight='1' and unsigned(missiles.y)=10) then
    missiles.onFlight<='0'; 
 end if;
end if;
end process;
end game_circuit;
