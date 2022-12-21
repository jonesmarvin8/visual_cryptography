//Implementation of Floyd-Steinberg dithering.
public class Floyd_Steinberg
{
   PImage dithered_image;
   Boolean dither_ready;
   
   public Floyd_Steinberg(PImage o_t)
   {
     dither_ready = false;
     dithered_image = o_t;
   }

  private void luminosity()
  //Converts an image to black and white (no grey scale).
  {
    int temp_color;
    
    for(int x = 0; x < dithered_image.width; x++)
     {
       for(int y = 0; y < dithered_image.height; y++)
       {
          temp_color = (int) (red(dithered_image.get(x, y)) + 
                              blue(dithered_image.get(x, y)) +
                              green(dithered_image.get(x, y)))/3;
          dithered_image.set(x, y, color(temp_color, temp_color, temp_color));
       }
     }
   }
   
   private void dithering()
   {
      int temp_color;
      int temp_error;
   
      luminosity();
      
      for(int x = 0; x < dithered_image.width; x++)
      {
         for(int y = 0; y < dithered_image.height; y++)
         {
           if(red(dithered_image.get(x, y)) > 128)
           { temp_color = 255; }
           else{ temp_color = 0; }
            
           temp_error = (int) red(dithered_image.get(x,y)) - temp_color;
           dithered_image.set(x+1, y,
                              color(red(dithered_image.get(x+1, y)) + temp_error*7/16,
                              green(dithered_image.get(x+1, y)) + temp_error*7/16,
                              blue(dithered_image.get(x+1, y)) + temp_error*7/16));
           dithered_image.set(x-1, y+1, 
                              color(red(dithered_image.get(x-1, y+1)) + temp_error*3/16,
                              green(dithered_image.get(x+1, y)) + temp_error*3/16,
                              blue(dithered_image.get(x+1, y)) + temp_error*3/16));
           dithered_image.set(x, y+1,
                              color(red(dithered_image.get(x, y+1)) + temp_error*5/16,
                              green(dithered_image.get(x+1, y)) + temp_error*5/16,
                              blue(dithered_image.get(x+1, y)) + temp_error*5/16));
           dithered_image.set(x+1, y+1,
                              color(red(dithered_image.get(x+1, y+1)) + temp_error*1/16,
                              green(dithered_image.get(x+1, y)) + temp_error*1/16,
                              blue(dithered_image.get(x+1, y)) + temp_error*1/16));

           //dithered_image.set(x, y, color(temp_color, temp_color, temp_color));
         }
       }
       
       for(int x = 0; x < dithered_image.width; x++)
       {
         for(int y = 0; y < dithered_image.height; y++)
         {
           if( red(dithered_image.get(x, y)) > 128)
           { temp_color = 255; }
           else{ temp_color = 0; }
           
           dithered_image.set(x, y, color(temp_color, temp_color, temp_color));
         }
       }
       
       dither_ready = true;
   }
  
   public PImage get_dithered_image()
   {
     if( dither_ready == false)
     { dithering(); }
     
     return dithered_image;
   }
}
