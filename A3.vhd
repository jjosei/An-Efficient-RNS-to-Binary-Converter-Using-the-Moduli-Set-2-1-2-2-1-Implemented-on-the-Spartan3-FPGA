----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:06:49 07/02/2024 
-- Design Name: 
-- Module Name:    A3 - Behavioral 
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
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A3 is 
   generic (m : integer);
	port(
   x3 : in std_logic_vector(m-1 downto 0);
	A3out : out std_logic_vector(2*m-1 downto 0));
end A3;

architecture Behavioral of A3 is 

	signal temp_value : std_logic_vector(m-1 downto 0);
	
begin

    temp_value <= x3(0) & x3(m-1 downto 1);
	 A3out <= temp_value & temp_value; 

end Behavioral;
