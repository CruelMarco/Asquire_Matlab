clc
clear all
close all
%c1 = 164 hx c2 = 188Hz
pth='C:\Users\Spirelab\Desktop\Asquire\SD\All_After';
addpath(genpath(pth));
dirinfo = dir(pth);
kl={dirinfo.name}'
dirinfo1=kl(~ismember(kl,{'.','..'}))

wav_files = dir('*.wav'); %list all wav files
txt_files=dir('*.txt'); %list all txt files
kp={wav_files.name}'
%
as=[]
for h=1:length(wav_files)
newChr = strrep(kp(h,1),'.wav','')
as=[as,newChr]; %splitted names
end

for ji=1:length(as)
matches = regexp(dirinfo1 , as{1,ji});
ek = dirinfo1(~cellfun('isempty', matches))
%read wav file
[wav1,fs]=audioread(ek{2,1});
fid = fopen([ek{1,1}(1:end-3) 'txt']);
annot = textscan(fid,'%f\t%f\t%s' );
start_timestamp = annot{1,1};
finish_timestamp = annot{1,2};
label = annot{1,3};


phone={'yee','eee', 'ooo', 'aaa', 'uuu', 'zzz', 'sss'};
for jo=1:length(phone)
hj=phone{1,jo}

TF = contains(label,phone(1,jo),'IgnoreCase',true);
if(any(TF)==0)
    continue
else
st = min(start_timestamp(TF))
en = max(finish_timestamp(TF))
N = nnz(TF);

y_new = wav1(round(st*fs):round(en*fs));

% audiowrite([as{1,ji},'_',hj,'.wav'],y_new,fs);
audiowrite(fullfile('C:\Users\Spirelab\Desktop\Asquire\SD\sound split',[as{1,ji},'_',hj,'_', num2str(N, '%d') '.wav']),y_new,fs)
end
end


end




