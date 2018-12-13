pth = 'MAmodel/TrainData/MA/';% directory of the folder, where data files are saved
liste = dir(strcat(pth,'*.png')); % creates a list of all files in the folder directory pth

files = {liste.name};    % creates a cell array with the name of the data file


for k = 1:numel(files)

  fullname = strcat(pth,files{k}) ;
  I=imread(fullname);
  
  
%   I2 = I(:,end:-1:1,:);           %# horizontal flip
% I3 = I(end:-1:1,:,:);           %# vertical flip
% I4 = I(end:-1:1,end:-1:1,:);    %# horizontal+vertical flip
  RI=imrotate(I,90);
  RotateImageName=['extra MA/Rotate90Image' num2str(k) '.png'];
       imwrite(RI,RotateImageName);
       
       RI=imrotate(I,180);
  RotateImageName=['extra MA/Rotate180Image' num2str(k) '.png'];
       imwrite(RI,RotateImageName);
       
       
       
     FI=flip(I,1);
     FlipImageName=['extra MA/FlipImage' num2str(k) '.png'];
       imwrite(FI,FlipImageName);
       
       
    FI=flip(I,2);
     FlipImageName=['extra MA/Flip_hori_Image' num2str(k) '.png'];
       imwrite(FI,FlipImageName);
       
       FI = I(end:-1:1,end:-1:1,:);
     FlipImageName=['extra MA/Flip_hori_ver_Image' num2str(k) '.png'];
       imwrite(FI,FlipImageName);
    
       
end
  
  