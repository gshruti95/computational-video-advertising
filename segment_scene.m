
function [frame_list,value_list,HD,BSC] = segment_scene(video_file_name)
% if ispc %For Windows
%     system('del ./frames/*.jpg');
%     ffmpeg_frame_cmd = sprintf('%s%s%s%s%s%s%s%s',pwd,'/ffmpeg/bin/ffmpeg -i ',...
%         pwd,'/',video_file_name,' -qscale:v 4 ',pwd,'/frames/out%08d.jpg');
%     disp(ffmpeg_frame_cmd);
%     system(ffmpeg_frame_cmd);
% else %For Linux/Other
%     
% end

tic;

dir_name = './frames/';
frames = dir(dir_name);
total_frames = length(frames);

I1 = imread(strcat(dir_name,frames(3).name));
R1=imhist(I1(:,:,1));
G1=imhist(I1(:,:,2));
B1=imhist(I1(:,:,3));

HD = [];

disp('Calculating Histogram of Differences');
for i = 4:total_frames  
    I2=imread(strcat(dir_name,frames(i).name));
    R2=imhist(I2(:,:,1));
    G2=imhist(I2(:,:,2));
    B2=imhist(I2(:,:,3));
    HD(i-1) = sum(sum(abs(R2-R1)))+sum(sum(abs(G2-G1)))+sum(sum(abs(B2-B1)));
    R1 = R2;
    G1 = G2;
    B1 = B2;
end
toc;

%arr = HD;
pos =[];
val =[];

disp('Getting candidate shot boundaries');
tic;
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
        val = [val,HD(i)];
    end
    
end

frame_list = [];
value_list = [];

for i=1:length(pos)
    if pos(i) <= (total_frames)
        frame_list = [frame_list,pos(i)];
        value_list = [value_list,val(i)];
    end
end

plot(HD); % Plotting the detected shot boundaries
% frame_list - List of frame numbers of detected shots
% value_list - Values of frame difference at these peaks

toc;

% Calculate keyframes
% For now, assuming keyframes are the starting frame

% Compute Backward Shot Coherence (BSC) for upto 10 previous shots
disp('Calculating Backward Shot Coherence');
tic;
BSC = [];
N = 10;
total_shots = length(frame_list);
for i=1:total_shots
    max_sc = 0;
    I1 = imread(strcat(dir_name,frames(frame_list(i)).name));
    R1=imhist(I1(:,:,1));
    G1=imhist(I1(:,:,2));
    B1=imhist(I1(:,:,3));
    for j =1:N
        if i-j < 1
            break;
        end
        I2=imread(strcat(dir_name,frames(frame_list(i-j)).name));
        R2=imhist(I2(:,:,1));
        G2=imhist(I2(:,:,2));
        B2=imhist(I2(:,:,3));
        sc = sum(sum(abs(R2-R1)))+sum(sum(abs(G2-G1)))+sum(sum(abs(B2-B1)));
        if sc >= max_sc
            max_sc = sc;
        end
    end
    BSC = [BSC max_sc];
end
toc;
plot(BSC);

end