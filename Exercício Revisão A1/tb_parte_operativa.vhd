library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity tb_parte_operativa is 
end entity;

architecture behavior of tb_parte_operativa is 
component parte_operativa is 
	port(
		input0  : in std_logic_vector(7 downto 0);
		input1  : in std_logic_vector(7 downto 0);
		clock   : in std_logic;
		reset   : in std_logic;
		en_0    : in std_logic;
		en_1    : in std_logic;
		op_0    : in std_logic;
		output0 : out std_logic_vector(7 downto 0)
		);
end component;
signal input0_sg   : std_logic_vector(7 downto 0):= "00000001";
signal input1_sg   : std_logic_vector(7 downto 0):= "00000010";
signal clock_sg    : std_logic:= '0';                      
signal reset_sg    : std_logic:= '0';                      
signal en_0_sg     : std_logic:= '1';                      
signal en_1_sg     : std_logic:= '1';                      
signal op_0_sg     : std_logic:= '0';                      
signal output0_sg  : std_logic_vector(7 downto 0);

inst_parte_operativa : parte_operativa
	port map(
		input0  => input0_sg,
		input1  => input1_sg,
		clock   => clock_sg,
		reset   => reset_sg,
		en_0    => en_0_sg,
		en_1    => en_1_sg,
		op_0    => op_0_sg,
		output0 => output0_sg
		);
clock_sg <= not clock_sg after 5 ns;
process
begin
	wait for 2 ns;
		reset_sg => '1';
	wait;
end process;
end behavior;      