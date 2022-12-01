clear all
[sig, fs] = audioread('ae_107_60960.wav');
%finding power spectrum
M = length(sig);
xfft = fft(sig);
xfft = xfft(1 : M/2+1);
psd = (1/fs*M) * abs(xfft).^2;
psd(2:end-1) = 2*psd(2:end-1);
freq = 0:fs/length(sig):fs/2;
psde = 10*log10(psd);
figure,
plot(freq,10*log10(psd));
grid on;
xlabel('Frequency(Hz)');
ylabel('Power/Frequency (db/hz)');

%finding magnitude vs freq spectrum

x_mag = abs(xfft);
N1 = [0 : M-1];
freq1 = N1*fs/M;
N2 = ceil(M/2);
magdb = 10*log10(x_mag(1:N2));
[maxdB,FreqIdx] = max(magdb); %maximum magnitude
MaxFreq = freq1(FreqIdx);

%dbcut = maxdB-3; %magnitude for cutoff frequencies

% cutidx = find(floor(magdb) == floor(dbcut));
% 
% fc1 = floor(freq1(cutidx(1)));
% fc2 = floor(freq1(cutidx(length(cutidx))));

offset = 50;

fc1 = MaxFreq - offset;
fc2 = MaxFreq + offset;




figure,
plot(freq1(1:N2), 10*log10(x_mag(1:N2)));
xlabel('Frequency(Hz)');
ylabel('Magnitude(db)');
%plotting  f axis as log so that similar to audacity
figure,
semilogx(freq1(1:N2), 10*log10(x_mag(1:N2)));
xlabel('log Frequency(Hz)');
ylabel('Magnitude(db)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%filter design and calculation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fc1=4900;fc2=5100;
%fc1=5000;fc2=6000;
%fc1=159;fc2=185;
%fc1=500;fc2=600;
engwin=0.9;%in sec
ThPercent=0.2;

%%% read audio
%[sig,fs]=audioread(wavfile);

%wavfile = vertcat(zeros(fs,1), wavfile , zeros(fs,1));

%%% design filter
[b,a]=cheby2(4,40,[fc1 fc2]/(fs/2),'bandpass');
% freqz(b,a)

%%% filter signal
f_sig=filtfilt(b,a,sig);

%%% compute st energy
N=round(engwin*fs);
n_frames = floor(length(f_sig)/N);
st_eng = zeros(n_frames, 1);
T = st_eng;
for i = 0:n_frames-1
    idx_frame = i*N+1:(i+1)*N;
    frame = f_sig(idx_frame);
    st_eng(i+1) = mean(abs(frame)*2);
    T(i+1) = idx_frame(N/2)/fs;
end
% st_eng_m = mean(st_eng);
st_eng_m = max(st_eng);

%%% detect segments
% Th=ThPercent*max(st_eng);
% temp=sign(st_eng-Th);
% temp1=temp(1:end-1).*temp(2:end);
% length(find(temp1<0))
Th=st_eng_m * ThPercent;
temp=sign(st_eng-Th);
temp1=temp(1:end-1).*temp(2:end);
length(find(temp1<0))

figure,
subplot(211);plot([1:length(sig)]/fs,sig);
subplot(212);plot([1:length(sig)]/fs,f_sig);hold on;
plot(T,st_eng/max(st_eng)*max(f_sig),'g');hold on;
%plot([T(1) T(end)],[1 1]*ThPercent*max(f_sig),'k');
plot([T(1) T(end)],[1 1]*Th,'k');







% dt = 1/fs; %seconds per sample)
% t = (0:dt:(length(sig)/fs)); %0 to length of audio sig
% N = size(t,1);
% %taking fft to convert sig to freq domain
% X = fft(sig);
% dF = fs/N;                      % hertz
% f = -fs/2:dF:fs/2-dF;
% 
% %plot spectrum
% 
% figure;
% plot(f,abs(X)/N);
% xlabel('Frequency (in hertz)');
% title('Magnitude Response');
% [~,index] = max(max0);
% frequency_value = f(index)

% y56Idx = find(y>=5 & y<=6);
% x56Rng = [x(y56Idx(1)) x(y56Idx(end))]


