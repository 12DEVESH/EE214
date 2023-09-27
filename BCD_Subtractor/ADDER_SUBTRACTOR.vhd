library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

--**********************************************************************************************************************

package FULLADD is
component Full_adder is
 port (A, B, C: in std_logic; Sum, Carry: out std_logic);
 end component Full_adder;
end package FULLADD;

library ieee;
use ieee.std_logic_1164.all; 
library work;
use work.Gates.all; 


entity Full_adder  is
  port (A, B, C: in std_logic; Sum, Carry: out std_logic);
end entity Full_adder;

architecture Struct of Full_adder is
  signal AXB, AB, O1 : std_logic;
begin
  -- component instances
  XOR1: XOR_2 port map (A => A, B => B, Y => AXB);
  AND1: AND_2 port map (A => A, B => B, Y => AB);
  XOR2: XOR_2 port map (A => AXB, B => C, Y => Sum);
  AND2: AND_2 port map (A => AXB, B => C, Y => O1);
  OR2: OR_2 port map (A => O1, B => AB, Y => Carry);

end Struct;
--**************************************************************************************************************************

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all; 
use work .FULLADD.all;

entity ADDER_SUBTRACTOR  is
  port (A3, A2,A1,A0, B3,B2,B1,B0,M: in std_logic; S3,S2,S1,S0,Cout: out std_logic);
end entity ADDER_SUBTRACTOR;

architecture Struct of ADDER_SUBTRACTOR is
  signal C1 ,C2,C3 , X0,X1,X2,X3 : std_logic;
begin
  -- component instances
  XOR1: XOR_2 port map (A=>M , B=>B0  , Y=>X0  );
  XOR2: XOR_2 port map (A=>M , B=>B1  , Y=>X1  );
  XOR3: XOR_2 port map (A=>M , B=>B2  , Y=>X2  );
  XOR4: XOR_2 port map (A=>M , B=>B3  , Y=>X3  );
  Full_adder1: Full_adder port map (A =>A0 , B =>X0 ,C => M , Sum => S0  ,Carry => C1 );
  Full_adder2: Full_adder port map (A =>A1 , B =>X1 ,C => C1, Sum => S1  ,Carry => C2 );
  Full_adder3: Full_adder port map (A =>A2 , B =>X2 ,C => C2, Sum => S2 ,Carry =>  C3);
  Full_adder4: Full_adder port map (A =>A3 , B =>X3 ,C => C3, Sum => S3 ,Carry =>  Cout);
     
end Struct;