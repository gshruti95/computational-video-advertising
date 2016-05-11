
function frame_list = segment_scene(dir_name)

frames = dir(dir_name);
total_frames = length(frames);

I1 = imread(strcat(dir_name,frames(3).name));
R1=imhist(I1(:,:,1));
G1=imhist(I1(:,:,2));
B1=imhist(I1(:,:,3));

HD = [];
    
for i = 4:total_frames  
    I2=imread(strcat(dir_name,frames(i).name));
    R2=imhist(I2(:,:,1));
    G2=imhist(I2(:,:,2));
    B2=imhist(I2(:,:,3));
    HD(i-1) = sum(sum(abs(R2-R1)))+sum(sum(abs(G2-G1)))+sum(sum(abs(B2-B1)));
    R1 =R2;
    G1 = G2;
    B1 = B2;
end

%arr = HD;
pos =[];

for i=11:length(HD)-10
	sum1 = 0;
	sum2 = 0;
    
	for j=1:10
		sum1=sum1+HD(i-j);
		sum2=sum2+HD(i+j);
    end
    
	avg1=sum1/10;
	avg2=sum2/10;
    
	if (HD(i)>5*avg1 && HD(i)>5*avg2)
		pos = [pos,i];
    end
    
end

frame_list = [];

for i=1:length(pos)
    if pos(i) <= (total_frames)
        frame_list = [frame_list,pos(i)];
    end
end

plot(HD);

end