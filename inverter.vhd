----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:18:24 07/02/2024 
-- Design Name: 
-- Module Name:    inverter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

entity inverter is
    generic (m : integer);
    Port (
        input_signal  : in  STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        output_signal : out STD_LOGIC_VECTOR(m-1 DOWNTO 0));
end inverter;

architecture Behavioral of inverter is
begin
    output_signal <= NOT input_signal;
end Behavioral;
