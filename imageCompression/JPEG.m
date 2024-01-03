% read the image
original_image = imread('Lenna.png');

% get number of rows, columns of the image
% in addition too number of channels to if it's color or gray
[rows, columns, number_of_color_channels] = size(original_image);
pixels = rows*columns;

% check if the image is color or gray
% if it's color convert it to gray
% if it's gray we are ready
if number_of_color_channels == 3
    gray_image = rgb2gray(original_image);
else
    gray_image = original_image;
end

r = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

block_size = 8;

%%%%%%%%%%%%%%%
%%% padding %%%
%%%%%%%%%%%%%%%
padded_image = padding_by_block_size(gray_image,block_size);

%%%%%%%%%%%%%%%%%%%%%%%
%%% splitting image %%%
%%%%%%%%%%%%%%%%%%%%%%%
splitted_image = spliiting_image(padded_image,block_size);

% claculate the row and the columns if each block is 8x8
number_of_blocks_horzintally = ceil(columns/block_size); %220/8=27.5=28
number_of_blocks_vertically = ceil(rows/block_size);

% temporery spltted image to store the DCT of the image
DCT_image = zeros(block_size,block_size,number_of_blocks_vertically,number_of_blocks_horzintally);

% temporery spltted image to store the quantization of the image after
% takin its DCT
quantized_image = zeros(block_size,block_size,number_of_blocks_vertically,number_of_blocks_horzintally);

for row=1:number_of_blocks_horzintally
    for column=1:number_of_blocks_vertically
    
        %%%%%%%%%%%%%%%%%
        %%% DCT Block %%%
        %%%%%%%%%%%%%%%%%

        DCT_image(:,:,column,row) = DCT_block(splitted_image(:,:,column,row),block_size);

        %%%%%%%%%%%%%%%%%%%%
        %%% quantization %%%
        %%%%%%%%%%%%%%%%%%%%

        quantized_image(:,:,column,row) = quantization(DCT_image(:,:,column,row),r);
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% decoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% temporery spltted image to store the dequantization of the image
dequantized_image = zeros(block_size,block_size,number_of_blocks_vertically,number_of_blocks_horzintally);

% temporery spltted image to store the IDCT of the image after getting 
% its dequantization
inv_DCT_image = zeros(block_size,block_size,number_of_blocks_vertically,number_of_blocks_horzintally);

for row=1:number_of_blocks_horzintally
    for column=1:number_of_blocks_vertically

        %%%%%%%%%%%%%%%%%%%%%%
        %%% dequantization %%%
        %%%%%%%%%%%%%%%%%%%%%%
        
        dequantized_image(:,:,column,row) = dequantization(quantized_image(:,:,column,row),r);

        %%%%%%%%%%%%%%%%%%%%%%%%%
        %%% inverse DCT Block %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%
        
        inv_DCT_image(:,:,column,row) = inv_DCT_block(dequantized_image(:,:,column,row),block_size);
        
    end
end

decoded_image = uint8(reconstruct(uint8(inv_DCT_image),block_size));
subplot(1,2,1)
imshow(gray_image)
title('Original Image')
subplot(1,2,2)
imshow(decoded_image)
title('Decoded Image')