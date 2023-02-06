----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2020 16:33:39
-- Design Name: 
-- Module Name: counter - counter_circuit
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

entity counter is
generic(n:natural:=10;cycles:natural:=800);
  Port ( clk,rst,counting:in std_logic;
         count:out std_logic_vector(n-1 downto 0));
end counter;

architecture counter_circuit of counter is
signal current_count:std_logic_vector(n-1 downto 0):=(others =>'0');
signal count_limit:natural:=cycles-1;
begin
count<= current_count;
process(clk,rst,counting)
begin
    if(rst='1') then
        current_count<=(others=>'0');
     elsif (rising_edge(clk)and counting='1')then
       
        if(unsigned(current_count)<count_limit) then
        
        current_count<= std_logic_vector(unsigned(current_count)+1);
        
        else
        
        current_count<=(others=>'0');
        end if;
    end if;
end process;
end counter_circuit;
