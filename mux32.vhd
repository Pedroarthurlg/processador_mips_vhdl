library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32 is
    port(
        E     : in  std_logic_vector(0 to 31);
        Sel   : in  std_logic_vector(4 downto 0);
        Saida : out std_logic
    );
end mux32;

architecture Structural of mux32 is
    signal nivel_1 : std_logic_vector(0 to 7);
    signal nivel_2 : std_logic_vector(0 to 3);
begin
    GEN_NIVEL_1 : for i in 0 to 7 generate
    begin
        MUX_4 : entity work.mux4
            port map(
                E     => E(4 * i to 4 * i + 3),
                Sel   => Sel(1 downto 0),
                Saida => nivel_1(i)
            );
    end generate;

    GEN_NIVEL_2 : for i in 0 to 3 generate
    begin
        MUX_2 : entity work.mux2
            port map(
                E     => nivel_1(2 * i to 2 * i + 1),
                Sel   => Sel(2),
                Saida => nivel_2(i)
            );
    end generate;

    MUX_FINAL : entity work.mux4
        port map(
            E     => nivel_2,
            Sel   => Sel(4 downto 3),
            Saida => Saida
        );
end Structural;

