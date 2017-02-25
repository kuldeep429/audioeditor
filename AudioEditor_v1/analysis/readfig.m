function g = readfig(fullfileName)

[a,map]=imread(fullfileName);
[r,c,d]=size(a);
x=ceil(r/30);
y=ceil(c/30);
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;

end