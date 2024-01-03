function image = reconstruct(image_4d,block_size)

    [temp,temp2,columns,rows] = size(image_4d);
    
    image = zeros(rows*block_size,columns*block_size);
    
    for row=1:rows
        
        for column=1:columns
            
            image(row+(row-1)*block_size-(row-1):...
                row+(row-1)*block_size-(row-1)+block_size-1,...
                column+(column-1)*block_size-(column-1):...
                column+(column-1)*block_size-(column-1)+block_size-1) = ...
                image_4d(:,:,column,row);
        end
    end
end