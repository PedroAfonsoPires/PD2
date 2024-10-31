library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity tb_parte_operativa is 
end entity;

architecture behavior of tb_parte_operativa is
component parte_operativa is
	port(
		entrada1 : in std_logic_vector(3 downto 0);
		entrada2 : in std_logic_vector(3 downto 0);
		clock    : in std_logic;
		reset    : in std_logic;
		M        : in std_logic;
		S        : in std_logic;
		En_AB    : in std_logic;
		En_C     : in std_logic;
		output1  : out std_logic_vector(3 downto 0)
		
		);
end component;

signal entrada1_sg : std_logic_vector(3 downto 0):= "0011";
signal entrada2_sg : std_logic_vector(3 downto 0):= "0010";
signal clock_sg    : std_logic:= '0';
signal reset_sg    : std_logic:= '0';
signal M_sg        : std_logic:= '0';
signal S_sg        : std_logic:= '1';
signal En_AB_sg    : std_logic:= '1';
signal En_C_sg     : std_logic:= '1';
signal output1_sg  : std_logic_vector(3 downto 0);

begin

inst_parte_operativa : parte_operativa
	port map(
		entrada1 => entrada1_sg,
		entrada2 => entrada2_sg,
		clock    => clock_sg,
		reset    => reset_sg,
		M        => M_sg,
		S        => S_sg,
		En_AB    => En_AB_sg,
		En_C     => En_C_sg,
		output1  => output1_sg
		);
clock_sg <= not clock_sg after 5 ns;
process
begin
	wait for 2 ns;
		reset_sg <= '1';
	wait for 17 ns;
		M_sg <= '1';
	wait;
end process;
end behavior;
