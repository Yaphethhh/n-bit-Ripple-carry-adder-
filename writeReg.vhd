----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2023 11:48:59 AM
-- Design Name: 
-- Module Name: writeReg - Behavioral
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity writeReg is
    port(
        clk      : in std_logic;
        a_addr   : in std_logic_vector(3 downto 0);
        a_data   : in std_logic_vector(15 downto 0);
        load     : in std_logic;
        data_out : out std_logic_vector(15 downto 0)
    );
end writeReg;

architecture syn of writeReg is
    type ram_type is array (15 downto 0) of std_logic_vector(15 downto 0);
    signal REG  : ram_type;
begin
    process(clk, load, a_addr)
    begin
        if rising_edge(clk) then
            if load = '1' then
                REG(conv_integer(a_addr)) <= a_data;
            end if;
            data_out <= REG(conv_integer(a_addr));
        end if;
    end process;
end syn;







