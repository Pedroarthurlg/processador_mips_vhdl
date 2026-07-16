library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ULA_Controle is
    port(
        Alu_Op             : in  std_logic_vector(1 downto 0);
        Funct              : in  std_logic_vector(5 downto 0);
        Ainverte, BInverte : out std_logic;
        Operacao           : out std_logic_vector(1 downto 0)
    );
end ULA_Controle;

architecture Behavioral of ULA_Controle is
begin
    DECODIFICA_OPERACAO : process(Alu_Op, Funct)
    begin
        -- Valores seguros para códigos não implementados.
        Ainverte <= '0';
        BInverte <= '0';
        Operacao <= "00";

        case Alu_Op is
            when "00" =>                 -- lw, sw e addi
                Operacao <= "10";        -- soma

            when "01" =>                 -- beq
                BInverte <= '1';
                Operacao <= "10";        -- subtração

            when "10" =>                 -- instruções do tipo R
                case Funct is
                    when "100000" =>     -- add
                        Operacao <= "10";
                    when "100100" =>     -- and
                        Operacao <= "00";
                    when "100111" =>     -- nor
                        Ainverte <= '1';
                        BInverte <= '1';
                        Operacao <= "00";
                    when "100101" =>     -- or
                        Operacao <= "01";
                    when "101010" =>     -- slt
                        BInverte <= '1';
                        Operacao <= "11";
                    when "100010" =>     -- sub
                        BInverte <= '1';
                        Operacao <= "10";
                    when others =>
                        null;
                end case;

            when others =>
                null;
        end case;
    end process;
end Behavioral;

