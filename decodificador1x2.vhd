library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodificador1x2 is
    port(
        C, Enable : in  std_logic;
        S0, S1    : out std_logic
    );
end decodificador1x2;

architecture Behavioral of decodificador1x2 is
begin
    S0 <= (not C) and Enable;
    S1 <= C and Enable;
end Behavioral;

