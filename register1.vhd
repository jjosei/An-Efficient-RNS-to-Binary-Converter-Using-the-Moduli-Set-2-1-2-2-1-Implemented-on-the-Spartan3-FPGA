----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:44:19 07/01/2024 
-- Design Name: 
-- Module Name:    register1 - Behavioral 
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

entity register1 is
    generic (m : integer);
    Port (
        clk    : in  std_logic;                         
        load   : in std_logic;		  
        data   : in  std_logic_vector(m-1 downto 0);
        q      : out std_logic_vector(m-1 downto 0) 
    );
end register1;

architecture Behavioral of register1 is
    signal reg_value : std_logic_vector(m-1 downto 0); -- Internal register value
begin
    process(clk, load)
    begin
        if rising_edge(clk) then    
           if load = '1' then        
             reg_value <= data;   -- Load the data input into the register
			  end if;	 
        end if;
    end process;

    q <= reg_value; -- Assign the internal register value to the output
end Behavioral;
