----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:33:42 09/20/2023 
-- Design Name: 
-- Module Name:    tristate_buffer - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;


entity tristate_buffer is
    generic(m : integer);
    Port (
        a    : in  STD_LOGIC_vector(2*m-1 downto 0);
        s    : in  STD_LOGIC;   
        b    : out STD_LOGIC_vector(2*m-1 downto 0)
    );
end tristate_buffer;

architecture Behavioral of tristate_buffer is
   
begin
    process (s,a)
    begin
        if s ='1' then 
            b <= a;   
        else
            b <= ( others=> 'Z' );
        end if;
    end process;
	 
  
end Behavioral;
