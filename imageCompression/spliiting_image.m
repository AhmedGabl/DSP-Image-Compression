function blocked_image = spliiting_image(image,block_size)

    [rows, columns] = size(image);
    
    % claculate the row and the columns if each block is 8x8
    number_of_blocks_horzintally = ceil(columns/block_size); %220/8=27.5=28
    number_of_blocks_vertically = ceil(rows/block_size);
    
    %%%%%%%%%%%%%%%%%%%%%%%
    %%% splitting image %%%
    %%%%%%%%%%%%%%%%%%%%%%%
    blocked_image = zeros(block_size,block_size,...
        number_of_blocks_horzintally,number_of_blocks_vertically);
    
    for row=1:number_of_blocks_horzintally
        
        for column=1:number_of_blocks_vertically
            
            blocked_image(:,:,column,row) = ...
                image(row+(row-1)*block_size-(row-1):...
                row+(row-1)*block_size-(row-1)+block_size-1,...
                column+(column-1)*block_size-(column-1):...
                column+(column-1)*block_size-(column-1)+block_size-1);
        end 
    end
end