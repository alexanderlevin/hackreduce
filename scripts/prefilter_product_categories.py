RAW_DIR = '../data/'
TRAIN_SET = 'training.csv'
QUESTION_SET = 'test.csv'
TRAIN_PATH = RAW_DIR + TRAIN_SET
QUESTION_PATH = RAW_DIR + QUESTION_SET
import sys
import pdb

def load_train( dataset ):
    f = open( dataset, 'r' )
    y = f.read()
    f.close()
    x = y.split('\r')
    return x

"""
Simple script for printing out frozen and non-frozen foods.
"""
if __name__ == '__main__':
    dset = TRAIN_PATH
    # dset = QUESTION_PATH

    x = load_train( dset )
    header =  x[0]

    print_list = []
    print_list.append( header )

    # FROZEN FOODS
    # -----------------------------------------------------------------
    # Uncomment this section to print a CSV only with the frozen food categories
    for i in x[1:]:
        if i == '':
            pass
        elif "Frozen" in i or "Frzn" in i:
            print_list.append( i )
        else:
            pass
    # -----------------------------------------------------------------


    # NONFROZEN
    # -----------------------------------------------------------------
    # Uncomment this section to print a CSV only with the non-frozen food categories
    # for i in x[1:]:
    #     if i == '':
    #         pass
    #     elif "Frozen" in i or "Frzn" in i:
    #         pass
    #     else:
    #         print_list.append( i )
    # -----------------------------------------------------------------
    


    print '\r'.join( print_list )

        
    
    
