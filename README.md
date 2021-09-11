# Motion_Controlled_Game
This game is an obstacle avoiding game made on processing IDE in Java in which user has two option that it jump or duck the incoming obstacles. It has been interfaced with motion detector using socket communication between python and processing.  Motion detector is made using openCV that uses webcam to get the frames and detects the object and tracks it. In low lighting one can put their palm in front of webcam to detect it. If the palm is slided up then the player will jump and if the palm is slided down then the player will duck.

# How to play :
- Open the `Motion_Detection.py` and run it .
- Open the `Final_Project/Final_Project.pde` processing file and start the game.
- When connection is established webcam will be on and use your palm to slide up to jump and slide down to duck.
- Make sure your room has very low lighting conditon for better performance.
