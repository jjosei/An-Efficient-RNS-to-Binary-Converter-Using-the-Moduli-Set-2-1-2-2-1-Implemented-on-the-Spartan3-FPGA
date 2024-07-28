library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SEVEN_SEGMENT_TOP_MODEL is
    port (
        clk, reset        :in  std_logic;
        inputs            :in  std_logic_vector(8 downto 0);
        AN                :out std_logic_vector(3 downto 0);
        segmentOutput     :out std_logic_vector(6 downto 0) 
	
);
end SEVEN_SEGMENT_TOP_MODEL;  

architecture Behavioral of SEVEN_SEGMENT_TOP_MODEL is

    component ClockDivider is
        port(
            clk, Reset :in std_logic;
            output            :out std_logic_vector(14 downto 0)
    );
    end component;

    -- component SevenSegmentMux is
    --     port(
    --     SEL     :in std_logic_vector(1 downto 0);
    --     D0, D1  :in std_logic_vector(5 downto 0);
    --     D2, D3   :in std_logic_vector(3 downto 0);
    --     output  : out std_logic_vector(5 downto 0)
    -- );
    -- end component;

    component DoubleSegmentDecoder is
        port(
        SEL     :in std_logic_vector(1 downto 0);
        S0, S1, S2, S3  :in std_logic_vector(6 downto 0);
        output  : out std_logic_vector(6 downto 0)
    );
    end component;

    component AnodeDecoder is
        port (
            AN_in  : in  std_logic_vector(1 downto 0);
            AN_out : out std_logic_vector(3 downto 0)
    );
    end component;

	 
	 component sixbitdec is
        port(
            input  :in std_logic_vector(8 downto 0);
	         output :out std_logic_vector (20 downto 0)
     );
    end component sixbitdec;

    component TwoBitCounter is
        port(
            clk, Reset :in std_logic;
            output     :out std_logic_vector(1 downto 0)   
    );
    end component;


    signal cnt_out : std_logic_vector (1 downto 0);
    -- signal mux_out : std_logic_vector(5 downto 0);
    signal dec_out : std_logic_vector(20 downto 0);
    signal new_clk : std_logic_vector(14 downto 0); 
    --signal inputs  : std_logic_vector(15 downto 0) ; 

begin
--inputs <= x"ABCD";
    anode_counter: TwoBitCounter port map(
			clk => new_clk(14),
			Reset => reset,
			output => cnt_out
    );

    -- seven_segment_mux_input: SevenSegmentMux port map(
	-- 		SEL    =>    cnt_out,
	-- 		D0     =>    inputs (5 downto 0),
	-- 		D1     =>    inputs (5 downto 0),
	-- 		D2     =>    inputs (9 downto 6),
	-- 		D3     =>    inputs (13 downto 10),
	-- 		output =>    mux_out	
    -- );

    anode_decoder: AnodeDecoder port map(
		AN_in       => cnt_out,
		AN_out      => AN
    );


    six_bit_segment_decoder: sixbitdec port map(
		input     => inputs(8 downto 0),
		output    => dec_out
    );

    double_segment_decoder_mux: DoubleSegmentDecoder port map(
		SEL    =>    cnt_out,
		S0     =>    dec_out (6 downto 0),
		S1     =>    dec_out (13 downto 7),
		S2     =>    dec_out (20 downto 14),
		S3     =>    "0000000",
		output =>    segmentOutput
    );

    eighteen_bit_anode_clock_cnt: ClockDivider port map(
		clk => clk,
		Reset => reset,
		output => new_clk
);

   


end Behavioral;

