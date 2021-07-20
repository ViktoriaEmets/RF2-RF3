-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "07/20/2021 10:53:45"

-- 
-- Device: Altera EP4CE22F17C6 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	MASTER IS
    PORT (
	clk : IN std_logic;
	start : OUT std_logic;
	stop : OUT std_logic;
	start_N : OUT std_logic;
	avto : OUT std_logic;
	drv_pulse : OUT std_logic;
	drv_dir : OUT std_logic
	);
END MASTER;

-- Design Ports Information
-- clk	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- start	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- stop	=>  Location: PIN_R13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- start_N	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avto	=>  Location: PIN_J16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- drv_pulse	=>  Location: PIN_P8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- drv_dir	=>  Location: PIN_D3,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF MASTER IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_start : std_logic;
SIGNAL ww_stop : std_logic;
SIGNAL ww_start_N : std_logic;
SIGNAL ww_avto : std_logic;
SIGNAL ww_drv_pulse : std_logic;
SIGNAL ww_drv_dir : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \start~output_o\ : std_logic;
SIGNAL \stop~output_o\ : std_logic;
SIGNAL \start_N~output_o\ : std_logic;
SIGNAL \avto~output_o\ : std_logic;
SIGNAL \drv_pulse~output_o\ : std_logic;
SIGNAL \drv_dir~output_o\ : std_logic;

BEGIN

ww_clk <= clk;
start <= ww_start;
stop <= ww_stop;
start_N <= ww_start_N;
avto <= ww_avto;
drv_pulse <= ww_drv_pulse;
drv_dir <= ww_drv_dir;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X1_Y34_N2
\start~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \start~output_o\);

-- Location: IOOBUF_X40_Y0_N23
\stop~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \stop~output_o\);

-- Location: IOOBUF_X0_Y25_N9
\start_N~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \start_N~output_o\);

-- Location: IOOBUF_X53_Y14_N9
\avto~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \avto~output_o\);

-- Location: IOOBUF_X25_Y0_N16
\drv_pulse~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \drv_pulse~output_o\);

-- Location: IOOBUF_X1_Y34_N9
\drv_dir~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \drv_dir~output_o\);

-- Location: IOIBUF_X51_Y34_N22
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

ww_start <= \start~output_o\;

ww_stop <= \stop~output_o\;

ww_start_N <= \start_N~output_o\;

ww_avto <= \avto~output_o\;

ww_drv_pulse <= \drv_pulse~output_o\;

ww_drv_dir <= \drv_dir~output_o\;
END structure;


