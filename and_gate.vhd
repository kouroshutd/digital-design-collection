##and_gate.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate is
    port(
        a : in std_logic;
        b : in std_logic;
        q : out std_logic
    );
end and_gate;

architecture behavior of and_gate is
begin
    q <= a and b;
end behavior;

##testbench.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
end testbench;

architecture tb of testbench is

    component and_gate
        port(
            a : in  std_logic;
            b : in  std_logic;
            q : out std_logic
        );
    end component;

    signal a : std_logic := '0';
    signal b : std_logic := '0';
    signal q : std_logic;

begin

    uut: and_gate
        port map(
            a => a,
            b => b,
            q => q
        );

    process
    begin
        a <= '0';
        b <= '0';
        wait for 1 ns;
        assert q = '0'
            report "Fail for input 00"
            severity error;

        a <= '0';
        b <= '1';
        wait for 1 ns;
        assert q = '0'
            report "Fail for input 01"
            severity error;

        a <= '1';
        b <= '0';
        wait for 1 ns;
        assert q = '0'
            report "Fail for input 10"
            severity error;

        a <= '1';
        b <= '1';
        wait for 1 ns;
        assert q = '1'
            report "Fail for input 11"
            severity error;

        report "All tests passed." severity note;
        wait;
    end process;

end tb;