function DCT_image = DCT_block(splitted_image,block_size)

    if block_size == 8
        load C8.mat C8
    end
    
    % the values are from range 0-255 which is center at 128
    % we want them to be center at 0 so we will subtract 128 from all 
    % elements
    shifted_image = int16(splitted_image) -128;
    
    DCT_image = dct2(shifted_image);
end