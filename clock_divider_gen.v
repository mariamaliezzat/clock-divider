module clock_divider_gen #(
    parameter [4:0] div_ratio = 'd4
) (

        input          I_ref_clk,   
        input          I_rst_n,
        input          I_clk_en,
        output  reg    I_div_ratio
);
    reg [31:0] counter ;
    reg chang_flag;
    always @(*) 
        begin
            if (!chang_flag) 
                begin
                    I_div_ratio = I_ref_clk ;
                  
                end 
            else 
                begin
                    if (div_ratio[0] == 'b0) 
                        begin
                        //even 
                        if (counter=='d0 && I_ref_clk == 'd1) 
                            begin
                                I_div_ratio = 'd1;
                            end 
                        else if (counter=='d0 && I_ref_clk == 'd0)
                            begin
                                I_div_ratio = 'd0;
                            end
                        else if (counter <=(div_ratio>>1)) 
                            begin
                                I_div_ratio = 'd1;
                            end 
                        else 
                            begin
                                I_div_ratio = 'd0;
                            end
                        end 
                    else 
                        begin
                            if (counter=='d0 && I_ref_clk == 'd1) 
                                begin
                                    I_div_ratio = 'd1;
                                end 
                            else if (counter=='d0 && I_ref_clk == 'd0)
                                begin
                                    I_div_ratio = 'd0;
                                end
                            else if(counter<=(div_ratio>>1))
                                begin
                                    I_div_ratio = 'd1;
                                end
                            else
                                begin
                                    I_div_ratio = 'd0;
                                end
                        end
                end
        end
    always @ ( posedge I_ref_clk , negedge I_rst_n ) 
        begin
            if (!I_rst_n) 
                begin
                    chang_flag    <= 'd0;
                    counter <= 'd0;
                end 
            else 
                begin
                    if (I_clk_en == 'd1 ) 
                        begin
                            if (div_ratio == 'd1) 
                                begin
                                    chang_flag <= 'd0;
                                end 
                            else 
                                begin
                                    chang_flag <= 'd1;
                                end
                            if (counter == div_ratio &&div_ratio[0]==1'b0) 
                                begin
                                    counter <= 'd1;
                                end 
                            else if (counter ==div_ratio&&div_ratio[0]==1'b1) 
                                begin
                                    counter <='d1;
                                end
                            else
                                begin
                                    counter <= counter + 'd1 ;
                                end
                        end 
                    else 
                        begin
                        chang_flag    <= 'd0; 
                        counter <= 'd0;
                        end
                end 
                    
        end            
endmodule