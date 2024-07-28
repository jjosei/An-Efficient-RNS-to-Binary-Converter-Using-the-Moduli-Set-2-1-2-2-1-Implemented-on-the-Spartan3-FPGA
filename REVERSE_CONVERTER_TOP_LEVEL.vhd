----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:44 07/08/2024 
-- Design Name: 
-- Module Name:    REVERSE_CONVERTER_TOP_LEVEL - Behavioral 
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

entity REVERSE_CONVERTER_TOP_LEVEL is 
   generic(m : integer:=3);
   PORT(
	   x3 : in std_logic_vector(m-1 downto 0);
		x2 : in std_logic_vector(m-1 downto 0);
		x1 : in std_logic_vector(m downto 0);
		clock, reset : in std_logic;
		start : in std_logic;
		result_ready : out std_logic;
		result : out std_logic_vector(3*m -1 downto 0));
end REVERSE_CONVERTER_TOP_LEVEL;

architecture Behavioral of REVERSE_CONVERTER_TOP_LEVEL is

	 component DATAPATH is
		generic(m : integer);
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
	 end component;
	 
	 
	 component CONTROL_UNIT is
		port(
			clock, start, reset : in std_logic;
			count : in  STD_LOGIC_VECTOR (2 downto 0);
			
			countEN : out std_logic;
			load : out std_logic;
			muxsel_2to1 : out std_logic;
			muxsel_4to1 : out std_logic_vector(1 downto 0);
			tristate_select : out std_logic
			);
	 end component;
	 
	 
	 signal muxsel_2to1, tristate_select, countEN, load : std_logic; 
	 signal muxsel_4to1 : std_logic_vector(1 downto 0);
	 signal count :  STD_LOGIC_VECTOR (2 downto 0);
begin


   datap : DATAPATH
	   generic map(
		  m => m
		)
		port map(
		  x3 => x3,
		  x2 => x2,
		  x1 => x1,
		  clock => clock,		  
		  load => load,
		  countEN => countEN,
		  muxsel_2to1 => muxsel_2to1,
		  muxsel_4to1 => muxsel_4to1,
		  tristate_select => tristate_select,
		  count => count,		 
		  result => result
		);


   cu : CONTROL_UNIT
      port map(
		  clock => clock,		  
		  count => count,
		  start => start,
		  countEN => countEN,
		  load => load,
		  reset => reset,
		  muxsel_2to1 => muxsel_2to1,
		  muxsel_4to1 => muxsel_4to1,
		  tristate_select => tristate_select
		);  
		
		result_ready <= tristate_select;


end Behavioral;

