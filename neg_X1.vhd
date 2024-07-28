----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:02 07/05/2024 
-- Design Name: 
-- Module Name:    neg_X1 - Behavioral 
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

entity neg_X1 is
   generic(m : integer);
	port(
     x1 : in std_logic_vector(m downto 0);
	  neg_X1out : out std_logic_vector(2*m-1 downto 0));	  
end neg_X1;

architecture Behavioral of neg_X1 is

   component inverter is
		 generic (m : integer);
		 Port (
			  input_signal  : in  STD_LOGIC_VECTOR(m-1 DOWNTO 0);
			  output_signal : out STD_LOGIC_VECTOR(m-1 DOWNTO 0));
   end component;


    signal all_ones : std_logic_vector(m-2 downto 0) := ( others=> '1' );
	 signal inverter_out : std_logic_vector(m downto 0);

begin
   

   inverter_negX1 : inverter
	     generic map(
		      m => m+1
		  )
        port map(
            input_signal => x1,
            output_signal => inverter_out
        );
		 

   
    neg_X1out <= all_ones & inverter_out; 
		  
end Behavioral;

