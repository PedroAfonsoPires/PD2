library ieee;                   
use ieee.std_logic_1164.all;    
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity processador is 
	port(
		clock : in std_logic;
		reset : in std_logic;
		R0    : out std_logic_vector(3 downto 0);
		R1    : out std_logic_vector(3 downto 0)
		);
end entity;

architecture behavior of processador is 

signal PC         : std_logic_vector(3 downto 0);
type mem is array (integer range 0 to 15) of std_logic_vector(7 downto 0);
signal mem_0      : mem;
signal desvio     : std_logic;
signal op_code    : std_logic_vector(2 downto 0);
signal ula        : std_logic_vector(3 downto 0);
signal equal      : std_logic;
signal mult       : std_logic_vector(7 downto 0);
signal soma       : std_logic_vector(3 downto 0);
signal subt       : std_logic_vector(3 downto 0);
signal mem_out    : std_logic_vector(7 downto 0);
signal enable_reg : std_logic;
begin
		mem_0(0) <= "00000010";
		mem_0(1) <= "00010011";
		mem_0(2) <= "10100110";
		mem_0(3) <= "00010001";
		mem_0(4) <= "01000000";
		mem_0(5) <= "11001000";
		mem_0(6) <= "00010001";
		mem_0(7) <= "00100000";
		mem_0(8) <= "00000000";
		mem_0(9) <= "00000000";
		mem_0(10)<= "00000000";
		mem_0(11)<= "00000000";
		mem_0(12)<= "00000000";
		mem_0(13)<= "00000000";
		mem_0(14)<= "00000000";
		mem_0(15)<= "00000000";

mem_out    <= mem_0(conv_integer(PC));
op_code    <= mem_out(7 downto 5);
enable_reg <= '1' when (op_code = "000") or (op_code = "001") or (op_code = "010") or (op_code = "110") else
			'0';
desvio     <= '1' when (op_code = "100" and equal = '1') or (op_code = "101" and equal = '0') or (op_code = "110") else
			'0';
equal      <= '1' when R0 = R1 else
			'0';
soma       <= R0 + R1;
subt       <= R0 - R1;
mult       <= R0 * R1;
ula        <= mem_out(3 downto 0) when op_code(1 downto 0) = "00" else
		soma when op_code(1 downto 0) = "01" else
		subt when op_code(1 downto 0) = "10" else
		mult(3 downto 0);

process(reset, clock)
begin
	if (reset = '0') then
		R0 <= (others => '0');
		R1 <= (others => '0');
		PC <= (others => '0');
	elsif (clock = '1' and clock'event) then
		if (desvio = '0') then
			PC <= PC + 1;
		else
			PC <= mem_out(3 downto 0);
		end if;
		if (enable_reg = '1') then
			if (mem_out(4) = '0') then		
				R0 <= ula;
			else
				R1 <= ula;
			end if;
		end if;
	end if;
end process;

end behavior;