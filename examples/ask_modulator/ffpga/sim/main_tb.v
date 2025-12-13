`timescale 1ns / 1ps

module tb_dds_ask;

    // --- 1. Inputs ---
    reg [5:0] i_freq_word;
    reg       i_data;
    reg       i_clk = 0;

    // --- 2. Outputs ---
    wire      o_pwm_out;
    wire      o_pwm_out_oe;
    wire      o_clk_en;

    // --- 3. Instantiate the Module ---
    // The simulator will find "dds_ask_modulator" automatically
    // in your project. Do NOT use `include here.
    dds_ask_modulator uut (
        .i_freq_word(i_freq_word), 
        .i_data(i_data), 
        .i_clk(i_clk), 
        .o_pwm_out(o_pwm_out),
        .o_pwm_out_oe(o_pwm_out_oe),
        .o_clk_en(o_clk_en)
    );

    // --- 4. Clock Generation (50MHz) ---
    always #10 i_clk = ~i_clk;

    // --- 5. Test Stimulus ---
    initial begin
        // GTKWave Output Setup
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_dds_ask);

        // Initialize
        i_freq_word = 0;
        i_data = 0;
        #100;

        // Test: Turn ON Carrier
        i_freq_word = 6'd10; 
        i_data = 1;
        #20000; 

        // Test: Silence
        i_data = 0;
        #5000;

        // Test: High Frequency
        i_freq_word = 6'd40;
        i_data = 1;
        #20000;

        $finish;
    end

endmodule