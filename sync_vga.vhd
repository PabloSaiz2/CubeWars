----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2020 16:18:02
-- Design Name: 
-- Module Name: sync_vga - sync_circuit
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

entity sync_vga is
  Port (row,col: out std_logic_vector(9 downto 0);
        Hsync,Vsync,visible: out std_logic;
        rst,clk: in std_logic);
end sync_vga;

architecture sync_circuit of sync_vga is
component counter is
generic(n:natural:=10;cycles:natural:=800);
Port ( clk,rst,counting:in std_logic;
         count:out std_logic_vector(n-1 downto 0));
end component;
signal notrst:std_logic;
signal countCycle:std_logic:='0';
signal hsync_comb:std_logic:='1';
signal vsync_comb: std_logic:='1';
signal visible_pxl:std_logic:='1';
signal visible_line:std_logic:='1';
signal counter_clock: std_logic_vector(1 downto 0):="00";
signal counter_pixel: std_logic_vector(9 downto 0):="0000000000";
signal counter_line: std_logic_vector(9 downto 0):="0000000000";
signal new_pixel:std_logic:='0';
signal new_line:std_logic:='0';
begin
Hsync<= hsync_comb;
Vsync<=vsync_comb;
row<=counter_line;
notrst<= not rst;
col<=counter_pixel;
visible<= visible_pxl and visible_line;
counter_new_pixel: counter generic map(2,4)port map(clk=>clk,rst=>rst,counting=>notrst,count=>counter_clock);
counter_new_line: counter generic map(10,800) port map(clk=>clk,rst=>rst,counting=>new_pixel,count=>counter_pixel);
counter_new_screen: counter generic map(10,521) port map(clk=>clk,rst=>rst,counting=>new_line,count=>counter_line);
new_pixel_control:process(counter_clock)
begin

if(unsigned(counter_clock)=3) then
    new_pixel <= '1';
else
    new_pixel <='0';
 end if;
end process;
new_line_control:process(counter_pixel,new_pixel)
begin
if(unsigned(counter_pixel)>655 and unsigned(counter_pixel)<752) then
    hsync_comb <='0';
else
    hsync_comb<='1';
end if;
if(unsigned(counter_pixel)<640)then
    visible_pxl<='1';
else
    visible_pxl<='0';
end if;
if(unsigned(counter_pixel)=799 and new_pixel='1')then
    new_line <= '1';
else
    new_line <='0';
 end if;
end process;
new_screen_control:process(counter_line)
begin
if(unsigned(counter_line)>489 and unsigned(counter_line)<492) then
    vsync_comb <='0';
else
    vsync_comb<='1';
end if;
if(unsigned(counter_line)<480)then
    visible_line<='1';
else
    visible_line<='0';
end if;
end process;
end sync_circuit;
