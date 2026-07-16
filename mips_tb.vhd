--------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Milene
--
-- Create Date:   14:27:21 06/17/2026
-- Design Name:   
-- Module Name:   mips_tb.vhd
-- Project Name:  MIPS
-- 
-- Gera no console os valores dos sinais que comeca com ds. Apos 50 pulsos de clock,
-- le as 11 primeiras posicoes da memoria.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library std;
use std.textio.all;
use ieee.std_logic_textio.all;
 
ENTITY mips_tb IS
END mips_tb;
 
ARCHITECTURE behavior OF mips_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mips
    PORT(
         Clk : IN  std_logic;
         Inicializar : IN  std_logic;
         DebugEndereco : IN  std_logic_vector(31 downto 0);
         DebugPalavra : OUT  std_logic_vector(31 downto 0);
         ds1 : OUT  std_logic_vector(31 downto 0);
         ds2 : OUT  std_logic_vector(31 downto 0);
         ds5 : OUT  std_logic_vector(31 downto 0);
         ds7 : OUT  std_logic_vector(31 downto 0);
         ds8 : OUT  std_logic_vector(31 downto 0);
         ds9 : OUT  std_logic_vector(31 downto 0);
         ds11 : OUT  std_logic_vector(31 downto 0);
         ds17 : OUT  std_logic_vector(31 downto 0);
         ds20 : OUT  std_logic_vector(31 downto 0);
         ds22 : OUT  std_logic_vector(31 downto 0);
         ds23 : OUT  std_logic_vector(31 downto 0);
         ds24 : OUT  std_logic_vector(31 downto 0);
         ds25 : OUT  std_logic_vector(31 downto 0);
         ds28 : OUT  std_logic_vector(31 downto 0);
         ds29 : OUT  std_logic_vector(31 downto 0);
         ds4 : OUT  std_logic_vector(4 downto 0);
         ds12 : OUT  std_logic_vector(1 downto 0);
         ds13 : OUT  std_logic_vector(1 downto 0);
         ds3 : OUT  std_logic;
         ds6 : OUT  std_logic;
         ds10 : OUT  std_logic;
         ds14 : OUT  std_logic;
         ds15 : OUT  std_logic;
         ds16 : OUT  std_logic;
         ds18 : OUT  std_logic;
         ds19 : OUT  std_logic;
         ds21 : OUT  std_logic;
         ds26 : OUT  std_logic;
         ds27 : OUT  std_logic;
         ds30 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Inicializar : std_logic := '0';
   signal DebugEndereco : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DebugPalavra : std_logic_vector(31 downto 0);
   signal ds1 : std_logic_vector(31 downto 0);
   signal ds2 : std_logic_vector(31 downto 0);
   signal ds5 : std_logic_vector(31 downto 0);
   signal ds7 : std_logic_vector(31 downto 0);
   signal ds8 : std_logic_vector(31 downto 0);
   signal ds9 : std_logic_vector(31 downto 0);
   signal ds11 : std_logic_vector(31 downto 0);
   signal ds17 : std_logic_vector(31 downto 0);
   signal ds20 : std_logic_vector(31 downto 0);
   signal ds22 : std_logic_vector(31 downto 0);
   signal ds23 : std_logic_vector(31 downto 0);
   signal ds24 : std_logic_vector(31 downto 0);
   signal ds25 : std_logic_vector(31 downto 0);
   signal ds28 : std_logic_vector(31 downto 0);
   signal ds29 : std_logic_vector(31 downto 0);
   signal ds4 : std_logic_vector(4 downto 0);
   signal ds12 : std_logic_vector(1 downto 0);
   signal ds13 : std_logic_vector(1 downto 0);
   signal ds3 : std_logic;
   signal ds6 : std_logic;
   signal ds10 : std_logic;
   signal ds14 : std_logic;
   signal ds15 : std_logic;
   signal ds16 : std_logic;
   signal ds18 : std_logic;
   signal ds19 : std_logic;
   signal ds21 : std_logic;
   signal ds26 : std_logic;
   signal ds27 : std_logic;
   signal ds30 : std_logic;
	
	signal ds2a, ds2f  : std_logic_vector(5 downto 0);
	signal ds2b, ds2c, ds2d : std_logic_vector(4 downto 0);
	signal ds2e : std_logic_vector(15 downto 0);
	signal ds2g : std_logic_vector(25 downto 0);

	signal Stop : std_logic := '0';

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
	-- As funcoes a seguir foram feitas com o auxilio do Gemini
	function to_u_integer(sinal : std_logic_vector) return string is
	begin
	-- Verifica se existem metavalores ('U', 'X', 'Z', 'W', '-')
		if is_X(sinal) then
			return string'("X");
		else
			return integer'image(to_integer(unsigned(sinal)));
		end if;
	end function; 
	
	function to_s_integer(sinal : std_logic_vector) return string is
	begin
	-- Verifica se existem metavalores ('U', 'X', 'Z', 'W', '-')
		if is_X(sinal) then
			return string'("X");
		else
			return integer'image(to_integer(signed(sinal)));
		end if;
	end function; 	
	
BEGIN

	ds2a <= ds2(31 downto 26);
	ds2b <= ds2(25 downto 21);
	ds2c <= ds2(20 downto 16);
	ds2d <= ds2(15 downto 11);
	ds2e <= ds2(15 downto 0);
	ds2f <= ds2(5 downto 0);
	ds2g <= ds2(25 downto 0);
	
	-- Instantiate the Unit Under Test (UUT)
   uut: mips PORT MAP (
          Clk => Clk,
          Inicializar => Inicializar,
          DebugEndereco => DebugEndereco,
          DebugPalavra => DebugPalavra,
          ds1 => ds1,
          ds2 => ds2,
          ds5 => ds5,
          ds7 => ds7,
          ds8 => ds8,
          ds9 => ds9,
          ds11 => ds11,
          ds17 => ds17,
          ds20 => ds20,
          ds22 => ds22,
          ds23 => ds23,
          ds24 => ds24,
          ds25 => ds25,
          ds28 => ds28,
          ds29 => ds29,
          ds4 => ds4,
          ds12 => ds12,
          ds13 => ds13,
          ds3 => ds3,
          ds6 => ds6,
          ds10 => ds10,
          ds14 => ds14,
          ds15 => ds15,
          ds16 => ds16,
          ds18 => ds18,
          ds19 => ds19,
          ds21 => ds21,
          ds26 => ds26,
          ds27 => ds27,
          ds30 => ds30
        );

   -- Clock process definitions
   Clk_process :process
   begin
		if Stop = '0' then
			Clk <= '0';
			wait for Clk_period/2;
			Clk <= '1';
			wait for Clk_period/2;
		else
        	wait;
		end if;
   end process;
 
	-- Processo para escrever no console os valores dos sinais
	-- feito com auxilio do chatgpt
	monitor_proc : process(Clk)
		variable L : line;
		variable first_time : boolean := true;
	begin

		if falling_edge(Clk) then

			-- Cabeçalho da tabela
			if first_time then
				write(L, string'("Tempo")); write(L, HT);
				write(L, string'("ds1_PC")); write(L, HT);
--				write(L, string'("ds2_Instrucao")); write(L, HT);
				write(L, string'("ds2a_opcode")); write(L, HT);
				write(L, string'("ds2b_RegL1")); write(L, HT);
				write(L, string'("ds2c_RegL2_ou_E")); write(L, HT);
				write(L, string'("ds2d_RegE")); write(L, HT);
				write(L, string'("ds2e_Constante")); write(L, HT);
				write(L, string'("ds2f_Funct")); write(L, HT);
				write(L, string'("ds2g_End_jmp")); write(L, HT);
				write(L, string'("ds3_Segundo_ou_terceiro")); write(L, HT);
				write(L, string'("ds4_Registrador_destino")); write(L, HT);
				write(L, string'("ds5_Dado_escrita")); write(L, HT);
				write(L, string'("ds6_Escrever_reg")); write(L, HT);
				write(L, string'("ds7_DadoL1")); write(L, HT);
				write(L, string'("ds8_DadoL2")); write(L, HT);
				write(L, string'("ds9_Constante")); write(L, HT);
				write(L, string'("ds10_Reg2_ou_constante")); write(L, HT);
				write(L, string'("ds11_Operando2")); write(L, HT);
				write(L, string'("ds12_ALUOp")); write(L, HT);
				write(L, string'("ds13_Operacao")); write(L, HT);
				write(L, string'("ds14_Ainvert")); write(L, HT);
				write(L, string'("ds15_Binvert")); write(L, HT);
				write(L, string'("ds16_Zero")); write(L, HT);
				write(L, string'("ds17_ResultadoUla")); write(L, HT);
				write(L, string'("ds18_LerMem")); write(L, HT);
				write(L, string'("ds19_EscreverMem")); write(L, HT);
				write(L, string'("ds20_Dado_leitura_mem")); write(L, HT);
				write(L, string'("ds21_Ula_ou_mem")); write(L, HT);
				write(L, string'("ds22_PC_mais4")); write(L, HT);
				write(L, string'("ds23_end_jump")); write(L, HT);
				write(L, string'("ds24_Deslocamento_beq")); write(L, HT);
				write(L, string'("ds25_PC_mais4_maisDesloc")); write(L, HT);
				write(L, string'("ds26_Beq")); write(L, HT);
				write(L, string'("ds27_Saltar")); write(L, HT);
				write(L, string'("ds28_Beq_ou_prox")); write(L, HT);
				write(L, string'("ds29_Prox_PC")); write(L, HT);
				write(L, string'("ds30_Salta_j")); write(L, HT);
				writeline(output, L);

				first_time := false;

			end if;

			-- Dados
			write(L, now);      write(L, HT);
			hwrite(L, ds1);     write(L, HT);
--			hwrite(L, ds2);     write(L, HT);
	      write(L, ds2a);    write(L, HT);
	      write(L, to_u_integer(ds2b));   write(L, HT);
	      write(L, to_u_integer(ds2c));   write(L, HT);
	      write(L, to_u_integer(ds2d));   write(L, HT);
	      write(L, to_s_integer(ds2e));   write(L, HT);
	      write(L, ds2f);    write(L, HT);
	      hwrite(L, "00"&ds2g);      write(L, HT);
			write(L, ds3);      write(L, HT);
			write(L, to_u_integer(ds4));   write(L, HT);
		   write(L, to_s_integer(ds5));     write(L, HT);
			write(L, ds6);      write(L, HT);
			write(L, to_s_integer(ds7));   write(L, HT);
			write(L, to_s_integer(ds8));   write(L, HT);
			write(L, to_s_integer(ds9));   write(L, HT);
			write(L, ds10);     write(L, HT);
			write(L, to_s_integer(ds11));  write(L, HT);
			write(L, to_u_integer(ds12));   write(L, HT);
			write(L, to_u_integer(ds13));   write(L, HT);
			write(L, ds14);     write(L, HT);
			write(L, ds15);     write(L, HT);
			write(L, ds16);     write(L, HT);
			write(L, to_s_integer(ds17));  write(L, HT);
			write(L, ds18);     write(L, HT);
			write(L, ds19);     write(L, HT);
			write(L, to_u_integer(ds20));  write(L, HT);
			write(L, ds21);     write(L, HT);      
			hwrite(L, ds22);    write(L, HT);
			hwrite(L, ds23);    write(L, HT);
			hwrite(L, ds24);    write(L, HT);
			hwrite(L, ds25);    write(L, HT);
			write(L, ds26);     write(L, HT);
			write(L, ds27);     write(L, HT);
			hwrite(L, ds28);    write(L, HT);
			hwrite(L, ds29);    write(L, HT);
			write(L, ds30);     write(L, HT);

			writeline(output, L);
		end if;
	end process;


   -- Stimulus process
   stim_proc: process
   begin		
		-- Inicializa o processador colocando o endereco inicial da memoria no PC
		-- Aguarda um pulso de clock e desativa a inicializacao
		Inicializar <= '1';
		wait for Clk_period;
		Inicializar <= '0';
		
		-- Espera por 50 pulsos de clock - numero de pulsos necessario à execucao do
		-- programa que gera as 10 primeiras posicoes da sequencia de fibonacci
		wait for Clk_period*50;
		
		-- Exibe as 11 primeiras posicoes da memoria de dados (termina lendo uma posicao com undefined)
		for i in 0 to 10 loop
			DebugEndereco <= std_logic_vector(to_unsigned(i*4,32));
			wait for Clk_period;
		end loop;
      
      -- Para o processo de clock
      Stop <= '1';
      wait;
   end process;

END;
