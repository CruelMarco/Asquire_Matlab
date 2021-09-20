[audioIn,fs] = audioread('4012_P_Asthma_F_after_Mil_Y_aaa_5.wav');

audioIn = normalize(audioIn);

%f0 = pitch(audioIn,fs,'Method','SRH');

%sound(audioIn,fs)

tiledlayout(2,1)

nexttile
plot(audioIn)
title('Audio Signal')
xlabel('Sample Number')
ylabel('Amplitude')

% nexttile
% plot(f0)
% xlabel('Frame Number')
% ylabel('Pitch (Hz)')



 

[f0_time,f0_value,SHR,f0_candidates]=shrp(audioIn,fs);
% shr = SHR(SHR<0.4);
% figure,
% plot(shr);
% title('SHRP Func <0.4')

figure,
plot(SHR);
title('SHR')

[p,t,s] = swipep(audioIn,fs);
%s = s(s>0.4);
figure,
plot(s);
title('swipep')

[~,S1] = ischange(p, 'mean',1);
figure,
a = plot(p,'.');
title('change')






