import java.util.List;
import java.util.Random;
import java.lang.*;
import java.util.BitSet;

public class Visual_Cryptography
{
  final static int DEFAULT_THRESHOLD = 2;
  final static int DEFAULT_TOTAL = 2;
  final static int THRESHOLD_2 = 2;
  final static int SHARE_TOTAL_2 = 2;
  final static int SHARE_TOTAL_3 = 3;
  final static int SHARE_TOTAL_6 = 6;
    
  Floyd_Steinberg fs_image;
  PImage original_image;
  
  int threshold_k,
      share_total;

  int[] subpixel_dim;
  
  VC_Share[] share_array;
  
  List<Integer> index_list,
                temp_list;
                
  Random rand;
  
  BitSet bits;
  
  public Visual_Cryptography(int select_t, PImage o_t)
  {
    fs_image = new Floyd_Steinberg(o_t);
    original_image = fs_image.get_dithered_image();
    
    index_list = new ArrayList<Integer>();
    temp_list = new ArrayList<Integer>();
   
    rand = new Random();

    set_k_out_of_n(select_t);
    generate_subpixel_size();
    init_share_array();
  }
  
  private void set_k_out_of_n(int select_t)
  {
    /*
    if(select_t == 0)
    {
      threshold_k = THRESHOLD_2;
      share_total = SHARE_TOTAL_2;
    }
    else if(select_t == 1)
    {
      threshold_k = THRESHOLD_2;
      share_total = SHARE_TOTAL_3;
    }
    else if(select_t == 2)
    {
      threshold_k = THRESHOLD_2;
      share_total = SHARE_TOTAL_3;
    }
    else
    {
      threshold_k = DEFAULT_THRESHOLD;
      share_total = DEFAULT_TOTAL;
    }*/
    threshold_k = THRESHOLD_2;
    share_total = SHARE_TOTAL_2;
  }

  //TODO: generalize when code is generalized for any k out of n.
  private void generate_subpixel_size()
  {
    subpixel_dim = new int[2];
    
    subpixel_dim[0] = 2;
    subpixel_dim[1] = 2;
  }
  
  private void init_share_array()
  {
    share_array = new VC_Share[share_total];
    
    for(int i = 0; i < share_total; i++)
    {
      share_array[i] = new VC_Share(new int[] {original_image.width, original_image.height},
                                    subpixel_dim, i);
    }
    
    for(int x = 0; x < original_image.width; x++)
    {
      for(int y = 0; y < original_image.height; y++)
      {
        set_subpixels(x, y, original_image.get(x,y));
      }
    }
  }
  
  private void set_subpixels(int x_t, int y_t, color c_t)
  {
    int temp_rand;
    
    //Temp for 2 out of 2 preferred version
    index_list.add(3);
    index_list.add(5);
    index_list.add(6);
    index_list.add(9);
    index_list.add(10);
    index_list.add(12);
    
    temp_rand = index_list.get(rand.nextInt(index_list.size()));
    
    bits = convert_int_bitset(temp_rand);
    
    //To generalize: This is only for (preferred) 2 out of 2.
    if(red(c_t) == 0){
      share_array[0].set_x_y_subpixels(x_t, y_t, bits);
      bits = convert_int_bitset(15-temp_rand);
      
      share_array[1].set_x_y_subpixels(x_t, y_t, bits);
    }
    else{
      share_array[0].set_x_y_subpixels(x_t, y_t, bits);
      share_array[1].set_x_y_subpixels(x_t, y_t, bits);
    }
    
    index_list.clear();
  }
  
  private BitSet convert_int_bitset(int val_t)
  {
    BitSet bits = new BitSet(); 
    int len = 1;
    int val = val_t;
    
    bits.set(0);
    bits.set(3);
    
    
    while(val != 0)
    {
      if(val%2 == 1){
        bits.set(0);
        val -= val;
      }
      else if(val % pow(2,len) != 0)
      {
        bits.set(len-1);
        val -= (int) pow(2,len-1);
        len = 1;
      }
      else{
        len++;  
      }
    }
    
    return bits;
  }
  
  public void display(int x_t, int y_t)
  { 
    share_array[0].display(100, 100);
    share_array[1].display(x_t, y_t);
  }
}
