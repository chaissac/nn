class PMatrix {

  int rows, cols;
  Double[] data;

  PMatrix(int _rows, int _cols) {
    if (_rows<1 || _cols <1) {
      error("PMatrix(" + _rows+", " + _cols + ") : each dimension size should be at least 1.");
    } else {
      rows = _rows;
      cols = _cols;
      data = new Double[rows*cols];
      init(0);
    }
  }
  PMatrix(Double[] arr) {
    fromArray(arr);
  }
  PMatrix(Double[][] arr) {
    fromArray(arr);
  }
  void error(String e) {
    println(e);
    debug();
    System.exit(0);
  }
  void fromArray(Double[] arr) {
    rows = arr.length;
    cols = 1;
    data = arr.clone();
  } 
  void fromArray(Double[][] arr) {
    rows = arr.length;
    cols = arr[0].length;
    data = new Double[rows*cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[i*cols+j] = arr[i][j];
      }
    }
  }

  Double[] toArray() {
    return data.clone();
  }
  PMatrix clone() {
    PMatrix m = new PMatrix(rows, cols);
    m.data = data.clone();
    return m;
  }

  void transpose() {
    Double[] copy = data.clone(); 
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[j*rows+i] = copy[i*cols+j];
      }
    }
    rows = cols;
    cols = floor(data.length/rows);
  }

  void init(double n) {
    for (int i = 0; i<data.length; i++) {
      data[i] = n;
    }
  }

  void randomize() {
    for (int i = 0; i<data.length; i++) {
      data[i] = Math.random()*2-1;
    }
  }

  void sub(Double n) {
    for (int i = 0; i<data.length; i++) {
      data[i]-=n;
    }
  }
  void sub(PMatrix m) {
    if (rows!=m.rows || cols != m.cols) {
      error("Matrix.sub : size of Matrices should match.");
    } else {
      for (int i = 0; i<data.length; i++) {
        data[i] -= m.data[i];
      }
    }
  }

  void add(Double n) {
    for (int i = 0; i<data.length; i++) {
      data[i]+=n;
    }
  }
  void add(PMatrix m) {
    if (rows!=m.rows || cols != m.cols) {
      error("Matrix.add : size of Matrix A(" + rows + "," + cols + ") should match size of Matrix B(" +m.rows + "," + m.cols + ").");
    } else {
      for (int i = 0; i<data.length; i++) {
        data[i] += m.data[i];
      }
    }
  }

  void mult(PMatrix m) {
    if (rows!=m.rows || cols != m.cols) {
      error("Matrix.mult : size of Matrix A(" + rows + "," + cols + ") should match size of Matrix B(" +m.rows + "," + m.cols + ").");
    } else {
      for (int i = 0; i<data.length; i++) {
        data[i] *= m.data[i];
      }
    }
  }
  void mult(Double n) {
    for (int i = 0; i<data.length; i++) {
      data[i]+=n;
    }
  }

  void product(PMatrix m) {
    if (cols != m.rows) {
      error("Matrix.product : cols of Matrix A(" + rows + "," + cols + ") should match rows of Matrix B(" +m.rows + "," + m.cols + ").");
    }
    Double[] copy = new Double[rows*m.cols];
    double sum ;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < m.cols; j++) {
        sum = 0; 
        for (int k = 0; k < cols; k++) {
          sum += data[i*cols+k] * m.data[k*m.cols+j];
        }
        copy[i*m.cols+j] = sum;
      }
    }
    data = copy.clone();
    cols = m.cols;
  }

  void map(String func) {
    switch (func) {
    case "sigmoid" : 
      for (int i = 0; i<data.length; i++) data[i]=1/(1-Math.exp(-data[i])) ; 
      break;
    case "dsigmoid" : 
      for (int i = 0; i<data.length; i++) data[i]=data[i]*(1-data[i]); 
      break;
    case "tanh" : 
      for (int i = 0; i<data.length; i++) data[i]=(double)Math.tanh(data[i]) ; 
      break;
    case "dtanh" : 
      for (int i = 0; i<data.length; i++) data[i]=1-data[i]*data[i] ; 
      break;
    default:
      error("Unknown map");
    }
  }

  void debug() {
    println("Matrix "+rows+","+cols+" : ");
    printArray(data);
  }
}