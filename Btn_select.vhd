library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity button_input is
    Port (
        clk : in STD_LOGIC;
        btn1 : in STD_LOGIC;
        btn2 : in STD_LOGIC;
        btn_out : out STD_LOGIC_VECTOR(1 downto 0)
    );
end button_input;

architecture Behavioral of button_input is
    signal btn1_reg, btn2_reg : STD_LOGIC := '0';
	 
begin

    process(clk)
    begin
        if rising_edge(clk) then
            btn1_reg <= btn1;
            btn2_reg <= btn2;
        end if;
    end process;

    btn_out <= btn2_reg & btn1_reg;
	 

end Behavioral;