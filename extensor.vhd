library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extensor is
    port(
        Entrada_Extensor : in  std_logic_vector(15 downto 0);
        Saida_Extensor   : out std_logic_vector(31 downto 0)
    );
end extensor;

architecture Behavioral of extensor is
begin
    Saida_Extensor(15 downto 0)  <= Entrada_Extensor;
    Saida_Extensor(31 downto 16) <= (others => Entrada_Extensor(15));
end Behavioral;

