library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
    port(
        E     : in  std_logic_vector(0 to 3);
        Sel   : in  std_logic_vector(1 downto 0);
        Saida : out std_logic
    );
end mux4;

architecture Structural of mux4 is
    signal saida_primeiro_par : std_logic;
    signal saida_segundo_par  : std_logic;
begin
    MUX_PAR_0 : entity work.mux2
        port map(
            E     => E(0 to 1),
            Sel   => Sel(0),
            Saida => saida_primeiro_par
        );

    MUX_PAR_1 : entity work.mux2
        port map(
            E     => E(2 to 3),
            Sel   => Sel(0),
            Saida => saida_segundo_par
        );

    MUX_FINAL : entity work.mux2
        port map(
            E(0)  => saida_primeiro_par,
            E(1)  => saida_segundo_par,
            Sel   => Sel(1),
            Saida => Saida
        );
end Structural;

