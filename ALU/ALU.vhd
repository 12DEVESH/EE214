library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_beh is
  generic(
  operand_width : integer:=4);
port (
A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0);
op: out std_logic_vector(5 downto 0));
end alu_beh;

architecture a1 of alu_beh is

function add (A: in std_logic_vector (3 downto 0);
B: in std_logic_vector (3 downto 0))
return std_logic_vector is
variable sum: std_logic_vector (3 downto 0);
variable carry: std_logic_vector (3 downto 0);
begin
yay: for i in 0 to (operand_width-1) loop
if i = 0 then
sum (i) := A(i) xor B (i) xor '0';
carry (i) := A(i) and B (i);
else
sum (i) := A(i) xor B(i) xor carry (i-1);
carry (i) := (A(i) and B (i)) or (carry (i-1) and (A (i) or B(i)));
end if;
end loop yay;
return carry(3) & sum;
end add;




function BITWISEAND(A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0))
return std_logic_vector is
variable BAND : std_logic_vector(5 downto 0):= (others=>'0');

begin
wine: for i in 0 to (operand_width - 1) loop

BAND(i) := A(i) and B(i);



end loop wine;
BAND(4):= '0';
BAND(5):= '0';
return BAND;
end BITWISEAND;



function max(A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0))
return std_logic_vector is
variable maxf : std_logic_vector(operand_width*2-3 downto 0) ;
begin
if A(3) > B(3) then
maxf := "00" & A; 
elsif A(3) < B(3) then
maxf := "00" & B;
elsif A(2) > B(2) then
maxf := "00" & A;
elsif A(2) < B(2) then
maxf := "00" & B;
elsif A(1) > B(1) then
maxf := "00" & A;
elsif A(1) < B(1) then
maxf := "00" & B;
elsif A(0) > B(0) then
maxf := "00" & A;
elsif A(0) < B(0) then
maxf := "00" & B;
else
maxf := "000000";
end if;
return maxf;
end max;

function mul3(A: in std_logic_vector(3 downto 0))
return std_logic_vector is
variable s: std_logic_vector (5 downto 0):= (others=>'0');
variable y: std_logic_vector (3 downto 0);
variable z: std_logic_vector (4 downto 0);
begin
y:= ('0',A(3),A(2),A(1));
z:= add(A,y);
s:=  z & A(0);
return s;


return s;
end mul3;



function eq(A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0))
return std_logic_vector is
variable s: std_logic_vector (5 downto 0):= (others=>'0');
begin
if A = B then
s := "00"&A; 
else
s := "000000";
end if;
return s;
end eq;

begin


alu : process( A, B)

begin
-- complete VHDL code for various outputs of ALU based on select lines
-- Hint: use if/else statement
--
-- sub function usage :
-- signal_name <= sub(A,B)
-- variable_name := sub(A,B)
--
-- concatenate operator usage:
-- "0000"&A

if (A(3) ='0' and B(3) ='0') then
	op <= max(A,B);
elsif (A(3) ='0' and B(3) ='1') then
	op <= BITWISEAND(A,B);
elsif (A(3) ='1' and B(3) ='0') then
	op <= mul3(A);
else
	op <= eq(A,B);
end if;
end process ;
end a1 ;