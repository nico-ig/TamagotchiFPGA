import cv2
import numpy as np
import sys

for file in sys.argv[1:]:
    img = cv2.imread(file, cv2.IMREAD_GRAYSCALE)
    img //= 255
    img = np.concatenate(img)
    img = ''.join(map(str, img))
    img = hex(int(img, 2))[2:]
    img = " ".join(img[i:i+2] for i in range(0, len(img), 2))

    with open('hexs/'+file.split('/')[1].split('.')[0]+'.hex', 'w') as f:
            f.write(f"{img}")