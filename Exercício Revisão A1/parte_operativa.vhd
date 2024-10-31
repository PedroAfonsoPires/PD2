library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity parte_operativa is
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
end entity;

architecture behavior of parte_operativa is 
signal FF_A : std_logic_vector(7 downto 0);
signal FF_B : std_logic_vector(7 downto 0);
signal FF_C : std_logic;
signal FF_D : std_logic_vector(7 downto 0);
signal FF_E : std_logic_vector(7 downto 0);
signal FF_F : std_logic;
signal FF_G : std_logic_vector(7 downto 0); -- A SAIDA PODE CONTAR COMO ESSE ULTIMO FLIPFLOP

begin 
process(clock,reset)
begin

if (reset = '1') then
	FF_A <= (others => '0');
	FF_B <= (others => '0');
	FF_C <= '0';
	FF_D <= (others => '0');
	FF_E <= (others => '0');
	FF_F <= '0';
	FF_G <= (others => '0');
elsif (clock = '1' and clock'event) then 
	if (en_0 = '1') then
		FF_A <= input0; 
	else
		FF_A <= FF_A;
	end if;
	
	if (en_1 = '1') then
		FF_B <= input1;
	else
		FF_B <= FF_B;
	end if;
	
	FF_D <= FF_A + FF_B;
	FF_E <= FF_A - FF_B;
	
	FF_C <= op_0;
	FF_F <= FF_C;
	
	if (FF_F = '0') then 
	 FF_G <= FF_D;
	else
	 FF_G <= FF_E;
	end if;
end if;
end process;
	output0 <= FF_G;
end behavior;	
