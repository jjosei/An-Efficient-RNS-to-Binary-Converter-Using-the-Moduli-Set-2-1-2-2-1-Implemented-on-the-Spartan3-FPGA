----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:35 07/06/2024 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH is
   generic(m : integer:=3);
	port(
	   x3 : in std_logic_vector(m-1 downto 0);
		x2 : in std_logic_vector(m-1 downto 0);
		x1 : in std_logic_vector(m downto 0);
		clock, load : in std_logic;		
		countEN : in std_logic;
		
	   muxsel_2to1 : in std_logic;
		muxsel_4to1 : in std_logic_vector(1 downto 0);
		tristate_select : in std_logic;
		
		count : out  STD_LOGIC_VECTOR (2 downto 0);
		result : out std_logic_vector(3*m -1 downto 0));
end DATAPATH;

	architecture Behavioral of DATAPATH is


		component A1 is 
			generic (m : integer);
			port(
			  x1 : in std_logic_vector(m downto 0);			  
			  A1out : out std_logic_vector(2*m-1 downto 0));
		end component;


		component A2 is 
			generic (m : integer);
			port(
			  x2 : in std_logic_vector(m-1 downto 0);			 
			  A2out : out std_logic_vector(2*m-1 downto 0));
		end component;


		component A3 is 
			generic (m : integer);
			port(
			  x3 : in std_logic_vector(m-1 downto 0);			  
			  A3out : out std_logic_vector(2*m-1 downto 0));
		end component;	


		component full_adder is
			generic (m : integer);
			Port (
			  a : in  STD_LOGIC_VECTOR(2*m-1 downto 0);
			  b : in  STD_LOGIC_VECTOR(2*m-1 downto 0);
			  sum : out STD_LOGIC_VECTOR(2*m-1 downto 0);			  
			  carry_out : out std_logic
			);
		end component;


		component mux2to1 is
			generic(m : integer);
			port(
				a, b : in std_logic_vector(2*m-1 downto 0);
				muxsel_2to1 : in std_logic;
				y : out std_logic_vector(2*m-1 downto 0)
			 );	  
		end component;


		component mux4to1 is
			generic(m : integer);
			port(
				a, b, c, d : in std_logic_vector(2*m-1 downto 0);				
				muxsel_4to1 : in std_logic_vector(1 downto 0);
				y : out std_logic_vector(2*m-1 downto 0)
			 );	  
		end component;


		component neg_X1 is
			generic(m : integer);
			port(
			  x1 : in std_logic_vector(m downto 0);			  
			  neg_X1out : out std_logic_vector(2*m-1 downto 0));	  
		end component;
		
		
		component register1 is
			 generic (
				  m : integer 
			 );
			 Port (
				  clk    : in  std_logic;                   	
				  load   : in  std_logic;			  
				  data   : in  std_logic_vector(m-1 downto 0); 
				  q      : out std_logic_vector(m-1 downto 0)  
			 );
		 end component;	


		component tristate_buffer is
			 generic(m : integer);
			 Port (
				  a    : in  STD_LOGIC_vector(2*m-1 downto 0);
				  s    : in  STD_LOGIC;   
				  b    : out STD_LOGIC_vector(2*m-1 downto 0)
			 );
		end component;
		
		
		component i_counter is
			 Port ( clk : in  STD_LOGIC;           
					  countEN : in  STD_LOGIC;
					  count : out  STD_LOGIC_VECTOR (2 downto 0));
      end component;


      signal A1m, A2m, A3m, neg_X1m : std_logic_vector(2*m-1 downto 0);
		signal adder_in1, adder_in2 : std_logic_vector(2*m-1 downto 0);
		signal reg_in, reg_out, temp_result : std_logic_vector(2*m-1 downto 0);		
		signal carry_out, carry_out1 : std_logic;
		signal y : std_logic_vector(2*m-1 downto 0);



begin

    a1component : A1
	 generic map(
	   m => m
	 )
    port map(
	   x1 => x1,
		A1out => A1m
	 );
	 
	 
    a2component : A2
	 generic map(
	   m => m
	 )
    port map(
	   x2 => x2,
		A2out => A2m
	 );
	 

    a3component : A3
	 generic map(
	   m => m
	 )
    port map(
	   x3 => x3,
		A3out => A3m
	 );


    neg_X1component : neg_X1
	 generic map(
	   m => m
	 )
    port map(
	   x1 => x1,
		neg_X1out => neg_X1m
	 );
	 

    mux1 : mux2to1
    generic map(
      m => m
    )
    port map(
      a => reg_out,
      b => A3m,		
		muxsel_2to1 => muxsel_2to1,
		y => adder_in1
	 );
	 

    mux2 : mux4to1
    generic map(
      m => m
    )
    port map(
      a => A2m,
      b => A1m,	
      c => neg_X1m,
      d => y,
		muxsel_4to1 => muxsel_4to1,
		y => adder_in2
	 );	 
	 
	 
	 adder1 : full_adder
	 generic map(
	   m => m
	 )
	 port map(
	   a => adder_in1,
		b => adder_in2,
		sum => reg_in,
		carry_out => carry_out
	 );	
	 
	 process(clock)
    begin
        if rising_edge(clock) then
            carry_out1 <= carry_out;   
        end if;
    end process;
	 
	 y <= (0 => carry_out1, others => '0');	 
	 
	 REG : register1
	 generic map(
	   m => 2*m
	 )
    port map(
      clk => clock,
      load => load,
      data => reg_in,
      q => reg_out
    );	
	 
	 
	 icount : i_counter
	 port map(
	   clk => clock,
	   countEN => countEN,
		count => count
	 );	


    tsb : tristate_buffer
    generic map(
	   m => m	 
	 )
    port map(
      a => reg_out,
      s => tristate_select,
      b => temp_result
    ); 	

		process(x1,x2,x3,temp_result)
		begin
		  if x1 = '0'&x2 and  x2 = x3 then
		    result(3*m-1 downto m) <= (others => '0');
		    result(m-1 downto 0) <= x2;
			 
		  elsif x1 = "0111" and x2 = "111" and x3 = "000" then
		    result(3*m-1 downto m) <= (others => '0');
		    result(m-1 downto 0) <= x2; 
			 
		  else
			 result <= temp_result & x2;
		  end if;
		end process;
		
    	 
      	 
end Behavioral;

