library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registradorPC is
    port(
        D           : in  std_logic_vector(31 downto 0);
        Clk         : in  std_logic;
        Inicializar : in  std_logic;
        Q           : out std_logic_vector(31 downto 0)
    );
end registradorPC;

architecture Structural of registradorPC is
begin
    -- O endereço inicial do programa é 0x00400000: somente o bit 22 inicia em 1.
    GEN_SUPERIOR : for i in 31 downto 23 generate
    begin
        FF : entity work.flipflopD_AS
            port map(
                D   => D(i),
                Clk => Clk,
                Set => '0',
                Clr => Inicializar,
                Q   => Q(i)
            );
    end generate;

    FF_BIT_22 : entity work.flipflopD_AS
        port map(
            D   => D(22),
            Clk => Clk,
            Set => Inicializar,
            Clr => '0',
            Q   => Q(22)
        );

    GEN_INFERIOR : for i in 21 downto 0 generate
    begin
        FF : entity work.flipflopD_AS
            port map(
                D   => D(i),
                Clk => Clk,
                Set => '0',
                Clr => Inicializar,
                Q   => Q(i)
            );
    end generate;
end Structural;
