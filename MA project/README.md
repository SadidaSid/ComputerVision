Objective:
Our project aim is to train a custom built CNN model to detect pictures(patches) having eye lesion( MA-microaneurysm) by using ground truth(pictures having  coordinates of lesions manually detected by doctors) .The ground truth images were two large and so we divided them into patches of size(28*28).So our agenda is to mark a particular  patch(picture) into one of the two catogeries: MA and non-MA. 

MA= class or patch having lesion
non-Ma= class or patch having no lesion



We have used data augmentation for increasing the no of MA patches having eye lesions

Tools:
 MATLAB
 
 Source of groundtruth:
 Database:DIARETDB1


Procedures:

Data Preparation:

We had 89 Retinal Fundus Images along with the
groundtruth consisting of coordinates that marked
centers of MA lesions for each image. The images
from the dataset were not directly used by model but
they were first converted into patches of size 28*28
pixels that could be used for training. Using
groundtruth, we were able to generate 211 MA
patches and 1300 nonMA patches. The number of
MA patches generated were not sufficient for the
purpose of training so data augmentation was used to
increase the number of MA Patches before initiating
the training phase.



Data Augmentation:

We performed augmentation on MA patches taken
out from dataset for training using rotation and
reflection functions such that we were able to
produce 1000 more MA patches. Our training data
consisted of 1000 patches from each of the classes
and the testing data consisted of 22 patches from
each of the classes after splitting.

Training:

Our model used 100 epochs to iterate over the
training set with 0.0001 as learning rate. It used
Stochastic Gradient Descent technique to optimize
loss function. We used Relu as the activation
function and Softmax layer for classification.
Testing:

Once the data is trained into the system, we
conducted testing on 44 image patches, 22 MA and
22 Non-MA patches and were able to achieve 0.9048
accuracy.
