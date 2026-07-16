library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflopD_AS is
    port(
        D   : in  std_logic;
        Clk : in  std_logic;
        Set : in  std_logic;
        Clr : in  std_logic;
        Q   : out std_logic
    );
end flipflopD_AS;

architecture Behavioral of flipflopD_AS is
begin
    ARMAZENAMENTO : process(Clk, Set, Clr)
    begin
        if Set = '1' then
            Q <= '1';
        elsif Clr = '1' then
            Q <= '0';
        elsif rising_edge(Clk) then
            Q <= D;
        end if;
    end process;
end Behavioral;
