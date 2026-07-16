library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deslocador is
    port(
        Entrada_Deslocador2 : in  std_logic_vector(25 downto 0);
        Saida_Deslocador2   : out std_logic_vector(27 downto 0)
    );
end deslocador;

architecture Behavioral of deslocador is
begin
    Saida_Deslocador2 <= Entrada_Deslocador2 & "00";
end Behavioral;

