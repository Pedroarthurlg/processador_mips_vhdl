library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodificador5x32 is
    port(
        c0, c1, c2, c3, c4 : in  std_logic;
        saida               : out std_logic_vector(31 downto 0)
    );
end decodificador5x32;

architecture Structural of decodificador5x32 is
    signal c4_negado      : std_logic;
    signal habilita_grupo : std_logic_vector(0 to 7);
begin
    c4_negado <= not c4;

    DECODIFICA_GRUPOS_0_A_3 : entity work.Decodificador2x4
        port map(
            Enable => c4_negado,
            C0     => c2,
            C1     => c3,
            S0     => habilita_grupo(0),
            S1     => habilita_grupo(1),
            S2     => habilita_grupo(2),
            S3     => habilita_grupo(3)
        );

    DECODIFICA_GRUPOS_4_A_7 : entity work.Decodificador2x4
        port map(
            Enable => c4,
            C0     => c2,
            C1     => c3,
            S0     => habilita_grupo(4),
            S1     => habilita_grupo(5),
            S2     => habilita_grupo(6),
            S3     => habilita_grupo(7)
        );

    GEN_GRUPOS : for i in 0 to 7 generate
    begin
        DECODIFICA_GRUPO : entity work.Decodificador2x4
            port map(
                Enable => habilita_grupo(i),
                C0     => c0,
                C1     => c1,
                S0     => saida(4 * i),
                S1     => saida(4 * i + 1),
                S2     => saida(4 * i + 2),
                S3     => saida(4 * i + 3)
            );
    end generate;
end Structural;

