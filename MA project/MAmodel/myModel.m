categories = {'Ma','NonMA'};

rootFolder = 'TrainData';
imdsRTrain = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');
rootFolder = 'TestData';
imdsRTest = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');
 imdsTrain=shuffle(imdsRTrain);
 imdsTest=shuffle(imdsRTest);




layers = [ ...
    imageInputLayer([28 28 3])
    convolution2dLayer(5,20)
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];


options = trainingOptions('sgdm', ...
    'MaxEpochs',100,...
    'InitialLearnRate',1e-4, ...
    'Verbose',0, ...
    'Plots','training-progress');

[net, info] = trainNetwork(imdsTrain,layers,options);


YPred = classify(net,imdsTest);
YTest = imdsTest.Labels;

[x,t] = bodyfat_dataset;
net = feedforwardnet(10);
[net,tr] = train(net,x,t);
plotperform(tr)


ii = randi(22);
im = imread(imdsTest.Files{ii});
imshow(im);
if YPred(ii) == YTest(ii)
   colorText = 'g'; 
else
    colorText = 'r';
end
title(char(YPred(ii)),'Color',colorText);



confMat = confusionmat(YTest, YPred);
confMat = confMat./sum(confMat,2);
mean(diag(confMat))


accuracy = sum(YPred == YTest)/numel(YTest)

