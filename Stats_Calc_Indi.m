[sig, fs] = audioread('4246_P_Asthma_F_after_TBD_Y_ooo_5.wav');
subplot(221)
M = length(sig);
xfft = fft(sig);
x_mag = abs(xfft);
N1 = [0 : M-1];
freq1 = N1*fs/M;
N2 = ceil(M/2);
subplot(411)
plot(sig);
title('Audio Signal');
xlabel('No. of Samples');
ylabel('Amp');
subplot(412);
plot(freq1(1:N2), 10*log10(x_mag(1:N2)));
title('Spectrogram');
xlabel('Frequency(Hz)');
ylabel('Magnitude(db)');

[p,t,s] = swipep(sig,fs);
subplot(413);
plot(s);
title('Swipep')

x = (0 : length(s)-1);
y = s' ;
yy2 = smooth(x,y,2001,'sgolay',4);
st_eng = yy2 ; 
st_eng_m = 0.5*max(yy2);

Th=st_eng_m;
temp=sign(st_eng-Th);
temp1=temp(1:end-1).*temp(2:end);
length(find(temp1<0));
l = (length(find(temp1<0)))/2;
l = floor(l)

subplot(414);plot(s);hold on;
plot(yy2,'g');hold on;
%plot([T(1) T(end)],[1 1]*ThPercent*max(f_sig),'k');
plot([1 length(s)],[1 1]*Th,'k');
title('Thresholding')

% % subplot(414);plot([1:length(sig)]/fs,f_sig);hold on;
% % plot(T,st_eng/max(st_eng)*max(f_sig),'g');hold on;
% % % plot([T(1) T(end)],[1 1]*ThPercent*max(f_sig),'k');
% % plot([T(1) T(end)],[1 1]*Th,'k');









%plotting  f axis as log so that similar to audacity
% figure,
% semilogx(freq1(1:N2), 10*log10(x_mag(1:N2)));
% xlabel('log Frequency(Hz)');
% ylabel('Magnitude(db)');