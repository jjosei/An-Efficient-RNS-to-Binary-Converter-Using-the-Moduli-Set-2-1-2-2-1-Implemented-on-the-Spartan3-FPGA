----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:57 07/01/2024 
-- Design Name: 
-- Module Name:    A1 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity A1 is 
   generic (m : integer);
	port(
    x1 : in std_logic_vector(m downto 0);
	 A1out : out std_logic_vector(2*m-1 downto 0));
end A1;

architecture Behavioral of A1 is 


	signal temp : std_logic_vector(m-1 downto 0);
	signal shifted_temp : std_logic_vector(m-1 downto 0);	
	signal altbit: std_logic;

	
begin
	
	altbit <= x1(m) xor x1(0);
	temp <= x1(m-1 downto 1) & altbit;
	shifted_temp <= temp(0) & temp(m-1 downto 1);
	
	A1out <= shifted_temp & shifted_temp;
	

end Behavioral;