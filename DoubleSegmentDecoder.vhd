library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity DoubleSegmentDecoder is
        port(
        SEL     :in std_logic_vector(1 downto 0);
        S0, S1, S2, S3  :in std_logic_vector(6 downto 0);
        output  : out std_logic_vector(6 downto 0)
    );
end DoubleSegmentDecoder;

architecture Behavioral of DoubleSegmentDecoder is

begin

    output <=   S0 when (SEL = "00") else
                S1 when (SEL = "01") else
                S2 when (SEL = "10") else
                S3;



end Behavioral;