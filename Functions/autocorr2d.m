function A=autocorr2d(I)
% Compute the 2D spatial autocorrelation of a matrix or image I using the 
% Wiener - Khintchine Theorem. The output is the normalized correlation
% coefficient -1 < C < 1.
%
% The center pixel of A will have C = 1. Using images with odd dimensions 
% will give results that are easier to interpret.
%
% ref: http://mathworld.wolfram.com/Wiener-KhinchinTheorem.html
I=double(I); %convert to double
I=I-mean(I(:)); %subtract mean
I=I/sqrt(sum(I(:).^2)); %normalize magnitude
fft_I=fft2(I); %compute fft2
A=real(fftshift(ifft2(fft_I.*conj(fft_I)))); %compute autocorrelation