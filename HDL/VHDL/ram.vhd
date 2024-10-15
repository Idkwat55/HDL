LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;

architecture ram_design of RAM128_32 is 
type mem_addr_type is  array(0 to 128) of std_logic_vector (31 downto 0);   
signal mem_addr:mem_addr_type ;  
begin 

process (clock)
begin

if rising_edge(clock) then 

if wren = '1' then  
mem_addr(to_integer(unsigned(address)))<= data;

elsif wren = '0' then 

q<= mem_addr(to_integer(unsigned(address)));

end if;
end if;

q<= mem_addr(to_integer(unsigned(address)));

end process;

end architecture;


