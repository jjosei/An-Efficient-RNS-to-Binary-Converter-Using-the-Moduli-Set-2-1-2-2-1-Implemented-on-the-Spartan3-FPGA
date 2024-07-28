----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:26:46 07/01/2024 
-- Design Name: 
-- Module Name:    A2 - Behavioral 
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

entity A2 is 
   generic (m : integer);
	port(
   x2 : in std_logic_vector(m-1 downto 0);
	A2out : out std_logic_vector(2*m-1 downto 0));
end A2;

architecture Behavioral of A2 is 

   component inverter is
		 generic (m : integer);
		 Port (
			  input_signal  : in  STD_LOGIC_VECTOR(m-1 DOWNTO 0);
			  output_signal : out STD_LOGIC_VECTOR(m-1 DOWNTO 0));
   end component;
	
	
   signal all_ones : std_logic_vector(m-1 downto 0) := ( others=> '1' );
   signal inverter_out : std_logic_vector(m-1 downto 0);
begin
	 
	 
	 inverter_A2: inverter
	     generic map(
		      m => m
		  )
        port map(
            input_signal => x2,
            output_signal => inverter_out
        );


   
   A2out <= inverter_out & all_ones ;

end Behavioral;
