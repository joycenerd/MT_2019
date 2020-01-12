video=VideoWriter('result/morphing');
open(video);

for frame=0:29
    image=imread("result/frames/frame"+frame+".jpg");
    writeVideo(video,image);
end

close(video);