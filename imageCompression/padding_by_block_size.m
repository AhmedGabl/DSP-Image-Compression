function padded_image = padding_by_block_size(gray_image,block_size)

    [rows, columns] = size(gray_image);
    
    %%%%%%%%%%%%%%%
    %%% padding %%%
    %%%%%%%%%%%%%%%
    
    % start from first row and skip blocksize pixels till reaching 
    % the end of all row
    for row=1 :block_size:rows
        
        % start from first column and skip blocksize pixels till 
        % reaching the end of all columns
        for column=1 :block_size:columns
            
            % at the end of the loops they will store the right size of the
            % padded image
            row_end = row + block_size -1;
            column_end = column + block_size -1;
            
            % if the right size excceds the actual size, pad the rest with
            % 0s
            if row_end > rows
                gray_image(rows+1:row_end,:) = 0;
            end
            
            if column_end > columns
                gray_image(:,columns+1:column_end) = 0;
            end
            
        end
    end
    
    padded_image = gray_image;
end