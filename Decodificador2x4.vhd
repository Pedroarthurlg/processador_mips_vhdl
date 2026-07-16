library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decodificador2x4 is
    port(
        Enable, C0, C1 : in  std_logic;
        S0, S1, S2, S3 : out std_logic
    );
end Decodificador2x4;

architecture Structural of Decodificador2x4 is
    signal habilita_metade_inferior : std_logic;
    signal habilita_metade_superior : std_logic;
begin
    DECODIFICA_C1 : entity work.decodificador1x2
        port map(
            C      => C1,
            Enable => Enable,
            S0     => habilita_metade_inferior,
            S1     => habilita_metade_superior
        );

    DECODIFICA_C0_INFERIOR : entity work.decodificador1x2
        port map(
            C      => C0,
            Enable => habilita_metade_inferior,
            S0     => S0,
            S1     => S1
        );

    DECODIFICA_C0_SUPERIOR : entity work.decodificador1x2
        port map(
            C      => C0,
            Enable => habilita_metade_superior,
            S0     => S2,
            S1     => S3
        );
end Structural;

