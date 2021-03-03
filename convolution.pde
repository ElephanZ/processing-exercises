float n3 = 1/9.0;
float[][] nbox3 = {{n3, n3, n3},
                  {n3, n3, n3},    
                  {n3, n3, n3}};

float n5 = 1.0/25;              
float[][] nbox5 = {{n5, n5, n5, n5, n5},
                  {n5, n5, n5, n5, n5},
                  {n5, n5, n5, n5, n5},
                  {n5, n5, n5, n5, n5},
                  {n5, n5, n5, n5, n5}};
                 
float[][] laplaciano = {{-1, 0, -1},
                       {0, 4, 0},
                       {-1, 0, -1}};
                 
float[][] sobelX = {{-1, -2, -1},
                   {0, 0, 0},
                   {1, 2, 1}};
                 
float[][] sobelY = {{-1, 0, -1},
                   {-2, 0, 2},
                   {-1, 0, 1}};           
                 
float[][] prewittX = {{-1, -1, -1},
                     {0, 0, 0},
                     {1, 1, 1}};   
                 
float[][] prewittY = {{-1, 0, 1},
                     {-1, 0, 1},
                     {-1, 0, 1}};                    

float[][] sharpening = {{-1, 0, -1},
                       {0, 5, 0},
                       {-1, 0, -1}};

PImage convert(float[][] newMatrix)
{
  PImage res = createImage(newMatrix[0].length, newMatrix.length, RGB);
  float col = 0;
  
  for(int x = 0; x < res.width; x++) {
    for(int y = 0; y < res.height; y++) {
      col = constrain(abs(newMatrix[y][x]), 0, 255);
      res.set(x, y, color(col));
    }
  }
  
  return res;
}

PImage convolution(PImage I, float[][] K)
{
  float[][] res = new float[I.height][I.width];
  int N = K[0].length, M = K.length;
  
  for(int x = 0; x < I.width; x++) {
    for(int y = 0; y < I.height; y++) {
    
      PImage tmp = I.get(x-N/2, y-M/2, N, M);
      float sum = 0;
      
      for(int p = 0; p < N; p++)
        for(int q = 0; q < M; q++)
          sum += green(tmp.get(p, q)) * K[q][p];
      
      res[y][x] = sum;     
      
    }
  }
  
  return convert(res);
}
