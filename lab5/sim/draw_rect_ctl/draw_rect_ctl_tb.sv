`timescale 1 ns / 1 ps

module draw_rect_ctl_tb;

    //Parametry symulacji
    parameter CLK_PERIOD = 25; //okres zegara w ps

    //Sygnły wejsciowe
    logic clk = 0;
    logic rst = 1;
    logic mouse_left = 0;
    logic [11:0] mouse_xpos = 0;
    logic [11:0] mouse_ypos = 0;

    //Sygnły wyściowe

    logic [11:0] xpos;
    logic [11:0] ypos;

    //Instacja modłu
    draw_rct_ctl dut(
        .clk(clk),
        .rst(rst),
        .mouse_left(mouse_left),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .xpos(xpos),
        .ypos(ypos)
    );

    //Generowanie zegara
    always #(CLK_PERIOD/2)clk =~clk;

    //Symlujacja
    initial begin
        //właczamy reset
        rst=1;
        #20;

        //REsetujemy pozycje myszy
        mouse_xpos=0;
        mouse_ypos=0;
        #50;
        //wyłaczamy reset
        rst=0;
        #20;
       
        //Pozycja myszy gora ekranu, przycisk wycisnęty
        mouse_ypos = 0;
        mouse_left = 0;
        #50;
        //Wcśnęcie przycisku myszy
        mouse_left = 1;
        #50;

        //Wycśnęcie
        mouse_left = 0;
        #50;

        //Obserwacja zmian
        #500;

        //Koniec symulacji
        $finish;
    end
endmodule