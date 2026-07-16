library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mips is
    port(
        Clk           : in  std_logic;
        Inicializar   : in  std_logic;
        DebugEndereco : in  std_logic_vector(31 downto 0);
        DebugPalavra  : out std_logic_vector(31 downto 0);
        ds1, ds2, ds5, ds7, ds8, ds9, ds11, ds17, ds20,
        ds22, ds23, ds24, ds25, ds28, ds29 : out std_logic_vector(31 downto 0);
        ds4                            : out std_logic_vector(4 downto 0);
        ds12, ds13                    : out std_logic_vector(1 downto 0);
        ds3, ds6, ds10, ds14, ds15, ds16, ds18, ds19,
        ds21, ds26, ds27, ds30        : out std_logic
    );
end mips;

architecture Structural of mips is
    signal ds1_pc                  : std_logic_vector(31 downto 0);
    signal ds2_memIn               : std_logic_vector(31 downto 0);
    signal ds5_mux_para_wdata      : std_logic_vector(31 downto 0);
    signal ds7_saida1_banco        : std_logic_vector(31 downto 0);
    signal ds8_saida2_banco        : std_logic_vector(31 downto 0);
    signal ds9_saida_extensor      : std_logic_vector(31 downto 0);
    signal ds11_saida_mux_para_ula : std_logic_vector(31 downto 0);
    signal ds17_saida_ula          : std_logic_vector(31 downto 0);
    signal ds20_saida_memDados     : std_logic_vector(31 downto 0);
    signal ds22_saida_pc4          : std_logic_vector(31 downto 0);
    signal ds23_shift_jump         : std_logic_vector(31 downto 0);
    signal ds24_shift_extensor     : std_logic_vector(31 downto 0);
    signal ds25_saida_somador2     : std_logic_vector(31 downto 0);
    signal ds28_mux_para_mux       : std_logic_vector(31 downto 0);
    signal ds29_mux_para_pc        : std_logic_vector(31 downto 0);

    signal ds4_mux_para_wreg              : std_logic_vector(4 downto 0);
    signal ds12_saida_AluOp               : std_logic_vector(1 downto 0);
    signal ds13_saida_alu_control_op      : std_logic_vector(1 downto 0);
    signal ds3_regdst_para_mux            : std_logic;
    signal ds6_regWrite_para_banco        : std_logic;
    signal ds10_alusrc_para_mux           : std_logic;
    signal ds14_Ainverter                 : std_logic;
    signal ds15_Binverter                 : std_logic;
    signal ds16_zero_ula                  : std_logic;
    signal ds18_MemRead_para_MemDados     : std_logic;
    signal ds19_MemWrite_para_MemDados    : std_logic;
    signal ds21_MemtoReg_para_mux         : std_logic;
    signal ds26_saida_branch              : std_logic;
    signal ds27_saida_AND                 : std_logic;
    signal ds30_jump_para_mux             : std_logic;

    signal endereco_jump_deslocado : std_logic_vector(27 downto 0);

    constant QUATRO : std_logic_vector(31 downto 0) := x"00000004";

