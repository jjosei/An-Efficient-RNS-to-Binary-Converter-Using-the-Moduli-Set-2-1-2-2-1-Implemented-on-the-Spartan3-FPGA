library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL; 



entity TwoBitCounter is
    port(
        clk, Reset :in std_logic;
        output     :out std_logic_vector(1 downto 0)   
);
end TwoBitCounter;

architecture Behavioral of TwoBitCounter is

    signal count : std_logic_vector (1 downto 0);

begin

    TwoBitCounter: process (clk, Reset)
    begin
            if ( Reset = '1') then 
                    count <= "00";
            
            elsif (rising_edge(clk)) then
                count <= count + "01";		
            end if;
            
        end process;		

    output <= count;


end Behavioral;