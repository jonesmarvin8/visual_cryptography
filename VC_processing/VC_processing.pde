Floyd_Steinberg test;
PImage original_image;

Visual_Cryptography test2;

void setup()
{
  size(750,1000);
  
  original_image = new PImage();
  original_image = loadImage("bg.jpg");
  
  test2 = new Visual_Cryptography(0, original_image);
}

void draw()
{
  background(255);
  test2.display(mouseX, mouseY);
}
