library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tipo.all;

entity banco_de_registradores is
    port(
        Dado_escritaBR : in  std_logic_vector(31 downto 0);
        ClkBR          : in  std_logic;
        Escrever_regBR : in  std_logic;
        End_EscritaBR  : in  std_logic_vector(4 downto 0);
        End_leitura1BR : in  std_logic_vector(4 downto 0);
        End_leitura2BR : in  std_logic_vector(4 downto 0);
        Dado_L1BR      : out std_logic_vector(31 downto 0);
        Dado_L2BR      : out std_logic_vector(31 downto 0)
    );
end banco_de_registradores;

architecture Structural of banco_de_registradores is
    signal selecao_escrita   : std_logic_vector(31 downto 0);
    signal habilita_escrita  : std_logic_vector(31 downto 1);
    signal banco             : tipo_vetor_de_palavras(0 to 31);
begin
    DECODIFICADOR_ESCRITA : entity work.decodificador5x32
        port map(
            c0    => End_EscritaBR(0),
            c1    => End_EscritaBR(1),
            c2    => End_EscritaBR(2),
            c3    => End_EscritaBR(3),
            c4    => End_EscritaBR(4),
            saida => selecao_escrita
        );

    -- O registrador $zero é constante e nunca recebe habilitação de escrita.
    banco(0) <= (others => '0');

    GEN_REGISTRADORES : for i in 1 to 31 generate
    begin
        habilita_escrita(i) <= selecao_escrita(i) and Escrever_regBR;

        REGISTRADOR_I : entity work.Registrador
            port map(
                D      => Dado_escritaBR,
                Clk    => ClkBR,
                Enable => habilita_escrita(i),
                Q      => banco(i)
            );
    end generate;

    MUX_LEITURA_1 : entity work.mux32x32
        port map(
            E     => banco,
            Sel   => End_leitura1BR,
            Saida => Dado_L1BR
        );

    MUX_LEITURA_2 : entity work.mux32x32
        port map(
            E     => banco,
            Sel   => End_leitura2BR,
            Saida => Dado_L2BR
        );
end Structural;

