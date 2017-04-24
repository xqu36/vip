----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Brian Mull
-- 
-- Create Date: 04/06/2017 01:13:33 AM
-- Design Name: 
-- Module Name: artyHealth - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use  IEEE.STD_LOGIC_1164.ALL;
use  IEEE.STD_LOGIC_ARITH.ALL;
use  IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity artyHealth is
    Port ( clock, reset : in STD_LOGIC;
           IFlag : in STD_LOGIC;
           rled, gled, OFlag, relay : out STD_LOGIC);
end artyHealth;

architecture Behavioral of artyHealth is
    type STATE_TYPE is (InitZero, ZeroOut, OneOut,PowCycl, ReBoot, InitOne,MinWait);
    signal state          : STATE_TYPE;
    signal tstart, clk    : std_logic := '0';
    signal count          : integer := 1;                       
    signal timer, sec, min, hour   : integer:= 0;
    
begin
    process (clock)                             -- takes the 100MHz signal from ARTY and reduces
    begin                                       -- to a 1 hz clock that can be used by the rtc emulator
        if clock'EVENT AND clock = '1' then
            count <= count + 1;
            if count = 50000000 then
                clk <= not clk;
                count <= 1;
            end if;
        end if;
    end process;
        
    process (clk)                               -- takes the 1 Hz clk and emulates a Real time clock (RTC)                                  
    begin
        if clk'EVENT AND clk = '1' then
            if reset = '1' then
                sec <= 0;
                min <= 0;
            else
                sec <= sec + 1;
                if sec = 59 then
                    sec <= 0; 
                    min <= min + 1;
                    if min = 59 then
                        hour <= hour + 1;
                        min <= 0;
                        if hour = 23 then
                            hour <= 0;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    process (clk)                          --   internal timer run off of the 1 Hz clk
    begin
        if clk'EVENT AND clk = '1' then
            if reset = '1' then
                timer <= 0;
            else
                if tstart = '1' then
                    timer <= timer +1;
                elsif tstart = '0' then
                    timer <= 0;
                end if;
                
            end if;
        end if;
    end process;
    
    process (clock)                          -- determines next state
    begin
        if clock'EVENT AND clock = '1' then
            if reset = '1' then
                    state <= InitZero;
            else
                case state is
                    when InitZero =>
                        if min = 0 AND sec = 10 then        -- Once every hour, check to see if the node is responding
                            state <= ZeroOut;
                        elsif min = 1  AND sec = 0 then     -- Once a day at 3:30 am, reboot the system
                            state <= MinWait;
                        else
                            state <= InitZero;
                        end if;
                    
                    when ZeroOut =>
                        if IFlag =  '0' then
                            state <= InitOne;
                        elsif sec = 20 AND IFlag = '1' then
                            state <= PowCycl;
                        else
                            state <= ZeroOut;
                        end if;
                        
                    when InitOne =>
                        if sec = 30 then        -- Once every hour, check to see if the node is responding
                            state <= OneOut;
                        elsif hour = 23 then     -- Once a day at 3:30 am, reboot the system
                            state <= MinWait;
                        else
                            state <= InitOne;
                        end if;
                                    
                    when OneOut =>
                        if IFlag = '1' then
                            state <= InitZero;
                        elsif sec = 40 AND IFlag = '0' then
                            state <= PowCycl;
                        else
                            state <= OneOut;
                        end if;
                    
                    when PowCycl =>
                        if timer = 5 then
                            state <= InitZero;
                        else
                            state <= PowCycl;
                        end if;
                    
                    when ReBoot =>
                        if timer = 5 then
                            state <= InitZero;
                        else
                            state <= ReBoot;
                        end if;
                                    
                    when MinWait =>
                        if min = 1 AND sec = 10 then
                            state <= ReBoot;
                        else
                            state <= MinWait;
                        end if;
                end case;
            end if;
        end if;
    end process;
    
    --Outputs based on current state
    with state select                              
        OFlag <= '0' when InitZero,
                    '0' when ZeroOut,
                    '1' when InitOne,
                    '1' when OneOut,
                    '0' when PowCycl,
                    '0' when MinWait,
                    '0' when Reboot;
                    
    with state select
        relay <= '1' when InitZero,
                    '1' when ZeroOut,
                    '1' when InitOne,
                    '1' when OneOut,
                    '0' when PowCycl,
                    '1' when MinWait,
                    '0' when Reboot;
                    
    with state select
        tstart <= '0' when InitZero,
                    '0' when ZeroOut,
                    '0' when InitOne,
                    '0' when OneOut,
                    '1' when PowCycl,
                    '0' when MinWait,
                    '1' when Reboot;
                    
    with state select
        rled <= '0' when InitZero,
                    '0'when ZeroOut,
                    '0' when InitOne,
                    '0' when OneOut,
                    '1' when PowCycl,
                    '1' when MinWait,
                    '1' when Reboot;
                                    
    with state select
        gled <= '1' when InitZero,
                    '1' when ZeroOut,
                    '1' when InitOne,
                    '1' when OneOut,
                    '0' when PowCycl,
                    '0' when MinWait,
                    '0' when Reboot;
                
end Behavioral;
