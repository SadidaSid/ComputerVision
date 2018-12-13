pth = 'groundtruth75confidence/';% directory of the folder, where data files are saved
liste = dir(strcat(pth,'*.txt')); % creates a list of all files in the folder directory pth

files = {liste.name};    % creates a cell array with the name of the data file

eyeimagepth='eye_images/'
eyeimages_liste=dir(strcat(eyeimagepth,'*.png'));
eyeimage_files = {eyeimages_liste.name};
for k = 1:numel(files);
display('----------------------------------------------------------')    
% Extracting MA coordinates from coordinate files
fprintf('extracting MA coordinates from %s \n',files{k});
    display(files(k))
  fullname = strcat(pth,files{k}) ;
  
fid = fopen(fullname);
tline=0;

tline =fgetl(fid);

i=1;
x_MA_coords={};
y_MA_coords={};
if(tline==-1)
    display('No MA Coordinates Found');
end
while tline~=-1


line = strtrim(tline);

expression = ',';
CS = regexp(line,expression,'split');

x_MA_coords{i}=str2double(CS{1});
y_MA_coords{i}=str2double(CS{2});
fprintf('MA x coordinate %d= %f \n',i,x_MA_coords{i});
fprintf('MA y coordinate %d= %f \n',i,y_MA_coords{i});


i=i+1;


 tline =fgetl(fid);
end

fprintf('MA COORDINATES NOT FOUND FLAG: %d \n',isempty(x_MA_coords));
fclose(fid);


Total_no_of_MApatches=numel(y_MA_coords);

eyeimage_filename = strcat(eyeimagepth,eyeimage_files{k});
A=imread(eyeimage_filename);




% Generate Randomnumbers for Non Ma Patches
ymin=15;
xmin=25;
% xmax=Imagewidth-20=1500-100=1400
% ymax=Imageheigth-20=1152-20=1132

% Generating NonMapatches
xmax=1400;
ymax=1132;
n=20;


x_center_of_NonMApatch=xmin+rand(1,n)*(xmax-xmin);
y_center_of_NonMApatch=ymin+rand(1,n)*(ymax-ymin);

Total_no_of_NonMApatches=n;
display('................')
fprintf('Generating Non MA patches for EyeImage:%d \n', k);

for ind=1:Total_no_of_NonMApatches;
overlapflag=0;
if not(isempty(x_MA_coords))
for p=1:Total_no_of_MApatches;
    
    
    
    if not(abs(x_center_of_NonMApatch(ind)-x_MA_coords{p})>=29 & abs(y_center_of_NonMApatch(ind)-y_MA_coords{p})>=28)
      overlapflag=1;
    
    end
end
end
if overlapflag==0
    patchsize=28;
    x_Center_of_NonMApatch=x_center_of_NonMApatch(ind);
    y_Center_of_NonMApatch=y_center_of_NonMApatch(ind);
    top_left_x=x_Center_of_NonMApatch-patchsize/2;
    top_left_y=y_Center_of_NonMApatch-patchsize/2;


   INMA=imcrop(A,[top_left_x top_left_y patchsize-1 patchsize-1]) ;
   
 ImageName=['NonMApatches/Image' num2str(k) 'NonMaPatch-' num2str(ind) '.png'];
%     save cropped MA patch
    imwrite(INMA,ImageName);
    
end
end
display('Saving cropped non MA patches in MA Project/NonMApatches folder');
 
% Generating MA patches
display('................')

if not(isempty(x_MA_coords))
    fprintf('Generating MA patches for EyeImage:%d \n', k);
  for ind=1:Total_no_of_MApatches;
    
    
    patchsize=28;
    
    
    x_Center_of_MApatch=x_MA_coords{ind};
    y_Center_of_MApatch=y_MA_coords{ind};
    
    top_left_x=x_Center_of_MApatch-patchsize/2;
    
    top_left_y=y_Center_of_MApatch-patchsize/2;
    


   IMA=imcrop(A,[top_left_x top_left_y patchsize-1 patchsize-1]) ;
 ImageName=['MApatches/Image' num2str(k) 'MaPatch-' num2str(ind) '.png'];
    
%     save cropped MA patches
    imwrite(IMA,ImageName);
    
  end  
  display('Saving cropped MA patches in MA Project/MApatches folder');
else
        display('No MA patches from this image');
end
display('----------------------------------------------------------')  
    
end