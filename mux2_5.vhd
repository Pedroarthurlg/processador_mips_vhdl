library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_5 is
    port(
        Entrada_A : in  std_logic_vector(4 downto 0);
        Entrada_B : in  std_logic_vector(4 downto 0);
        Sel       : in  std_logic;
        Saida     : out std_logic_vector(4 downto 0)
    );
end mux2_5;

architecture Structural of mux2_5 is
begin
    GEN_MUX : for i in Saida'range generate
    begin
        MUX_BIT : entity work.mux2
            port map(
                E(0)  => Entrada_A(i),
                E(1)  => Entrada_B(i),
                Sel   => Sel,
                Saida => Saida(i)
            );
    end generate;
end Structural;

