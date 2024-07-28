----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:05:52 07/22/2024 
-- Design Name: 
-- Module Name:    i_counter - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity i_counter is
    Port ( clk : in  STD_LOGIC;           
			  countEN : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (2 downto 0));
end i_counter;

architecture Behavioral of i_counter is
    signal internal_count : STD_LOGIC_VECTOR (2 downto 0) := "000";
begin
    process(clk, countEN)
    begin
        if rising_edge(clk) then
            if countEN = '1' then
                internal_count <= internal_count + 1;
            end if;
        end if;
    end process;

    count <= internal_count;
end Behavioral;