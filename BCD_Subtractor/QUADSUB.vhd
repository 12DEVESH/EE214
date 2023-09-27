library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

--**********************************************************************************************************************

package FULLADD is
component Full_adder_1 is
 port (A, B, C: in std_logic; Sum, Carry: out std_logic);
 end component Full_adder_1;
end package FULLADD;

library ieee;
use ieee.std_logic_1164.all; 
library work;
use work.Gates.all; 


entity Full_adder_1  is
  port (A, B, C: in std_logic; Sum, Carry: out std_logic);
end entity Full_adder_1;

architecture XYZ of Full_adder_1 is
  signal AXB, AB, O1 : std_logic;
begin
  -- component instances
  XOR1: XOR_2 port map (A => A, B => B, Y => AXB);
  AND1: AND_2 port map (A => A, B => B, Y => AB);
  XOR2: XOR_2 port map (A => AXB, B => C, Y => Sum);
  AND2: AND_2 port map (A => AXB, B => C, Y => O1);
  OR2: OR_2 port map (A => O1, B => AB, Y => Carry);

end XYZ;
--**************************************************************************************************************************

library ieee;
use ieee.std_logic_1164.all; 
library work;
use work.Gates.all; 

package ADD_SUB is
component ADDER_SUBTRACTOR is
 port (A3, A2,A1,A0, B3,B2,B1,B0,M: in std_logic; Cout,S3,S2,S1,S0: out std_logic);
end component ADDER_SUBTRACTOR;

end package ADD_SUB;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all; 
use work .FULLADD.all;

entity ADDER_SUBTRACTOR  is
  port (A3, A2,A1,A0, B3,B2,B1,B0,M: in std_logic; Cout,S3,S2,S1,S0: out std_logic);
end entity ADDER_SUBTRACTOR;

architecture MNP of ADDER_SUBTRACTOR is
  signal C1 ,C2,C3 , X0,X1,X2,X3 : std_logic;
begin
  -- component instances
  XOR1: XOR_2 port map (A=>M , B=>B0  , Y=>X0  );
  XOR2: XOR_2 port map (A=>M , B=>B1  , Y=>X1  );
  XOR3: XOR_2 port map (A=>M , B=>B2  , Y=>X2  );
  XOR4: XOR_2 port map (A=>M , B=>B3  , Y=>X3  );
  Full_adder1: Full_adder_1 port map (A =>A0 , B =>X0 ,C => M , Sum => S0  ,Carry => C1 );
  Full_adder2: Full_adder_1 port map (A =>A1 , B =>X1 ,C => C1, Sum => S1  ,Carry => C2 );
  Full_adder3: Full_adder_1 port map (A =>A2 , B =>X2 ,C => C2, Sum => S2 ,Carry =>  C3);
  Full_adder4: Full_adder_1 port map (A =>A3 , B =>X3 ,C => C3, Sum => S3 ,Carry =>  Cout);
     
end MNP;
--*****************************************************************************************************************************

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all; 
use work .FULLADD.all;
use work.ADD_SUB.all;

entity QUADSUB  is
  port (A3, A2,A1,A0, B3,B2,B1,B0: in std_logic; Y4, Y3, Y2, Y1, Y0: out std_logic);
end entity QUADSUB;


architecture FFFF of QUADSUB is
  signal o0,o1,o2,o3,andd1 , andd2 , s3b, s2b ,s1b,s0b, C , Cb,compbar, s3,s2,s1,s0, dummy1,dummy2,comp,orff1: std_logic;
begin
  -- component instances
  SUB1: ADDER_SUBTRACTOR port map ('1','0','1','0', B3,B2,B1,B0,'1',dummy1,o3,o2,o1,o0);
  ADD1: ADDER_SUBTRACTOR port map (o3,o2,o1,o0,A3,A2,A1,A0,'0',cb,s3b,s2b,s1b,s0b);
  ANDF1: AND_2 port map (s3b,s2b,andd1);
  ANDF2: AND_2 port map (s3b,s1b,andd2);
  ORF1: OR_2 port map (andd1,andd2,orff1);
  ORF2: OR_2 port map (orff1,cb,comp);
  ADD2: ADDER_SUBTRACTOR port map ('0',comp,comp,'0',s3b,s2b,s1b,s0b,'0', c,s3,s2,s1,s0);
  INV: INVERTER port map(comp,compbar);
  AS: ADDER_SUBTRACTOR port map ( compbar,'0',compbar, '0',s3,s2,s1,s0, compbar, dummy2,Y3,Y2,Y1,Y0);
  ANDZ: AND_2 port map (compbar,compbar,Y4);
        
end FFFF;


