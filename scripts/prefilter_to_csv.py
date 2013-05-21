RAW_DIR = '../data/'
TRAIN_SET = 'training.csv'
QUESTION_SET = 'test.csv'
TRAIN_PATH = RAW_DIR + TRAIN_SET

QUESTION_PATH = RAW_DIR + QUESTION_SET
#ACTIVE_DATASET = QUESTION_PATH
ACTIVE_DATASET = TRAIN_PATH
import sys
import pdb

def load_train():
    f = open( ACTIVE_DATASET, 'r' )
    x = f.read().split('\r')
    return x

def get_feature_list( x ):
    header = x[0][:]
    feature_list = header.split(',')
    return feature_list

"""
Script for creating a CSV amenable to manipulation in R
"""
if __name__ == '__main__':
    x = load_train()
    feature_list = get_feature_list( x )
    feature_dict = dict( [ ( feature_list.index( i ), i ) for i in feature_list ] )
    inverse_feature_dict = dict( [ ( i, feature_list.index( i ) ) for i in feature_list ] )
    
    
    raw_data_list = [ i.split(',') for i in x ]
    del raw_data_list[0]

    # NONFROZEN
    for i in x:
        if i == '':
            pass
        elif "Frozen" in i or "Frzn" in i:
            pass
        else:
            k = i.split(',')
            print ",".join( [ k[1], k[0] ] + k[2:] )


    sys.exit()
    #pdb.set_trace()


    typed_data_list = []
    for i in raw_data_list:
        processed_row = []
        for idx, j in enumerate( i ):

            if idx == 1:
                processed_row.append( j )
            else:
                if j == '':
                    processed_row.append( int( 0 ) )
                else:
                    processed_row.append( int( j ) )

        typed_data_list.append( processed_row[:] )


        
    product_ids = set( [ i[0] for i in typed_data_list ] )

    product_ids_list = sorted( list( product_ids ) )
    

    product_sales_dict = {}
    for p in product_ids_list:
        product_sales_dict[p] = [ None ] * 26
    for i in typed_data_list:
        product_sales_dict[ i[0] ][ i[2]-1 ] = i[4]

    product_stores_dict = {}
    for p in product_ids_list:
        product_stores_dict[p] = [ None ] * 26

    for i in typed_data_list:
        product_stores_dict[ i[0] ][ i[2]-1 ] = i[3]

    header = [ 'Product_Launch_Id' ]

    
    print ",".join( header + [ str(i) for i in range(1,27) ]  + [ 'stores13', 'stores26'] )

    for p in product_ids_list:
        print ",".join( [ str( p ) ] + [ str(i) for i in product_sales_dict[p] ] + [ str( product_stores_dict[p][12] ), str(product_stores_dict[p][25] ) ] )


    



        
    
    
