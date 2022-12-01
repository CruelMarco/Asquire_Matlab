tic;
close;
audio_files = dir('*.wav');
all_fns1 = {audio_files(:).name};
vowels = {'aaa' , 'eee' , 'ooo' , 'yee' , 'uuu'};
TF1 = contains(all_fns1 , vowels , 'IgnoreCase' , true); %excluding non-vowel files for the algo
all_fns = all_fns1(TF1);


fms = zeros(1, length(all_fns));
count = zeros(4, length(all_fns));

for k=1:length(all_fns)
    filename = all_fns{k};


[p,t,s] = swipep(filename,fs);
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


    t = split(filename, "_");t = t{length(t)};
    t = split(t, "."); t = t{1};
    true_count = str2double(t);

    disp(["true_count" true_count ";" "pred_count" l]);
    
    count(1, k) = true_count;
    count(2, k) = l;
    count(3, k) = abs(true_count - l);
end

count(4, :) = count(3, :) > 1;

cor = find(count(4, :) == 0);

accuracy = length(cor) / length(count(4, : )) * 100;

figure;
subplot(2, 1, 1);
stem(1: length(fms), fms);

subplot(2, 1, 2);
stem(1: length(count), count(4, :));
toc;