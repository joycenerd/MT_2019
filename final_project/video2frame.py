import cv2
import time
import os

def vid2frame(vid_name,wrt_dir):
    start_time=time.time()
    vidcap=cv2.VideoCapture(vid_name)
    print(vid_name)
    success,image=vidcap.read()
    count=0
    
    while success:
        cv2.imwrite(os.path.join(wrt_dir,"frame%d.jpg") % count,image)
        success,image=vidcap.read()
        print('Read a new frame: ',success)
        count+=1
    print("--- %s seconds ---" %(time.time()-start_time))
    print("\n")

vid2frame("./src/morphing1/morphing1.mp4","./src/morphing1")
vid2frame("./src/morphing2/morphing2.mp4","./src/morphing2")
