library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula32bits is
    port(
        A, B      : in  std_logic_vector(31 downto 0);
        OP        : in  std_logic_vector(1 downto 0);
        Ai, Bi    : in  std_logic;
        Resultado : out std_logic_vector(31 downto 0);
        Zero      : out std_logic
    );
end ula32bits;

architecture Structural of ula32bits is
    signal carry             : std_logic_vector(32 downto 0);
    signal resultado_interno : std_logic_vector(31 downto 0);
    signal set_msb           : std_logic;
    signal or_nivel_1        : std_logic_vector(7 downto 0);
    signal or_nivel_2        : std_logic_vector(1 downto 0);
begin
    -- Bi também é o carry inicial nas operações de subtração.
    carry(0) <= Bi;

    ULA_BIT_0 : entity work.ULA1b
        port map(
            op        => OP,
            a         => A(0),
            b         => B(0),
            ai        => Ai,
            bi        => Bi,
            less      => set_msb,
            vem1      => carry(0),
            vai1      => carry(1),
            set       => open,
            resultado => resultado_interno(0)
        );

    GEN_ULAS_INTERMEDIARIAS : for i in 1 to 30 generate
    begin
        ULA_BIT : entity work.ULA1b
            port map(
                op        => OP,
                a         => A(i),
                b         => B(i),
                ai        => Ai,
                bi        => Bi,
                less      => '0',
                vem1      => carry(i),
                vai1      => carry(i + 1),
                set       => open,
                resultado => resultado_interno(i)
            );
    end generate;

    ULA_BIT_31 : entity work.ULA1b
        port map(
            op        => OP,
            a         => A(31),
            b         => B(31),
            ai        => Ai,
            bi        => Bi,
            less      => '0',
            vem1      => carry(31),
            vai1      => carry(32),
            set       => set_msb,
            resultado => resultado_interno(31)
        );

    -- Árvore de OR com no máximo quatro entradas por porta.
    GEN_OR_NIVEL_1 : for i in 0 to 7 generate
    begin
        or_nivel_1(i) <= resultado_interno(4 * i)
                      or resultado_interno(4 * i + 1)
                      or resultado_interno(4 * i + 2)
                      or resultado_interno(4 * i + 3);
    end generate;

    or_nivel_2(0) <= or_nivel_1(0) or or_nivel_1(1)
                  or or_nivel_1(2) or or_nivel_1(3);
    or_nivel_2(1) <= or_nivel_1(4) or or_nivel_1(5)
                  or or_nivel_1(6) or or_nivel_1(7);

    Zero      <= not (or_nivel_2(0) or or_nivel_2(1));
    Resultado <= resultado_interno;
end Structural;