begin

    PC : entity work.registradorPC port map(
        D => ds29_mux_para_pc,
        Clk => Clk,
        Inicializar => Inicializar,
        Q => ds1_pc
    );
    
    MemInst : entity work.memInstrucoes port map(
        Endereco => ds1_pc,
        Palavra => ds2_memIn
    );

    Mux_para_wreg : entity work.mux2_5 port map(
       Entrada_A => ds2_memIn(20 downto 16),
       Entrada_B => ds2_memIn(15 downto 11),
       Sel => ds3_regdst_para_mux,
       Saida => ds4_mux_para_wreg 
    );
    
    BancoRegistradores : entity work.banco_de_registradores port map(
        Dado_escritaBR => ds5_mux_para_wdata,
        ClkBR => Clk,
        Escrever_regBR => ds6_regWrite_para_banco,
        End_EscritaBR => ds4_mux_para_wreg,
        End_leitura1BR => ds2_memIn(25 downto 21),
        End_leitura2BR => ds2_memIn(20 downto 16),
        Dado_L1BR => ds7_saida1_banco,
        Dado_L2BR => ds8_saida2_banco
    );

    Mux_para_ULA : entity work.mux2_32 port map(
        Entrada_A => ds8_saida2_banco,
        Entrada_B => ds9_saida_extensor,
        Sel => ds10_alusrc_para_mux,
        Saida => ds11_saida_mux_para_ula
    );

    ULA32 : entity work.ula32bits port map(
        A => ds7_saida1_banco, 
        B => ds11_saida_mux_para_ula,
        Ai => ds14_Ainverter,
        Bi => ds15_Binverter,
        OP => ds13_saida_alu_control_op,
        Resultado => ds17_saida_ula,
        Zero => ds16_zero_ula
    );

    MemDados_port : entity work.memDados port map(
        DadoLido => ds20_saida_memDados,
        DadoEscrita => ds8_saida2_banco,    
        Endereco => ds17_saida_ula,
        EscreverMem => ds19_MemWrite_para_MemDados, 
        Clock => Clk,
        LerMem => ds18_MemRead_para_MemDados,
        DebugEndereco => DebugEndereco,
        DebugPalavra => DebugPalavra
    );
    
    ControleULA : entity work.ULA_Controle port map(
        Alu_Op => ds12_saida_AluOp,
        Funct => ds2_memIn(5 downto 0),
        Ainverte=> ds14_Ainverter,
        BInverte =>  ds15_Binverter,
        Operacao => ds13_saida_alu_control_op
    );

    Extensor_port : entity work.extensor port map(
        Entrada_Extensor => ds2_memIn(15 downto 0),
        Saida_Extensor => ds9_saida_extensor
    );

    UnidadeControle_port : entity work.UnidadeControle port map(
        opcode => ds2_memIn(31 downto 26),
        AluOp => ds12_saida_AluOp,
        RegWrite => ds6_regWrite_para_banco,
        RegDst => ds3_regdst_para_mux,
        ALU_Scr => ds10_alusrc_para_mux,
        Branch => ds26_saida_branch,
        MemWrite => ds19_MemWrite_para_MemDados,
        MemToReg => ds21_MemtoReg_para_mux,
        Jump => ds30_jump_para_mux,
        MemRead => ds18_MemRead_para_MemDados
    );

    Mux_para_WData : entity work.mux2_32 port map(
         Entrada_A => ds17_saida_ula,
         Entrada_B => ds20_saida_memDados,
         Sel => ds21_MemtoReg_para_mux,
         Saida => ds5_mux_para_wdata
    );

    Somador_pc_mais4 : entity work.somador32 port map(
        A => ds1_pc,
        B => QUATRO,
        Soma => ds22_saida_pc4
    );

    Deslocador1 : entity work.deslocador port map(
        Entrada_Deslocador2 => ds2_memIn(25 downto 0),
        Saida_Deslocador2 => endereco_jump_deslocado
    );
    
    ds23_shift_jump <= ds22_saida_pc4(31 downto 28) & endereco_jump_deslocado;

    Deslocador2 : entity work.deslocador_32 port map(
        Entrada => ds9_saida_extensor,
        Saida => ds24_shift_extensor
    );

    Somador2 : entity work.somador32 port map(
        A => ds22_saida_pc4,
        B => ds24_shift_extensor,
        Soma => ds25_saida_somador2
    );

    ds27_saida_AND <= ds16_zero_ula and  ds26_saida_branch;

    Mux_somadores : entity work.mux2_32 port map(
        Entrada_A =>  ds22_saida_pc4,
        Entrada_B =>  ds25_saida_somador2,
        Sel => ds27_saida_AND,
        Saida =>  ds28_mux_para_mux
    );

    Mux_Jump : entity work.mux2_32 port map(
        Entrada_A =>  ds28_mux_para_mux,
        Entrada_B =>  ds23_shift_jump,
        Sel => ds30_jump_para_mux,
        Saida =>  ds29_mux_para_pc
    );

    ds1  <= ds1_pc;
    ds2  <= ds2_memIn;
    ds3  <= ds3_regdst_para_mux;
    ds4  <= ds4_mux_para_wreg;
    ds5  <= ds5_mux_para_wdata;
    ds6  <= ds6_regWrite_para_banco;
    ds7  <= ds7_saida1_banco;
    ds8  <= ds8_saida2_banco;
    ds9  <= ds9_saida_extensor;
    ds10 <= ds10_alusrc_para_mux;
    ds11 <= ds11_saida_mux_para_ula;
    ds12 <= ds12_saida_AluOp;
    ds13 <= ds13_saida_alu_control_op;
    ds14 <= ds14_Ainverter;
    ds15 <= ds15_Binverter;
    ds16 <= ds16_zero_ula;
    ds17 <= ds17_saida_ula;
    ds18 <= ds18_MemRead_para_MemDados;
    ds19 <= ds19_MemWrite_para_MemDados;
    ds20 <= ds20_saida_memDados;
    ds21 <= ds21_MemtoReg_para_mux;
    ds22 <= ds22_saida_pc4;
    ds23 <= ds23_shift_jump;
    ds24 <= ds24_shift_extensor;
    ds25 <= ds25_saida_somador2;
    ds26 <= ds26_saida_branch;
    ds27 <= ds27_saida_AND;
    ds28 <= ds28_mux_para_mux;
    ds29 <= ds29_mux_para_pc;
    ds30 <= ds30_jump_para_mux;

end Structural;

