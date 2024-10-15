--               The inputs are  
--               signals A, B, C with one output Y that is true only if at  
--               least 2 of the inputs are true.
 
 

library ieee;
use ieee.std_logic_1164.all;

entity Majority is
    port (
        A, B, C: in std_logic;
        Y: out std_logic
    );
end Majority;

architecture behavioral of Majority is
begin
    process (A, B, C)
    begin
        if (A = '1' and B = '1') or (A = '1' and C = '1') or (B = '1' and C = '1') then
            Y <= '1';
        else
            Y <= '0';
        end if;
    end process;
end behavioral;
