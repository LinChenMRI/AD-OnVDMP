function [AUCMap,AUCMap_Dyn] = calculateCovAUCMap(CSFImage,Mask)

pre = 20;
post = 90;
AUCMap = zeros(size(CSFImage(:,:,1)));

for x_index = 1:1:size(AUCMap,1)
    for y_index = 1:1:size(AUCMap,2)
        if Mask(x_index,y_index) == 1
            Image_temp = squeeze(CSFImage(x_index,y_index,:));
            S_base = mean(Image_temp(1:pre));
            S_prepost =smooth(1 - Image_temp/S_base,5);
%              S_prepost =smooth(1 - Image_temp(pre+1:pre+post)/S_base,5);
            AUCMap(x_index,y_index)=sum(S_prepost);
        end
    end
end
AUCMap = medfilt2(imgaussfilt(AUCMap*100/(post+pre),1),[3,3]);
% AUCMap = medfilt2(imgaussfilt(AUCMap*100/(post),1),[3,3]);

averageImage = 10;
AUCMap_Dyn = zeros([size(CSFImage(:,:,1)),(pre+post)/averageImage]);
S_baseImage = mean(CSFImage(:,:,1:pre),3);

NormalizeImage = 1 - CSFImage./repmat(S_baseImage+eps,[1,1,(post +pre)]);
 for slicenum = 1:1:size(AUCMap_Dyn,3)
     AUCMap_Dyn_temp = mean(NormalizeImage(:,:,1+averageImage*(slicenum-1): averageImage*slicenum),3);
     AUCMap_Dyn_temp = medfilt2(imgaussfilt(AUCMap_Dyn_temp.*Mask,1),[3,3]);
     AUCMap_Dyn(:,:,slicenum) = AUCMap_Dyn_temp*100.*Mask;
 end
 AUCMap_Dyn = cat(3,zeros(size(CSFImage(:,:,1))),AUCMap_Dyn);
end