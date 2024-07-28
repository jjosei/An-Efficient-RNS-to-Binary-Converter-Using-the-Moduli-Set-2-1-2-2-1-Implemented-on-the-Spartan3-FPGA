----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:13:49 07/04/2024 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity full_adder is
    generic (m : integer);
    Port (
        a : in  STD_LOGIC_VECTOR(2*m-1 downto 0);
        b : in  STD_LOGIC_VECTOR(2*m-1 downto 0);
        sum : out STD_LOGIC_VECTOR(2*m-1 downto 0);        
		  carry_out : out STD_LOGIC
    );
end full_adder;

architecture Behavioral of full_adder is
    signal sum_temp : STD_LOGIC_VECTOR (2*m downto 0);
begin
    process(a, b, sum_temp)
    begin
        sum_temp <= ('0' & a) + ('0' & b);
        sum <= sum_temp(2*m-1 downto 0);           
		  carry_out <= sum_temp(2*m); 
    end process;
end Behavioral;


