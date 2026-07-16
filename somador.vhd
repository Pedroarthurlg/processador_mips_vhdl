library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador is
    port(
        A, B, Vem1 : in  std_logic;
        Soma, Vai1 : out std_logic
    );
end somador;

architecture Behavioral of somador is
begin
    Soma <= A xor B xor Vem1;
    Vai1 <= (A and B) or (A and Vem1) or (B and Vem1);
end Behavioral;

