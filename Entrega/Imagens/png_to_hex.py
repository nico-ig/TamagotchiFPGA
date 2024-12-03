import cv2
import numpy as np
import sys

for file in sys.argv[1:]:
    if file.endswith('.png'):
        img = cv2.imread(file, cv2.IMREAD_GRAYSCALE)
        img //= 255
        img = np.concatenate(img)
        img = ''.join(map(str, img))

        hex_f = ''
        for i in range(0, len(img), 4):
            hex_f += f'{hex(int(img[i:i+4], 2))[2:]}'
            if ((i+4) % 8 == 0):
                hex_f += ' '
        hex_f = hex_f[0:len(hex_f)-1]

        hex_f = hex_f.split(' ')

        inverted_hex = ''
        for i in range(0, len(hex_f), 8):
            inverted_hex += ' '.join(hex_f[i: i+8][::-1]) + ' '

        inverted_hex = inverted_hex[:-1]

        with open('hexs/'+file.split('/')[1].split('.')[0]+'.hex', 'w') as f:
                f.write(f'{inverted_hex}')