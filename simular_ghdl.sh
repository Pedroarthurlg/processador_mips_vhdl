#!/usr/bin/env bash

set -euo pipefail

GHDL_STD="--std=08"

ghdl -a "$GHDL_STD" tipo.vhd
ghdl -a "$GHDL_STD" 'mux2 (1).vhd' 'mux4 (1).vhd'
ghdl -a "$GHDL_STD" somador.vhd flipflopD.vhd flipflopD_AS.vhd
ghdl -a "$GHDL_STD" decodificador1x2.vhd Decodificador2x4.vhd decodificador5x32.vhd
ghdl -a "$GHDL_STD" mux2_5.vhd mux2_32.vhd mux32.vhd mux32x32.vhd
ghdl -a "$GHDL_STD" Registrador.vhd registradorPC.vhd banco_de_registradores.vhd
ghdl -a "$GHDL_STD" ULA1b.vhd ula32bits.vhd somador32.vhd
ghdl -a "$GHDL_STD" extensor.vhd deslocador.vhd deslocador_32.vhd
ghdl -a "$GHDL_STD" ULA_Controle.vhd UnidadeControle.vhd
ghdl -a "$GHDL_STD" memInstrucoes.vhd memDados.vhd mips.vhd mips_tb.vhd

ghdl -e "$GHDL_STD" mips_tb
ghdl -r "$GHDL_STD" mips_tb --stop-time=620ns
