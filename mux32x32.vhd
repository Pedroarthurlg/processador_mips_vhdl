library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tipo.ALL;

entity mux32x32 is
    port(
        E     : in tipo_vetor_de_palavras(0 to 31);
        Sel   : in std_logic_vector(4 downto 0);
        Saida : out tipo_palavra
    );
end mux32x32;

architecture Structural of mux32x32 is
begin
    GEN_BITS : for i in 0 to 31 generate
        signal entrada_bit : std_logic_vector(0 to 31);
    begin
        GEN_ENTRADAS : for j in 0 to 31 generate
        begin
            entrada_bit(j) <= E(j)(i);
        end generate;

        MUX_BIT : entity work.mux32
            port map(
                E     => entrada_bit,
                Sel   => Sel,
                Saida => Saida(i)
            );
    end generate;
end Structural;
