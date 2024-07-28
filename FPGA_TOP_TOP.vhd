library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FPGA_IMPLEMENTATION_TOP_MODEL is
    port(
    clk     :in std_logic;
	 input   :in std_logic_vector(7 downto 0);  
	 reset   :in std_logic;
    B1, B2, B3 :in std_logic;
	 anode   :out std_logic_vector(3 downto 0);  
	 segment :out std_logic_vector(6 downto 0)
	
);
end FPGA_IMPLEMENTATION_TOP_MODEL;

architecture Behavioral of FPGA_IMPLEMENTATION_TOP_MODEL is

    component REVERSE_CONVERTER_TOP_LEVEL is
        generic(m : integer:=3);
        port(
            x3 : in std_logic_vector(m-1 downto 0);
            x2 : in std_logic_vector(m-1 downto 0);
            x1 : in std_logic_vector(m downto 0);
            clock, reset: in std_logic;
            start: in std_logic;
            result_ready: out std_logic :='0';
            result : out std_logic_vector(3*m -1 downto 0)
    );
    end component;

    component SEVEN_SEGMENT_TOP_MODEL is
        port (
            clk, reset        :in  std_logic;
            inputs            :in  std_logic_vector(8 downto 0);
            AN                :out std_logic_vector(3 downto 0);
            segmentOutput     :out std_logic_vector(6 downto 0)    
    );
    end component;

    component button_input is
        Port (
            clk : in STD_LOGIC;
            btn1 : in STD_LOGIC;
            btn2 : in STD_LOGIC;
            btn_out : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    component pushbutton_register is
        port(
            D           : in STD_LOGIC_VECTOR(1  downto 0);
            R, L, CLK   : IN STD_LOGIC;
            Q           : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal pushbutton    : STD_LOGIC;
	 signal O_INPUT   :STD_LOGIC_VECTOR(1 downto 0);
    signal O_OUTPUT   :STD_LOGIC_VECTOR(1 downto 0);
    signal segment_input : std_logic_vector(8 downto 0);
    signal ten_bit_input  : std_logic_vector(9 downto 0);


begin

    --takes care of push button bouncing
    debounce_pushButton: process(clk) is
        begin
            if (rising_edge(clk)) then 
                pushbutton <= reset;
            end if;
    
        end process;
		  
		  buttoninput: button_input port map(
            clk       => CLK,
            btn1      => B1,
            btn2      => B2,
            btn_out   => O_INPUT
        );

        ten_bit_input  <= O_OUTPUT & input;

        converter: REVERSE_CONVERTER_TOP_LEVEL port map (
            clock           =>  CLK, 
            start           =>  B3,
				reset => pushbutton,
            --result_ready    => '0',                      
            x1         =>  ten_bit_input(3  downto 0),
            x2         =>  ten_bit_input(6 downto 4),
            x3         =>  ten_bit_input(9 downto 7),
            result     =>  segment_input
        );

        seven_segment: SEVEN_SEGMENT_TOP_MODEL port map(
            clk             => CLK,
            reset           => pushbutton, 
            inputs          => segment_input,         
            AN              => anode,          
            segmentOutput   => segment
        );  

        button_register: pushbutton_register port map(
        D       => O_INPUT,
        R       => reset, 
        L       => B3, 
        CLK     => CLK,
        Q       => O_OUTPUT
    ); 

end Behavioral;

