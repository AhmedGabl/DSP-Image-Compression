function inv_DCT_image = inv_DCT_block(splitted_image,block_size)
    if block_size == 8
        load C8.mat C8
    end

    %inv_DCT_image = (transpose(C8)*splitted_image)*C8 +128;
    
    % we re-add 128 to return to the normal range of image which is from
    % 0-255
	inv_DCT_image = idct2(splitted_image) + 128;
    
end