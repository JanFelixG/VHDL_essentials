library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--module coonnects UART transmitter and receiver
--for ease of use
entity Uart is
generic(
clks_per_bit: integer := 115 --adjust to required clock speed, 115 for UART 9600
);
port(
i_clk: in  std_logic;
i_RX_serial: in  std_logic; --serialized input data
o_RX_DV: out std_logic; 
o_RX_byte: out std_logic_vector(7 downto 0) --output-byte
);
end Uart;

architecture Behavioral of Uart is

--define components here
component Uart_RX is
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

component UART_TX is
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

--defines internal signals here

begin
--Instantiate UART transmitter 

--Instantiate UART receiver






end Behavioral;
