library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ULA1b is
    port(
        op                        : in  std_logic_vector(1 downto 0);
        a, b, ai, bi, less, vem1 : in  std_logic;
        vai1, set, resultado      : out std_logic
    );
end ULA1b;

architecture Structural of ULA1b is
    signal a_negado       : std_logic;
    signal b_negado       : std_logic;
    signal a_selecionado : std_logic;
    signal b_selecionado : std_logic;
    signal soma          : std_logic;
    signal resultado_and : std_logic;
    signal resultado_or  : std_logic;
begin
    a_negado <= not a;
    b_negado <= not b;

    MUX_A : entity work.mux2
        port map(
            E(0)  => a,
            E(1)  => a_negado,
            Sel   => ai,
            Saida => a_selecionado
        );

    MUX_B : entity work.mux2
        port map(
            E(0)  => b,
            E(1)  => b_negado,
            Sel   => bi,
            Saida => b_selecionado
        );

    SOMADOR_COMPLETO : entity work.somador
        port map(
            A    => a_selecionado,
            B    => b_selecionado,
            Vem1 => vem1,
            Soma => soma,
            Vai1 => vai1
        );

    set           <= soma;
    resultado_and <= a_selecionado and b_selecionado;
    resultado_or  <= a_selecionado or b_selecionado;

    MUX_RESULTADO : entity work.mux4
        port map(
            E(0)  => resultado_and,
            E(1)  => resultado_or,
            E(2)  => soma,
            E(3)  => less,
            Sel   => op,
            Saida => resultado
        );
end Structural;

