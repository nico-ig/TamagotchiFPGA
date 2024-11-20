import cv2
import numpy as np
import sys

for file in sys.argv[1:]:
    img = cv2.imread(file, cv2.IMREAD_GRAYSCALE)
    img //= 255
    img = np.concatenate(img)
    img = ''.join(map(str, img))
    b = int(img, 2).to_bytes(len(img) // 8, byteorder='big')

    with open('hexs/'+file.split('/')[1].split('.')[0]+'.hex', 'wb') as f:
            f.write(b)