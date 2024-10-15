library ieee;                                	
use ieee.std_logic_1164.all;           	
                                             		
entity comparator2 is port (                 	
    A, B: in std_logic_vector(1 downto 0); 
    Equals: out std_logic);            		
end comparator2;                             	




architecture ComparatorArchi of comparator2  is 
begin 
process (A,B)
begin 
if A = B then 
Equals <= '1';
else 
Equals <= '0';
end if;

end process;
end  architecture ComparatorArchi; 