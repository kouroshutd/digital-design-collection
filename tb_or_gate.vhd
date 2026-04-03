library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_or_gate is
end tb_or_gate;

architecture behavior of tb_or_gate is

    component or_gate
        port(
            a : in std_logic;
            b : in std_logic;
            q : out std_logic
        );
    end component;

    signal a, b, q : std_logic;

begin

    uut: or_gate port map(a, b, q);

    process
    begin
        a <= '0'; b <= '0'; wait for 10 ns;
        a <= '0'; b <= '1'; wait for 10 ns;
        a <= '1'; b <= '0'; wait for 10 ns;
        a <= '1'; b <= '1'; wait for 10 ns;
        wait;
    end process;

end behavior;