function b=lab(image)
LABimage=rgb2lab(image);
L=LABimage(:,:,1);
A=LABimage(:,:,2);
B=LABimage(:,:,3);
maxL=max(max(L));
maxA=max(max(A));
maxB=max(max(B));
minL=min(min(L));
minA=min(min(A));
minB=min(min(B));
diff=(maxL-minL)^2+(maxA-minA)^2+(maxB-minB)^2;
b=sqrt(diff);
end