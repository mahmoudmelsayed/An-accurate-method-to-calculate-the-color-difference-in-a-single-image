function c=hsv(image)
HSVimage=rgb2hsv(image);
H=HSVimage(:,:,1);
S=HSVimage(:,:,2);
V=HSVimage(:,:,3);
maxH=max(max(H));
maxS=max(max(S));
maxV=max(max(V));
minH=min(min(H));
minS=min(min(S));
minV=min(min(V));
diff=(maxH-minH)^2+(maxS-minS)^2+(maxV-minV)^2;
c=sqrt(diff);
end