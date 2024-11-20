import cv2
import numpy as np
import sys

for file in sys.argv[1:]:
    img = cv2.imread(file, cv2.IMREAD_GRAYSCALE)
    img //= 255
    img = np.concatenate(img)
    img = ''.join(map(str, img))

    with open('hexs/'+file.split('/')[1].split('.')[0]+'.hex', 'w') as f:
            f.write(f"{img}")