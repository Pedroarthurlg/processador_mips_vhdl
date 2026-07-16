library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador32 is
    port(
        A    : in  std_logic_vector(31 downto 0);
        B    : in  std_logic_vector(31 downto 0);
        Soma : out std_logic_vector(31 downto 0)
    );
end somador32;

architecture Structural of somador32 is
    signal carry : std_logic_vector(0 to 31);
begin
    SOMADOR_BIT_0 : entity work.somador
        port map(
            A    => A(0),
            B    => B(0),
            Vem1 => '0',
            Soma => Soma(0),
            Vai1 => carry(0)
        );

    GEN_SOMADORES : for i in 1 to 31 generate
    begin
        SOMADOR_BIT : entity work.somador
            port map(
                A    => A(i),
                B    => B(i),
                Vem1 => carry(i - 1),
                Soma => Soma(i),
                Vai1 => carry(i)
            );
    end generate;
end Structural;

