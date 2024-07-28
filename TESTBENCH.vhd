LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_textio.ALL;
USE ieee.numeric_std.ALL;

library STD;
USE STD.textio.all;

entity Generic_reverse_converter_TB is
    generic(
        m  : integer  := 3       
        );
end Generic_reverse_converter_TB;

architecture Behavioral of Generic_reverse_converter_TB is

    signal x1 : std_logic_vector(m downto 0);
    signal x2 : std_logic_vector(m-1 downto 0);
    signal x3 : std_logic_vector(m-1 downto 0);
    signal CLK : std_logic := '0';
	 signal result_ready, start  : std_logic;
    signal RESULT : std_logic_vector(3*m - 1 downto 0);

    constant CLK_period : time := 10 ns;

    component REVERSE_CONVERTER_TOP_LEVEL is 
        generic(m : integer);
        port(
            x3 : in std_logic_vector(m-1 downto 0);
            x2 : in std_logic_vector(m-1 downto 0); 
            x1 : in std_logic_vector(m downto 0);
            clock: in std_logic;
				start : in std_logic;
				result_ready : out std_logic;
            result : out std_logic_vector(3*m -1 downto 0)
        );
    end component;

begin

    uut: REVERSE_CONVERTER_TOP_LEVEL 
	 GENERIC MAP( m => m)
	 PORT MAP (
        x3 => x3,
        x2 => x2,
        x1 => x1,
        clock => CLK,
		  result_ready => result_ready,
		  start => start,
        result => RESULT
    );

    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

    STIMULUS : process
        file Fout: TEXT open WRITE_MODE is "REVERSE_RESULT.txt";
        variable current_line: line;
    begin
        write(current_line, string'("TESTFILE FOR REVERSE CONVERTER"));
        writeline(Fout, current_line);
		  
        write(current_line, string'("  X3 "));
        write(current_line, string'("  X2 "));
        write(current_line, string'("  X1 "));
        write(current_line, string'("  RESULT "));
        writeline(Fout, current_line);
        write(current_line, string'(""));
        writeline(Fout, current_line);
						  
						  
        for k in 0 to 6 loop -- Adjust loop range as needed
            for j in 0 to 7 loop -- Adjust loop range as needed
                for i in 0 to 8 loop -- Adjust loop range as needed
					    start <= '1';
                    x3 <= std_logic_vector(to_unsigned(k, x3'length));
                    x2 <= std_logic_vector(to_unsigned(j, x2'length));                    
                    x1 <= std_logic_vector(to_unsigned(i, x1'length));
						  
                    wait until rising_edge(result_ready);
						    start <= '0';
						    wait for 	CLK_period;
													  	
                    write(current_line, to_integer(unsigned(x3)));
                    write(current_line, string'("     "));
                    write(current_line, to_integer(unsigned(x2)));
                    write(current_line, string'("     "));
                    write(current_line, to_integer(unsigned(x1)));
                    write(current_line, string'("     "));
                    write(current_line, to_integer(unsigned(RESULT)));
                    writeline(Fout, current_line);
						  
						  wait for CLK_period;						  

                end loop;
            end loop;
        end loop; 
			for k in 0 to 7 loop 
				wait for CLK_period;
			end loop;
        report "Simulation succeeded" severity FAILURE;
    end process;

end Behavioral;
