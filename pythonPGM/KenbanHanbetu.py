import cv2
import numpy as np
import sys


img = cv2.imread('./out4/A6.jpg');

"""
print(str(img[34,175]))
print(str(img[61, 98]))
"""

print(img[175, 34])
print(img[98,61])
