----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:25:09 07/03/2024 
-- Design Name: 
-- Module Name:    mux4to1 - Behavioral 
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

entity mux4to1 is
   generic(m : integer);
	port(
	   a, b, c, d : in std_logic_vector(2*m-1 downto 0);		
		muxsel_4to1 : in std_logic_vector(1 downto 0);
		y : out std_logic_vector(2*m-1 downto 0)
    );	  
end mux4to1;

architecture Behavioral of mux4to1 is

begin
   process(a,b,c,muxsel_4to1,d)
	   begin	 
       case muxsel_4to1 is
           when "00"=>
             y <= a;
			  when "01"=>
             y <= b;
           when "10"=>
             y <= c;
           when "11"=>
			    y <= d;            
			  when others =>
             y <= (others => '0');	 
		 end case;		 
   end process;				 
				 
end Behavioral;

