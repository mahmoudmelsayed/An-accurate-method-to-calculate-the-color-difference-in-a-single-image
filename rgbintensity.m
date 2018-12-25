function a=rgbintensity(image)
R=image(:,:,1);
G=image(:,:,2);
B=image(:,:,3);
maxR=max(max(R));
maxG=max(max(G));
maxB=max(max(B));
minR=min(min(R));
minG=min(min(G));
minB=min(min(B));
diff=(maxR-minR)^2+(maxG-minG)^2+(maxB-minB)^2;
di=double(diff);
a=sqrt(di);
end

