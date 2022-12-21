import java.util.BitSet;

public class VC_Share
{
  static final int DIMENSION_SIZE = 2;
  
  int alpha;
  
  int[] image_dim;
  int[] subpixel_dim;

  PImage share_image;
  
  Boolean ready; //TODO: delete?
   
  public VC_Share(int[] image_dim_t, int[] subpixel_dim_t, int alpha_t)
  {
    ready = false;
    alpha = 255 - alpha_t*200;
    image_dim = image_dim_t;
    subpixel_dim = subpixel_dim_t;

    share_image = new PImage(image_dim[0]*subpixel_dim[0], image_dim[1]*subpixel_dim[1], ARGB);
  }
  
  public void set_x_y_subpixels(int x, int y, BitSet subpixel_t)
  {
    int adj_x = x*subpixel_dim[0];
    int adj_y = y*subpixel_dim[1];

      for(int i = 0; i < subpixel_dim[0]*subpixel_dim[1]; i++)
      {
        //System.out.println("x : " + adj_x + i%subpixel_dim[0] + " y : " + adj_y + (int) (i-i%subpixel_dim[0])/subpixel_dim[0]);
        if(subpixel_t.get(i) && red(share_image.get(adj_x + i%subpixel_dim[0], adj_y + (int) (i-i%subpixel_dim[0])/subpixel_dim[0])) == 0)
        { }//System.out.println("Hello "  + adj_x + i%subpixel_dim[0] + " y : " + adj_y + (int) (i-i%subpixel_dim[0])/subpixel_dim[0]); }
        
        if(subpixel_t.get(i))
        { share_image.set(adj_x + i%subpixel_dim[0], adj_y + (int) (i-i%subpixel_dim[0])/subpixel_dim[0], color(0,0,0, 255)); }
        else{ share_image.set(adj_x + i%subpixel_dim[0], adj_y + (int) (i-i%subpixel_dim[0])/subpixel_dim[0], color(255,255,255, alpha)); }
      }
    
    ready = true;
    //return true;
  }
  
  public void display(int x_t, int y_t)
  {
    if(ready)
    { image(share_image, x_t, y_t); }
  }
  
}
