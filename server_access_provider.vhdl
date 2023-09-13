library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port(clk_50: in std_logic; 
	  switch : in std_logic_vector(3 downto 0);
	  LED : out std_logic_vector(4 downto 0));
end FSM;

architecture generator of FSM is
type state is (I,A,P,R,S,WA,WP,WR); -- Fill other states here
signal count: integer := 0;
signal y_present,y_next:state:=I;
signal w: std_logic :='0';
begin 
	
clk_process: process(clk_50,w)
begin
if (clk_50= '1' and clk_50'event) then
if(w='0') then
y_present<=y_next;
end if;
end if;
end process;

gen_process: process(clk_50,switch,y_present,w)
begin

case y_present is

when I =>
	if (switch(3)='1') then
		y_next<=A;
		LED <= "01111";	
	elsif (switch(2)='1') then
		y_next<=P;
		LED <= "00111";
	elsif (switch(1)='1') then
		y_next<=R;
		LED <= "00011";
	elsif (switch(0)='1') then
		y_next<=S;
		LED <= "00001";	
	else 
		y_next<=I;
   	LED <= "00000";	
	end if;

when A =>

	if (switch(3)='1') then
		y_next<=A;
		LED <= "01111";	
	else 
		y_next<=I;
   	LED <= "00000";	
	end if;

when P =>

	if (switch(3)='1') then
		y_next<=WA;
		w<='1';

	elsif (switch(2)='1') then
		y_next<=P;
   	LED <= "00111";	
	else 
		y_next<=I;
   	LED <= "00000";	
	end if;


when R =>

	if (switch(3)='1') then
		y_next<=WA;
		w<='1';

	

	elsif (switch(2)='1') then
		y_next<=WP;
		w<='1';

	elsif (switch(1)='1') then
		y_next<=R;
   	LED <= "00011";	
	else
		y_next<=I;
   	LED <= "00000";	
	end if;

when s =>

	if (switch(3)='1') then
		y_next<=WA;
		w<='1';
	elsif (switch(2)='1') then
		y_next<=WP;
		w<='1';

	elsif (switch(1)='1') then
		y_next<=WR;
		w<='1';

	elsif(switch(0)='1') then
		y_next<=S;
   	LED <= "00001";	
	else
		y_next<=I; 
   	LED <= "00000";	
	end if;

when WA =>
		if(clk_50= '1' and clk_50' event and w='1') then
		count <= count + 1;
		LED<="11111";
		if(count = 75E6) then
		count <= 0;
		w<='0';
		y_next<=A;
		end if;
		end if;
		
when WP =>
		if(clk_50= '1' and clk_50' event and w='1') then
		count <= count + 1;
		LED<="11111";
		if(count = 75E6) then
		count <= 0;
		w<='0';
		y_next<=P;
		end if;
		end if;

		
when WR =>
		if(clk_50= '1' and clk_50' event and w='1') then
		count <= count + 1;
		LED<="11111";
		if(count = 75E6) then
		count <= 0;
		y_next<=R;
		end if;
		end if;

		
		
end case;	
end process gen_process;
end generator;


