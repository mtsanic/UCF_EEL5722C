from scipy import misc
import math

# returns string of 12-bit color at row x, column y of image
def get_color_bits(im, y, x):
    # convert color components to byte string and slice needed upper bits
    b  = format(im[y][x][0], 'b').zfill(8)
    rx = b[0:4]
    b  = format(im[y][x][1], 'b').zfill(8)
    gx = b[0:4]
    b  = format(im[y][x][2], 'b').zfill(8)
    bx = b[0:4]

    # return concatination of RGB bits
    return str(int(str(rx+gx+bx), 2))


def rom_8_bit(name, im, mask=False, rem_x=-1, rem_y=-1):
    # make output filename from input
    file_name = name.split('.')[0] + ".coe"

    # open file
    f = open(file_name, 'w')

    # get image dimensions
    y_max, x_max, z = im.shape

    # get width of row and column case words
    row_width = math.ceil(math.log(y_max-1,2))
    col_width = math.ceil(math.log(x_max-1,2))

    # write beginning of .coe file
    f.write("memory_initialization_radix=10;\n")
    f.write("memory_initialization_vector=")

    # loops through y rows and x columns
    for y in range(y_max):
        for x in range(x_max):
            f.write(get_color_bits(im, y, x))
            if(x < x_max-1 or y < y_max-1):
               f.write(", ")
           
                
    f.write(";")
        
    print("use read depth: ")
    row_width = math.ceil(math.log(y_max-1,2))
    col_width = math.ceil(math.log(x_max-1,2))
    print(str((y_max*x_max)))
    # close file
    f.close()    

# driver function
def generate(name, rem_x=-1, rem_y=-1):
    im = misc.imread(name, mode = 'RGB')
    print("width: " + str(im.shape[1]) + ", height: " + str(im.shape[0]))
    rom_8_bit(name, im)

# generate rom from full bitmap image
generate("enemy_sprites.png")
