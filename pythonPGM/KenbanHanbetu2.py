import cv2
import numpy as np
import sys




def GetInitPos(img, stKenban):

    height, width, channels = img.shape
    
    str1 = ""
    for x in range(width):
        for y in range(height):
        
            bgr = img[y, x]
            if (bgr[0] == 0 and
               bgr[1] == 0 and
               bgr[2] == 255 ):
               
                str1 = "[" + str(x) + "," + str(y) + "]"
                str1 += ":" + str(bgr)
                
                print(str1)
                
                return [x, y]
                

kenbanList = ["C", "Cs", "D", "Ds", "E", "F", "Fs", "G", "Gs", "A", "As", "B", "C"]
 
#隣り合う白鍵と黒鍵の幅
DiffWidth = [0, 22, 26, 25, 24, 50, 27, 25, 25, 23, 26, 26, 47]
HightList = [175, 95, 175, 95, 175, 175, 95, 175, 95, 175, 95, 175, 175]

def GetCode(stX, stY, stKenban, kenbanList, DiffWidth, HightList, img):

    imgHeight, imgWidth, channels = img.shape
    
    retCode = []
    #3オクターブ目から始まることとする
    oct = int(3)
    
    for i in range(len(kenbanList)):
        if stKenban == kenbanList[i]:
           k1 = i
           break
    
    #print(k1)
            
    
    x1 = stX
    y1 = HightList[k1]
    kenbanName = kenbanList[k1]
    kenbanName += str(oct)
    
    while x1 < imgWidth:
        #print("-(" + str(x1) + "," + str(y1) +")-") 
        
        colVal = img[y1, x1]
        if(len(kenbanName) == 2):
            if(colVal[0] == 0 and
               colVal[1] == 0 and
               colVal[2] == 0 ):
               
               retCode.append(kenbanName);
        elif(len(kenbanName) == 3):
            if(colVal[0] == 255 and
               colVal[1] == 255 and
               colVal[2] == 255 ):
               
               retCode.append(kenbanName)

        if k1+1 < len(kenbanList):
            k1 = k1+1
            x1 = x1 + DiffWidth[k1]
            y1 = HightList[k1]
            
            kenbanName = kenbanList[k1]
            if (kenbanName == "C" and
                   k1 != 0):
                oct = oct+1
                
            kenbanName += str(oct)
            
        else:
           k1 = 1
           x1 = x1 + DiffWidth[k1]
           y1 = HightList[k1]
           kenbanName = kenbanList[k1]
           kenbanName += str(oct)
        
    
    return retCode;



def GetCodeImgPosFromCodeName(CodeName):

    f1 = open('CodeImgPos.txt', 'r');
    
    while True:
        line = f1.readline();
        
        if line == '':
            break;
        
        datalist = line.split(',')
        code1 = datalist[0]
        datalist[3] = datalist[3].replace('\n','')
        if CodeName == code1:
            return datalist[0], datalist[1], datalist[2], datalist[3]
            
    
    return 0, 0, 0, 0
    

def GetCodeNameFromStr(fname):

    c1 = ''
    c1 += fname[0]
    if len(c1) < 6:
        return c1
    elif str[1:6] == 'sharp':
        c1 += 'sharp'
        return c1

def writeCodeFile1(inputfname1, outputfname1, folderURL, kenbanList, DiffWidth, HightList):

    f1 = open(inputfname1, 'r')
    f2 = open(outputfname1, 'w')
    
    while True:
        fname1 = f1.readline()
        if fname1 == '':
            break
        
        #print(fname1)
             
        codeName3 = GetCodeNameFromStr(fname1)
        
        URL1 = folderURL;
        URL1 += '\\'
        URL1 += fname1;
        URL1 = URL1.replace('\n','')
        Img = cv2.imread(URL1);
        
        CodeName1, x1, y1, CodeName2 = GetCodeImgPosFromCodeName(codeName3)
        
        x1 = int(x1)
        y1 = int(y1)
        retVal = GetCode(x1, y1, CodeName2, kenbanList, DiffWidth, HightList, Img);
        
        
        wline = ''
        wline += fname1;
        wline = wline.replace('\n','')
        wline = wline.replace('.jpg','')
        
        for i in range(len(retVal)):
            c1 = retVal[i]
            wline += ','
            wline += c1
            
        f2.write(wline)
        f2.write('\n')
        
    
    f2.close()
    


inputFname1 = r"C:\hogehoge\Desktop\python\kenbanHanbetu\codeImgFileNames1.txt"
outputFname1 = r"C:\hogehoge\Desktop\python\kenbanHanbetu\codeCompose1.txt"
folderURL = r"C:\hogehoge\Desktop\python\kenbanHanbetu\out2-2"
writeCodeFile1(inputFname1, outputFname1, folderURL, kenbanList, DiffWidth, HightList)

inputFname1 = r"C:\hogehoge\Desktop\python\kenbanHanbetu\codeImgFileNames2.txt"
outputFname1 = r"C:\hogehoge\Desktop\python\kenbanHanbetu\codeCompose2.txt"
folderURL = r"C:\hogehoge\Desktop\python\kenbanHanbetu\out2-1"
writeCodeFile1(inputFname1, outputFname1, folderURL, kenbanList, DiffWidth, HightList)

