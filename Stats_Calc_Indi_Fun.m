tic;
filename = '4017_P_Asthma_M_before_Mil_Y_aaa_5.wav'
fid = fopen([filename(1:end-3) 'txt']);
annot = textscan(fid,'%f\t%f\t%s' );

[sig, fs] = audioread(filename);

start_timestamp = round(annot{1,1}*fs);
finish_timestamp = round(annot{1,2}*fs);
M = length(sig);
T = linspace(0,M/fs,M)';
st = zeros(1, M)';
st(start_timestamp) = 1;
en = zeros(1, M)';
en(finish_timestamp) = 1;
subplot(311);
hold on;
plot(T,sig);
plot(T,st,'green');
plot(T,en,'red');
title('AudioSig');
xlabel('Time');
ylabel('Amp');


[p,t,s] = swipep(sig,fs);
t2 = linspace(0,ceil(length(t)/1000),(length(t)));
t2 = t2';
subplot(312);
plot(t2 , s);
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
count = floor(l);
ind = find(temp1<0);
pred_start_ind = ind(1:2:end);   
pred_stop_ind = ind(2:2:end);
pred_start_time = zeros(1,length(t2))';
pred_start_time(pred_start_ind) = 1;
pred_stop_time = zeros(1,length(t2))';
pred_stop_time(pred_stop_ind) = 1;

predicted_duration = stop_time - st_time;



subplot(313);plot(t2,s);hold on;
plot(t2 , yy2,'g');hold on;
%plot([T(1) T(end)],[1 1]*ThPercent*max(f_sig),'k');
plot([1 length(t)/1000] , [1 1]*Th,'k');
plot(t2,pred_start_time,'red');
plot(t2,pred_stop_time,'blue');
title('Thresholding')

% % subplot(414);plot([1:length(sig)]/fs,f_sig);hold on;
% % plot(T,st_eng/max(st_eng)*max(f_sig),'g');hold on;
% % % plot([T(1) T(end)],[1 1]*ThPercent*max(f_sig),'k');
% % plot([T(1) T(end)],[1 1]*Th,'k');

toc;