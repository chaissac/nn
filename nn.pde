NeuralNetwork nn;

void setup() {
  size(400, 400);
  nn = new NeuralNetwork(2, 4, 1);
}

void draw() {
  background(127);
  Double[] in = new Double[2];
  Double[] out = new Double[1];
  for (int i = 0; i < 10; i++) {
    in[0] = (double)((random(0,1)<.5)?0:1);
    in[1] = (double)((random(0,1)<.5)?0:1);
    out[0] = (double)((in[0]==in[1])?0:1.0);
    nn.train(in, out);
  }
  int resolution = 200;
  int cols = 2;
  int rows = 2;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * resolution;
      int y = j * resolution;
      Double[] input = {(double)i, (double)j };
      Double[] output = nn.predict(input);
      println(i+" ^ "+j+" = "+output[0]);
      fill((int)(output[0] * 255));
      noStroke();
      rect(x, y, resolution, resolution);
    }
  }

}