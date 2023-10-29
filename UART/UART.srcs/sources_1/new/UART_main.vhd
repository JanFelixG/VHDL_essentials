library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Connects UART_TX and UART_RX modules
--implements UART communication via designated pin
--(on CMOD A7 use jtag pin)
entity UART_main is
generic(
clks_per_bit: integer := 115 --adjust to required clock speed, 115 for UART 9600
);
Port( 
i_clk: in STD_LOGIC;
i_UART_data: in std_logic; --UART-data-line
o_UART_data: out std_logic --UART-data-line
);
end UART_main;

architecture Behavioral of UART_main is

--define components here
component Uart_RX is --UART receiver
generic(
clks_per_bit: integer := 115 --adjust to required clock speed, 115 for UART 9600
);
port(
i_clk: in  std_logic;
i_RX_serial: in  std_logic; --serialized input data
o_RX_DV: out std_logic; 
o_RX_byte: out std_logic_vector(7 downto 0) --output-byte
);
end component;

component UART_TX is --UART transmitter
generic (
clks_per_bit : integer := 115 --adjust to required clock speed, 115 for UART 9600
);
port (
i_Clk: in  std_logic;
i_TX_DV: in  std_logic;
i_TX_byte: in  std_logic_vector(7 downto 0);
o_TX_active: out std_logic;
o_TX_serial: out std_logic;
o_TX_Done: out std_logic
);
end component;
--define types here

--define signals here
--RX signals here
--signal s_data_bit : std_logic; --data bit read in from UART-data-line
signal s_RX_DV : std_logic; --stop signal detected if 1
signal s_data_byte : std_logic_vector(7 downto 0); --reconstructed data byte from 
--TX signals here
signal s_TX_active : std_Logic; --1 if transmitter is sending
signal s_TX_serial : std_logic; --output data from transmitter going to UART-data-line
--signal s_TX_done : std_logic; --Transmitter send data

begin
--instantiate components here
inst_UART_RX: UART_RX
generic map(
clks_per_bit => clks_per_bit
)
port map(
i_clk => i_clk,
i_RX_serial => i_UART_data,
o_RX_DV => s_RX_DV,
o_RX_byte => s_data_byte
);

inst_UART_TX: UART_TX
generic map(
clks_per_bit => clks_per_bit
)
port map(
i_Clk => i_clk,
i_TX_DV => s_RX_DV,
i_TX_byte => s_data_byte,
o_TX_active => s_TX_active,
o_TX_serial => s_TX_serial,
o_TX_Done => open --not needed here
);

--assign outputs
--assign s_TX_Serial to Output-data when active, else drive line high as per UART-protocol
o_UART_data <= s_TX_Serial when s_TX_Active = '1' else '1';

end Behavioral;
