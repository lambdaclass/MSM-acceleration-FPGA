library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.funciones.ALL;
use work.config.ALL;
use work.tipos.ALL;

entity FSM_w_counter is
        generic(K : natural := 5);
        port(
        clk, rst        : in std_logic;
        in_count        : in std_logic; -- Dejo la senial prendida hasta que termine

        out_count       : out std_logic_vector(ceil2power(K) - 1 downto 0);
        out_top_v       : out std_logic
        );
end FSM_w_counter;

architecture Structural of FSM_w_counter is
        signal counter : unsigned(ceil2power(K) - 1 downto 0);
        

begin
        process(clk, rst, counter)
        begin
                if(rst = '1') then
                        counter <= (others => '0');
                elsif(clk'event and clk = '1' ) then 

                        if (in_count = '1') then
                                if (counter = K - 1) then
                                        counter <= (others => '0');
                                        out_top_v <= '1';
                                else
                                        counter <= counter + 1;
                                        out_top_v <= '0';
                                end if;
                        else
                                counter <= counter;
                                out_top_v <= '0';
                        end if;

                end if;
        end process;

        out_count <= std_logic_vector(counter);

end Structural;
