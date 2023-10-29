library_ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--module takes byte from storage and
--puts it on data bus in serialized form
--uses UART protocol
entity UART_TX is
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
end UART_TX;
  
architecture Behavioral of UART_TX is
--define types here
type t_SM_UART_TX is (idle, TX_Start_Bit, TX_Data_Bits, TX_Stop_Bit,Cleanup);
--defines signals here
signal s_SM_UART_TX : t_SM_UART_TX := idle;

signal s_clk_count: integer range 0 to clks_per_bit-1  := 0;
signal s_bit_index: integer range 0 to 7 := 0;  -- 8 Bits Total
signal s_TX_Data: std_logic_vector(7 downto 0) := (others => '0');
signal s_TX_Done: std_logic := '0';
   
begin
--state machine process
p_UART_TX : process (i_clk)
begin
if(rising_edge(i_clk)) then
case s_SM_UART_TX is
when idle =>
    o_TX_Active <= '0';
    o_TX_Serial <= '1'; -- Drive Line High for Idle
    s_TX_Done   <= '0';
    s_clk_count <= 0;
    s_Bit_Index <= 0;
    if i_TX_DV = '1' then
        s_TX_Data <= i_TX_Byte; --store data byte to sent
        s_SM_UART_TX <= TX_Start_Bit; --switch state
    else
        s_SM_UART_TX <= idle;
    end if;
-- Send out Start Bit. Start bit = 0
when TX_Start_Bit =>
    o_TX_Active <= '1';
    o_TX_Serial <= '0';
    -- Wait clks_per_bit-1 clock cycles for start bit to finish
    if s_clk_count < clks_per_bit-1 then
        s_clk_count <= s_clk_count + 1;
        s_SM_UART_TX   <= TX_Start_Bit;
    else
        s_clk_count <= 0;
        s_SM_UART_TX   <= TX_Data_Bits; --switch state
    end if;
-- Wait clks_per_bit-1 clock cycles for data bits to finish
when TX_Data_Bits =>
    o_TX_Serial <= s_TX_Data(s_bit_index);
    if s_clk_count < clks_per_bit-1 then
        s_clk_count <= s_clk_count + 1;
        s_SM_UART_TX   <= TX_Data_Bits;
    else
        s_clk_count <= 0;
        -- Check if we have sent out all bits
        if s_bit_index < 7 then
            s_bit_index <= s_bit_index + 1;
            s_SM_UART_TX   <= TX_Data_Bits;
        else
            s_Bit_Index <= 0;
            s_SM_UART_TX   <= TX_Stop_Bit; --switch state
        end if;
    end if;
-- Send out Stop bit. Stop bit = 1 
when TX_Stop_Bit =>
    o_TX_Serial <= '1';
    -- Wait clks_per_bit-1 clock cycles for Stop bit to finish
    if s_clk_count < clks_per_bit-1 then
        s_clk_count <= s_clk_count + 1;
        s_SM_UART_TX   <= TX_Stop_Bit; --switch state
    else
        s_TX_Done   <= '1';
        s_clk_count <= 0;
        s_SM_UART_TX   <= Cleanup; --switch state
    end if;
-- Stay here 1 clock 
when cleanup =>
    o_TX_Active <= '0';
    s_TX_Done   <= '1';
    s_SM_UART_TX   <= idle;
when others =>
    s_SM_UART_TX <= idle;
end case; --end state machine case
end if; --end clock if
end process p_UART_TX;

--Assign outputs 
o_TX_Done <= s_TX_Done;
   
end Behavioral;