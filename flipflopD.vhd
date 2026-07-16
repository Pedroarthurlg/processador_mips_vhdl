library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflopD is
    port(
        D, Clk, Enable : in  std_logic;
        Q              : out std_logic
    );
end flipflopD;

architecture Behavioral of flipflopD is
begin
    ARMAZENAMENTO : process(Clk)
    begin
        if falling_edge(Clk) then
            if Enable = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;

