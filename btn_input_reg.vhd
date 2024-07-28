
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;



entity pushbutton_register is
    port(
        D           : in STD_LOGIC_VECTOR(1  downto 0);
        R, L, CLK   : IN STD_LOGIC;
        Q           : out STD_LOGIC_VECTOR(1 downto 0)
    );
end pushbutton_register;

architecture Behavioral of pushbutton_register is

    signal tmp_d    : STD_LOGIC_VECTOR(1 downto 0);

begin

    REG_GENERIC: process(CLK, tmp_d)
    begin
        if (rising_edge(CLK)) then

            if (R = '1') then
                tmp_d <= std_logic_vector(to_unsigned(integer(0), tmp_d'length));
            elsif(R = '0') then
                if (L = '1') then
                    tmp_d <= D;
                elsif(L = '0') then
                    tmp_d <= tmp_d;
                end if ;
            end if ;

        end if ; 
        
            Q <= tmp_d;
    end process ; 


end Behavioral;

