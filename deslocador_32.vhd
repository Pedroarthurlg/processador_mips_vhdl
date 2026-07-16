library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deslocador_32 is
    port(
        Entrada : in  std_logic_vector(31 downto 0);
        Saida   : out std_logic_vector(31 downto 0)
    );
end deslocador_32;

architecture Behavioral of deslocador_32 is
begin
    Saida <= Entrada(29 downto 0) & "00";
end Behavioral;

