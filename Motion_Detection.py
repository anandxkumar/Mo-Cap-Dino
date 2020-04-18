#Motion Detection

import cv2
import time
import  datetime
import imutils

# Using Socket Communication for interfacing of processing IDE and motion detector 
import socket

HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 5204           # Arbitrary  port  number that will be used to get 
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)
conn, addr = s.accept()
print('Connected by', addr)


def motion_detection():
    video_capture = cv2.VideoCapture(0) # webcam
    time.sleep(2)
    
    first_frame = None
    temp =0   # used to get the previous y coordinate of the hand 
    count = 0  # To calculate number of frames
    width = video_capture.get(3)
    height = video_capture.get(4)
    fps = video_capture.get(5)
    
    y0 = 0    # Gets current y coordinate of hand 
    motion = ''
    temp = 0
    duration = 0
    t =0
    while True :
        
        check, frame = video_capture.read()  # getting frames from the 
        text = 'Nothing'
        data = 'n'
        
        grayscale_frame = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY) # converts into a gray scale image
        
        gaussian_frame = cv2.GaussianBlur(grayscale_frame,(21,21),0) # 21x21 gaussian grid is multiplied with input image so that we can get the centre index
        
        blur_frame = cv2.blur(gaussian_frame, (5,5),0) #5x5 blur grid is multiplied with input image
        
        grayscale_img = blur_frame
        
        if first_frame is None :
            first_frame = grayscale_img
            
        else :
            pass
        
        frame = imutils.resize(frame, width = 500)
        
        '''Calculates the absolute difference between each element/pixel between
        the two images , first_frame - grayscale (on each pixel) '''
        
        frame_delta = cv2.absdiff(first_frame, grayscale_img)
        
        ''' Threshold gives two output check, threshold image, using [1]
        will give the threshold image '''
        
        thresh = cv2.threshold(frame_delta,100,225,cv2.THRESH_BINARY)[1]
        
        '''dilate gives 3 output - dilate ,grow, expand
        dilate basically enlarges the white pixels which are in the foreground in a
        binary image i.e black background and white foreground
        element = Mat() = default 3x3 kernal matrix and iteratios =2 means it will do it twice'''
        
        dilate_image = cv2.dilate(thresh,None,iterations = 2)
        
        '''contours gives 3 diff o/p - image, contours and hierarchy, so using 
        [1] at the end means contours = (cnt)[1]  cv2.CHAIN_APPROX _SIMPLE 
        saves memory by removing all redundant points and compressing contour,
        if u have a rectangle with 4 straight lines u don't need to plot each 
        point on the line , u only need to plot the corners of the rectangle and 
        the join th elines, eg - if 100 points were used before now only 4 points are being used
        '''
        cnt =cv2.findContours(dilate_image.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE) [0] # Gets the image
        count =count +1
        for c in cnt :
            # if the contour area is more than 800 non -zero pixels (not black)
            if cv2.contourArea(c) > 20000 :
                # so we are getting the coordinates of the object detected
                (x,y,w,h) = cv2.boundingRect(c)
                
                
                cv2.rectangle(frame,(x,y),(x+w,y+h),(0,255,0),2) # 0,255,0 means green color box with thickness 2
                
                text = 'object detected'
                y0 = y + h
                temp = y
                duration = 1
                data = ' '
                
            elif duration == 1:
                
                if (temp > 150 or y0 >200) :
                    motion = 'down'
                    data = 'd'
                    
                if (temp <100 ):
                    motion ='up'
                    data = 'u'
                temp = 0
                y0 = 0
                conn.send(data.encode()) # sending  data character to processing IDE
                t = t+1
                duration = 0
                
            else :
                duration = 0
                data = ' '
                    
                        
       
            
        
        font = cv2.FONT_HERSHEY_SIMPLEX
        
        cv2.putText(frame, f' Object Moved {text}', (10,20), font , 0.5, (0,0,255),2) # 0.5 is size, 2 is thickness
        
        cv2.putText(frame, f' Object Moved y-coor {y0} ,{count},{temp}, {motion}, {duration},{t}', (100,50), font , 0.5, (0,0,255),2)
        
        
        
       
        
        
        #cv2.imshow("Dilate", dilate_image)
        #cv2.imshow('Frame_delta', frame_delta)   
        cv2.imshow("Object_Detection",frame)
        
        key = cv2.waitKey(1) & 0xFF # 0xFF = 11111111 in binary format and taking AND with the key so that we get the last 8 bits value
        if key == ord('q'):
            cv2.destroyAllWindows()
            break


motion_detection()