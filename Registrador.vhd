library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registrador is
    port(
        D           : in  std_logic_vector(31 downto 0);
        Clk, Enable : in  std_logic;
        Q           : out std_logic_vector(31 downto 0)
    );
end Registrador;

architecture Structural of Registrador is
begin
    GEN_FLIP_FLOPS : for i in 0 to 31 generate
    begin
        FLIP_FLOP : entity work.flipflopD
            port map(
                D      => D(i),
                Clk    => Clk,
                Enable => Enable,
                Q      => Q(i)
            );
    end generate;
end Structural;

