# Introduction
1. Built a real-time alarm system to protect unattended laptop from intruder based on MATLAB GUI.
2. Implemented Otsu threshold Method to detect human face in front of the camera.
3. Created user login using username and password, detected keyboard input and made alarm sound to drive away the intruder.
4.  Applied SMTP to send emails with intruder’s images to mailbox.

In our daily life, there is possibility that our laptop is touched or even stolen by someone when we leave the laptop alone in library. In order to prevent our laptop in danger under this circumstance, we design the alarm system based on Matlab GUI which is easy to build and realize applications. All this project is based on mac operating system and Matlab2016b.

# Abstract

Alarm system is based on Matlab GUI interface. Using buttons control panel and camera input to show real-time monitor environment. If the images from the camera changes, it will be compared which are acquired from Otsu threshold method. What’s more, the images are converted into binary images and if any difference is detected, the monitor alarm will run and send e-mails to the user. It’s the SMTP technique that play an important role. In addition, a warning alarm function based on keyboard press detection and password function is designed. Once the intruder tries to press any keys, a warning sound will not stop until the alarm is closed through the password system.  

## 1.Matlab GUI
 
Matlab GUI(Graphical User Interface) provides an easy control of software applications and only need to download some toolboxes. Matlab itself provides a guide that you can design the Matlab GUI in custom ways. In the guide menu, Matlab can create some initialization and settings codes automatically after designing your own buttons [2]. And then you can apply function codes into each buttons. If typing “imaqhwinfo” in Matlab console, you will get the basic camera information. And if typing vid = videoinput('macvideo',1), you can get the important parameters like “TriggerRepeat”, “FramesPerTrigger” and “FrameGrabInterval”.


## 2.Otsu threshold Method
The basic idea of Otsu threshold method: Reduction of a graylevel image to a binary image [3]. The algorithm assumes that the image contains two classes of pixels (foreground pixels and background pixels), it then calculates the optimum threshold separating the two classes so that their intra-class variance is minimal. We use Otsu to process the images of different time. Then Compare the current binary image and next frame’s binary image. If the difference is larger than the threshold, we will design to make a snapshot. In Matlab, we use “graythresh()” and “im2bw(frame,level)” to get the threshold and binary image respectively.

## 3. Send e-mail using SMTP
SMTP stands for Simple Mail Transfer Protocol. SMTP is used when email is delivered from an email client, such as GMail, to an email server or when email is delivered from one email server to another [1]. In order to send e-mails from Matlab, we have to give the Matlab the authority to access our email account (we are using Gmail in this function). In other words, use SMTP in Matlab and open access to Matlab from Gmail. In this way can we send the emails from matlab to the selected mailbox with the snapshot.

## 4. Warning alarm system
Matlab can play audio file and detect key press. So we combine these two functions and design a warning system which can detect keyboard press. Playing warning sound is quite simple by using “audioread”. Keyboard detection can be realized through creating a dependent key press function. Once the key press is detected, the warning sound will be played unstoppably. In this way can the intruder be warned to leave, once the alarm is activated.


## 5. Password system
the alarm system can be activated if the conditions are satisfied. However, in order to avoid the situations that the intruder can close off the warning system, we design the password system on the “stop alarm” and “exit” buttons. The password system is based on an input dialog using “inputdlg” and set password verification which also provides the message whether the password is correct or not. What’s more, the password can be set by the user from a-z, 0-9 which is difficult to be cracked.












