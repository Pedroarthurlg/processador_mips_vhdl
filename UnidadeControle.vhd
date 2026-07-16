library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnidadeControle is
    port(
        opcode : in  std_logic_vector(5 downto 0);
        AluOp  : out std_logic_vector(1 downto 0);
        RegWrite, RegDst, ALU_Scr, Branch,
        MemWrite, MemToReg, Jump, MemRead  : out std_logic
    );
end UnidadeControle;

architecture Behavioral of UnidadeControle is
begin

    DECODIFICA_INSTRUCAO : process(opcode)
    begin
        -- Valores seguros para opcodes não implementados.
        AluOp    <= "00";
        RegWrite <= '0';
        RegDst   <= '0';
        ALU_Scr  <= '0';
        Branch   <= '0';
        MemWrite <= '0';
        MemToReg <= '0';
        Jump     <= '0';
        MemRead  <= '0';

        case opcode is
            when "000000" =>              -- tipo R
                AluOp    <= "10";
                RegWrite <= '1';
                RegDst   <= '1';

            when "001000" =>              -- addi
                RegWrite <= '1';
                ALU_Scr  <= '1';

            when "100011" =>              -- lw
                RegWrite <= '1';
                ALU_Scr  <= '1';
                MemToReg <= '1';
                MemRead  <= '1';

            when "101011" =>              -- sw
                ALU_Scr  <= '1';
                MemWrite <= '1';

            when "000100" =>              -- beq
                AluOp  <= "01";
                Branch <= '1';

            when "000010" =>              -- j
                Jump <= '1';

            when others =>
                null;
        end case;
    end process;
end Behavioral;
