----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Milene
-- 
-- Create Date:    13:50:52 07/01/2022 
-- Module Name:    memDados - Behavioral 
-- 
-- Memoria de dados do MIPS simplificada, contendo somente 256 palavras de 32 bits.
-- Essa memoria eh endereçada por bytes, mas a implementacao usa um vetor de palavras,
-- portanto, eh necessario converter o endereco de memoria de bytes para palavras.
-- A memoria possui 2 sinais adicionais para depuracao do processador (debug). Eles
-- permitem que no testbench do processador diversas posicoes da memoria sejam acessadas
-- independentemente de instrucoes do processador.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memDados is
    port(
        DadoLido      : out std_logic_vector(31 downto 0);
        DadoEscrita   : in  std_logic_vector(31 downto 0);
        Endereco      : in  std_logic_vector(31 downto 0);
        EscreverMem   : in  std_logic;
        Clock         : in  std_logic;
        LerMem        : in  std_logic;
        DebugEndereco : in  std_logic_vector(31 downto 0);
        DebugPalavra  : out std_logic_vector(31 downto 0)
    );
end memDados;

architecture Behavioral of memDados is
    type tipo_memoria is array(0 to 255) of std_logic_vector(31 downto 0);
    signal memoria : tipo_memoria;
begin
    ESCRITA : process(Clock)
    begin
        if rising_edge(Clock) then
            if EscreverMem = '1' then
                memoria(to_integer(unsigned(Endereco(9 downto 2)))) <= DadoEscrita;
            end if;
        end if;
    end process;

    -- Os dois bits menos significativos são ignorados: a memória é endereçada
    -- externamente por bytes, mas armazenada internamente por palavras.
    LEITURA : process(memoria, Endereco, LerMem)
    begin
        if LerMem = '1' then
            DadoLido <= memoria(to_integer(unsigned(Endereco(9 downto 2))));
        end if;
    end process;

    DebugPalavra <= memoria(to_integer(unsigned(DebugEndereco(9 downto 2))));
end Behavioral;
