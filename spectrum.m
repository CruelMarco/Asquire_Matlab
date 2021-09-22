[audioIn, fs] = audioread('4012_P_Asthma_F_after_Mil_Y_eee_5.wav');
%finding power spectrum
N = length(audioIn);
xfft = fft(audioIn);
xfft = xfft(1 : N/2+1);
psd = (1/fs*N) * abs(xfft).^2;
psd(2:end-1) = 2*psd(2:end-1);
freq = 0:fs/length(audioIn):fs/2;
psde = 10*log10(psd);
figure,
plot(freq,10*log10(psd));
grid on;
xlabel('Frequency(Hz)');
ylabel('Power/Frequency (db/hz)');

%finding magnitude vs freq spectrum

x_mag = abs(xfft);
N1 = [0 : N-1];
freq1 = N1*fs/N;
N2 = ceil(N/2);
magdb = 10*log10(x_mag(1:N2));
figure,
plot(freq1(1:N2), 10*log10(x_mag(1:N2)));
xlabel('Frequency(Hz)');
ylabel('Magnitude(db)');
%plotting  f axis as log so that similar to audacity
figure,
semilogx(freq1(1:N2), 10*log10(x_mag(1:N2)));
xlabel('log Frequency(Hz)');
ylabel('Magnitude(db)');







% dt = 1/fs; %seconds per sample)
% t = (0:dt:(length(audioIn)/fs)); %0 to length of audio sig
% N = size(t,1);
% %taking fft to convert sig to freq domain
% X = fft(audioIn);
% dF = fs/N;                      % hertz
% f = -fs/2:dF:fs/2-dF;
% 
% %plot spectrum
% 
% figure;
% plot(f,abs(X)/N);
% xlabel('Frequency (in hertz)');
% title('Magnitude Response');



