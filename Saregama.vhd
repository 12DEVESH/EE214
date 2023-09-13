library ieee;
use ieee.std_logic_1164.all;

entity tone_gen is
port(clk_50: in std_logic; 
	  switch : in std_logic_vector(7 downto 0);
     output: out std_logic;
	  LED : out std_logic_vector(7 downto 0));
end tone_gen;

architecture generator of tone_gen is
signal countsa,countre,countga,countma,countpa,countdha,countni,countsa2: integer := 1;
signal tone: std_logic_vector(7 downto 0):="00000000";

begin 	
gen_process: process(clk_50)
begin

if (clk_50= '1' and clk_50' event) then

if(switch="10000000") then
	if (countsa = 104168) then
	countsa <= 1;
	tone(0) <= not tone(0);
	else
	countsa <= countsa +1;
	end if;
	LED <= (0 => '1', others => '0');
	output <= tone(0);


elsif(switch="11000000") then
	if (countre= 92593) then
	countre <= 1;
	tone(1) <= not tone(1);
	else
	countre <= countre +1;
	end if;
	LED <= (1 => '1', others => '0');
	output <= tone(1);

	
elsif(switch="11100000") then
	if (countga = 83333) then
	countga <= 1;
	tone(2) <= not tone(2);
	else
	countga <= countga+1;
	end if;
	LED <= (2 => '1', others => '0');
	output <= tone(2);	

	
elsif(switch="11110000") then
	if (countma= 78125) then
	countma <= 1;
	tone(3) <= not tone(3);
	else
	countma <= countma +1;
	end if;
	LED <= (3 => '1', others => '0');
	output <= tone(3);

	
elsif(switch="11111000") then
	if (countpa = 69444) then
	countpa <= 1;
	tone(4) <= not tone(4);
	else
	countpa <= countpa +1;
	end if;
	LED <= (4 => '1', others => '0');
	output <= tone(4);

	
elsif(switch="11111100") then
	if (countdha = 62500) then
	countdha <= 1;
	tone(5) <= not tone(5);
	else
	countdha <= countdha +1;
	end if;
	LED <= (5 => '1', others => '0');
	output <= tone(5);

	
elsif(switch="11111110") then
	if (countni = 55556) then
	countni <= 1;
	tone(6) <= not tone(6);
	else
	countni <= countni +1;
	end if;
	LED <= (6 => '1', others => '0');
	output <= tone(6);

	
elsif(switch="11111111") then
	if (countsa2 = 52083) then
	countsa2 <= 1;
	tone(7) <= not tone(7);
	else
	countsa2 <= countsa2 +1;
	end if;
	LED <= (7 => '1', others => '0');
	output <= tone(7);

else 
	LED <= (others =>'0');
	output<= '0';

end if;
end if;

end process gen_process;

end generator;