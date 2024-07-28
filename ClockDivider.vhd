library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity ClockDivider is
    port(
        clk, Reset :in std_logic;
        output            :out std_logic_vector(14 downto 0)
);
end ClockDivider;

architecture Behavioral of ClockDivider is
    signal count : std_logic_vector (14 downto 0);

begin
    Anode_counter_clock: process (clk, Reset)
    begin
          if ( Reset = '1') then 
                 count <= b"000_000_000_000_000";
         
          elsif (rising_edge(clk)) then 
                count <= count + "01";		
          end if;
         
     end process;		
 
 output <= count;

end Behavioral;