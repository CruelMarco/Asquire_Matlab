vowel = 'yee';
source = 'C:\Users\Spirelab\Desktop\Asquire\New folder\unpacked_audio\unpackd_audio';
dest = ['C:\Users\Spirelab\Desktop\Asquire\New folder\unpacked_audio\' vowel '_Files'];
dirinfo = dir(source);
filename = {dirinfo.name}';
filename=filename(~ismember(filename,{'.','..'}));
TF = contains(filename , vowel , 'IgnoreCase' , true);
aaa_files = filename(TF);
for i = 1 : length(aaa_files)
    sourcefile = fullfile(source , aaa_files(i));
    destfile = fullfile(dest);
    copyfile (sourcefile{1} , destfile) ; 
end


