library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--module takes in serialized data on bus
--and transform it into bytes
--uses UART protocol
entity Uart_RX is
generic(
clks_per_bit: integer := 115 --adjust to required clock speed, 115 for UART 9600
);
port(
i_clk: in  std_logic;
i_RX_serial: in  std_logic; --serialized input data
o_RX_DV: out std_logic; 
o_RX_byte: out std_logic_vector(7 downto 0) --output-byte

);
end Uart_RX;

architecture Behavioral of Uart_RX is
--define types here
type t_SM_UART_RX is (idle, RX_Start_Bit, RX_Data_Bits, RX_Stop_Bit, Cleanup);
--defines signals here
signal s_SM_UART_RX: t_SM_UART_RX := idle;

signal s_RX_Data_R, s_RX_Data : std_logic := '0';
signal s_clk_count : integer range 0 to CLKS_PER_BIT-1 := 0;
signal s_bit_index : integer range 0 to 7 := 0;  -- 8 Bits Total
signal s_RX_byte   : std_logic_vector(7 downto 0) := (others => '0');
signal s_RX_DV     : std_logic := '0';

begin
--sample process
sample: process(i_clk)
begin
if rising_edge(i_Clk) then
    s_RX_Data_R <= i_RX_serial;
    s_RX_Data   <= s_RX_Data_R; 
end if; 
end process SAMPLE;

--state machine process
 p_UART_RX : process (i_Clk)
begin
if(rising_edge(i_clk)) then
case s_SM_UART_RX is
when Idle =>
    s_RX_DV <= '0';
    s_Clk_Count <= 0;
    s_Bit_Index <= 0;
    if(s_RX_Data = '0') then -- Start bit detected
        s_SM_UART_RX <= RX_Start_Bit; --switch state
    else
        s_SM_UART_RX <= idle;
    end if;
    -- Check middle of start bit to make sure it's still low
when RX_Start_Bit =>
    if s_clk_count = (CLKS_PER_BIT-1)/2 then
        if s_RX_Data = '0' then
        s_clk_count <= 0;  -- reset counter since we found the middle
        s_SM_UART_RX   <= RX_Data_Bits;
        else
            s_SM_UART_RX   <= idle;
        end if;
    else
        s_clk_count <= s_clk_count + 1;
        s_SM_UART_RX   <= RX_Start_Bit; --switch state
    end if;
-- Wait g_CLKS_PER_BIT-1 clock cycles to sample serial data
when RX_Data_Bits =>
if s_clk_count < CLKS_PER_BIT-1 then
    s_clk_count <= s_clk_count + 1;
    s_SM_UART_RX   <= RX_Data_Bits; --switch state
else
    s_clk_count  <= 0;
    s_RX_Byte(s_Bit_Index) <= s_RX_Data;
    -- Check if we have sent out all bits
    if s_Bit_Index < 7 then
        s_Bit_Index <= s_Bit_Index + 1;
        s_SM_UART_RX   <= RX_Data_Bits; --remain in state
    else
        s_Bit_Index <= 0;
        s_SM_UART_RX   <= RX_Stop_Bit; --switch state
    end if;
end if;
-- Receive Stop bit. Stop bit = 1
when RX_Stop_Bit =>
-- Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
if s_clk_count < CLKS_PER_BIT-1 then
    s_clk_count <= s_clk_count + 1;
    s_SM_UART_RX   <= RX_Stop_Bit; --remain in state
else
    s_RX_DV <= '1';
    s_clk_count <= 0;
    s_SM_UART_RX   <= Cleanup; --switch state
end if;
--Stay here 1 clock
when Cleanup =>
    s_SM_UART_RX <= idle; --switch state
    s_RX_DV   <= '0'; 
when others =>
    s_SM_UART_RX <= idle; --switch state
end case; --state_machine
end if; --clock if
end process p_UART_RX;

--assign outputs here
o_RX_DV   <= s_RX_DV;
o_RX_byte <= s_RX_byte;

end Behavioral;
