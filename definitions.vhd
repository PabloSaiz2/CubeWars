----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2020 15:37:11
-- Design Name: 
-- Module Name:  - 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package game_def is
type alien_type is(common,attacker);
type alien is record
    alien_type:alien_type;
    movingright:std_logic;
    x: std_logic_vector(9 downto 0);
    y: std_logic_vector(9 downto 0);
    num: std_logic_vector(2 downto 0);
    isDead: std_logic;
end record;
type alien_array is array (1 downto 0) of alien;
type missile is record
    x: std_logic_vector(9 downto 0);
    y: std_logic_vector(9 downto 0);
    onFlight: std_logic;
end record;
type missile_array is array (1 downto 0) of missile;
type player is record
    x: std_logic_vector(9 downto 0);
    resistance: std_logic_vector(1 downto 0);
end record;
end game_def;