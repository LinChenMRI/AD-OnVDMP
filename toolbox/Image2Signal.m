function Signal = Image2Signal(Image,Mask)
% Extract signal from Image


Image = Image.*repmat(Mask,[1,1,size(Image,3)]);

Signal = squeeze(sum(sum(Image,1),2))/sum(Mask(:));

end