file_name = '4012_P_Asthma_F_after_Mil_Y.wav';
[y,fs] = audioread(file_name);
fid = fopen([file_name(1:end-3) 'txt']);
annot = textscan(fid,'%f\t%f\t%s' );
start_timestamp = annot{1,1};
finish_timestamp = annot{1,2};
label = annot{1,3};
TF = contains(label,'yee','IgnoreCase',true);
N = nnz(TF);
st = min(start_timestamp(TF));
en = max(finish_timestamp(TF));
y_new = y(round(st*fs):round(en*fs));
audiowrite([file_name(1:end-4) '_yee'  '_' num2str(N,'%d' ) '.wav'],y_new,fs);