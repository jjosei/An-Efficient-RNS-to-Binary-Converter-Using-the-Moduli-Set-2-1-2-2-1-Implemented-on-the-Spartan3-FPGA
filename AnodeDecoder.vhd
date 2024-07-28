library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity AnodeDecoder is
    port (
        AN_in  : in  std_logic_vector(1 downto 0);
	    AN_out : out std_logic_vector(3 downto 0)
);
end AnodeDecoder;

architecture Behavioral of AnodeDecoder is

begin
    with AN_in select
		AN_out   <= "1110" when "00",
					"1101" when "01",
					"1011" when "10",
					"0111" when "11",
                    "1111" when others;


end Behavioral;