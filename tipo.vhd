library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package tipo is
    subtype tipo_palavra is std_logic_vector(31 downto 0);
    type tipo_vetor_de_palavras is array(natural range <>) of tipo_palavra;
end package tipo;
