----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 04:22:40 PM
-- Design Name: 
-- Module Name: FullAdder - Behavioral
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

entity FullAdder is
    Port ( x_fa : in STD_LOGIC;
           y_fa : in STD_LOGIC;
           c_out : out STD_LOGIC;
           s_fa : out STD_LOGIC;
           c_in : in STD_LOGIC);
           
end FullAdder;


architecture Behavioral of FullAdder is
component HalfAdder is
    Port ( x_ha : in STD_LOGIC;
           y_ha : in STD_LOGIC;
           s_ha : out STD_LOGIC;
           c_ha : out STD_LOGIC);
end component;

signal s1,c1,c2: STD_LOGIC;  
begin
HalfAdder1: HalfAdder port map (x_fa,y_fa,s1,c1);
HalfAdder2: HalfAdder port Map (s1,c_in,s_fa,c2);

c_out <= c2 or c1;

end Behavioral;
