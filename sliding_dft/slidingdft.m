 clc;
 x= [1 , -4 , 3, 8 ,2 , 7 , 3 , 5 , 1 , 8];
 x_l = length(x);
 N = 5;

a= x(1,1:N);
a_fft = fft(a);
b_fft = zeros(1,N);

  for i=1 : x_l-N
       b = x(1,i+1:i+N);
             for j =0:N-1
                 b_fft(j+1) = (a_fft(j+1)+b(N)-a(1))*exp(2i*pi*j/N);
            end
         %this_is_to_test_if_the_same = fft(b)
        b_fft;
        a_fft = b_fft;
        a = b;
  end