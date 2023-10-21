----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 04:47:07 PM
-- Design Name: 
-- Module Name: nbitAdder - Behavioral
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

entity nbitAdder is
   generic(n: integer := 16);
    Port ( c_in : in STD_LOGIC;
           c_out: out STD_LOGIC;
           address: in STD_LOGIC_VECTOR(3 downto 0);
           s: out STD_LOGIC_VECTOR (n-1 downto 0);
           en: in STD_LOGIC;
           clk: in STD_LOGIC;
           data: out STD_LOGIC_VECTOR (n-1 downto 0)
           );
end nbitAdder;

architecture Behavioral of nbitAdder is

component FullAdder is
    Port ( x_fa : in STD_LOGIC;
           y_fa : in STD_LOGIC;
           c_out : out STD_LOGIC;
           s_fa : out STD_LOGIC;
           c_in : in STD_LOGIC);
end component; 

component romFile is
        Port (
            address : in STD_LOGIC_VECTOR(3 downto 0);
            data    : out STD_LOGIC_VECTOR(15 downto 0);
            en : in std_logic;
            clk : in std_logic
        );
    end component romFile;
    
component romFile2 is
            Port (
            address : in STD_LOGIC_VECTOR(3 downto 0);
            data    : out STD_LOGIC_VECTOR(15 downto 0);
            en : in std_logic;
            clk : in std_logic
        );
    end component romFile2;
    -- Add the WriteRegister component
    component writeReg is
        Port (
            clk	    : in std_logic;
            a_addr  : in std_logic_vector(3 downto 0);
            a_data  : in std_logic_vector(15 downto 0);
            load	  : in std_logic;
            data_out: out std_logic_vector(15 downto 0)
        );
        end component;
   
signal c: STD_LOGIC_VECTOR (n downto 0); 
signal rom_data : STD_LOGIC_VECTOR(n-1 downto 0); -- Data from the ROM
signal rom_data1 : STD_LOGIC_VECTOR(n-1 downto 0); -- Data from the ROM
signal data_out  : STD_LOGIC_VECTOR(n-1 downto 0);
-- Add a signal to store the data to be written to the WriteRegister
signal data_to_write : STD_LOGIC_VECTOR(n-1 downto 0);
signal sum: STD_LOGIC_VECTOR(n-1 downto 0);
begin

    rom_inst : romFile
        port map (address => address, data => rom_data,en=>en,clk=>clk);
    rom_inst2 : romFile2
        port map (address => address, data => rom_data1,en=>en,clk=>clk);
        
c(0)<= c_in;

fa: for i in 0 to n-1 generate 
fa_I: FullAdder Port map(rom_data(i),rom_data1(i),c(i+1),sum(i),c(i));
end generate; 
s<=sum;
c_out <= c(n);
    write_register_inst : writeReg
        port map (
            clk	=> clk,
            a_addr => address,
            a_data => sum,
            load => en,
            data_out => data
        );       
end Behavioral;
