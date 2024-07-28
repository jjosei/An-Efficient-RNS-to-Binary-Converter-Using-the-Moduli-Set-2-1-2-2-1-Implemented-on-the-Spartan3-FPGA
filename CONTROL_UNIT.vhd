----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:57:51 07/08/2024 
-- Design Name: 
-- Module Name:    CONTROL_UNIT - Behavioral 
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

entity CONTROL_UNIT is
	port(
	   clock, start, reset : in std_logic;
      count : IN STD_LOGIC_VECTOR(2 downto 0);
--		carry_out : in std_logic;
		
		load : out std_logic;
		countEN : out std_logic;
		muxsel_2to1 : out std_logic;
		muxsel_4to1 : out std_logic_vector(1 downto 0);
		tristate_select : out std_logic
		);
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is
   type state is (ST0, ST1, ST2, ST3, ST4);
	signal PS, NS : state;
	signal control : std_logic_vector(5 downto 0);

begin
   countEN <= control(5);
   load <= control(4);
	muxsel_2to1 <= control(3);
	muxsel_4to1 <= control(2) & control(1);
	tristate_select <= control(0);
	
	sync : process(count, clock, NS)
	begin
--	  if count = "000" then
--	     PS <= ST0;
--	  els
	  if rising_edge(clock) then
        PS <= NS;
     end if;
   end process;	  
	    
	
	combina : process(count, reset, start, PS)
	begin
	 case PS is 
	  when ST0 =>
	     control <= "111000";
		  if start = '0' then
		   NS <= ST0;
		  else
         NS <= ST1;
        end if;			
		  
	  when ST1 =>
	     control <= "010110";
		  if count = "001" then
		     NS <= ST2;
        elsif count = "010" then
		     NS <= ST3;
		  elsif count = "011" then
		     NS <= ST4;	
        else
			  NS <= ST0;
        end if;			  

     when ST2 =>
        control <= "110010";
        NS <= ST1;	

     when ST3 =>
        control <= "110100";
        NS <= ST1;	

     when ST4 =>
        control <= "000001";	  
		  if reset = '1' then
		    NS <= ST0;
		  else
          NS <= ST4;
        end if;

     
	  when OTHERS =>
		  control <= "000000";
		  NS <= ST0;

    end case; 		  
	

    
   end process;	  
  
end Behavioral;



--   combina : process(carry_out, PS)
--	begin
--    case PS is 
--	  when ST0 =>
--	     control <= "00000";
--		  NS <= ST1;
--		  
--	  when ST1 =>
--	     control <= "10000";
--        NS <= ST2;
--		  
--	  when ST2 =>
--        control <= "11000";	
--        if carry_out = '1' then
--           NS <= ST3;
--        else
--           NS <= ST4;
--        end if;
--
--	  when ST3 => 
--		  control <= "10110";
--		  NS <= ST4;
--		  
--	  when ST4 =>
--		  control <= "10010";
--        if carry_out = '1' then
--           NS <= ST5;
--        else
--           NS <= ST6;
--        end if;		  
--
--	  when ST5 =>
--	     control <= "10110";
--		  NS <= ST6;
--		  
--	  when ST6 =>
--		  control <= "10100";
--        if carry_out = '1' then
--           NS <= ST7;
--        else
--           NS <= ST8;
--        end if;
--
--	  when ST7 => 
--	     control <= "10110";
--		  NS <= ST8;
--
--     when ST8 =>
--        control <= "00001";
--		  NS <= ST8;
--		  
--	  when OTHERS =>
--		  control <= "00000";
--		  NS <= ST0;			 
--    end case; 