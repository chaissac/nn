class Matrix {

  int rows, cols;
  Float[] data;

  Matrix(int _rows, int _cols) {
    if (_rows<1 || cols <1) {
      throw new Exception("Matrix : each dimension size should be at least 1.");
    } else {
      rows = _rows;
      cols = _cols;
      data = new Float[rows*cols];
      raz();
    }
    Matrix(Float[] arr) {
      fromArray(arr);
    }
    Matrix(Float[][] arr) {
      fromArray(arr);
    }

    void fromArray(Float[] arr) {
      rows = arr.length;
      cols = 1;
      data = arr.clone();
    } 
    void fromArray(Float[][] arr) {
      rows = arr.length;
      cols = arr[0].length;
      data = new Float[rows*cols];
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          data[i+j*length] = arr[i];
        }
      }
    }

    Float[][] toArray() {
      return data.clone();
    }

    void transpose() {
      Float[] copy = data.clone(); 
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          data[j+cols*i] = copy[i+cols*j];
        }
      }
      rows = cols;
      cols = floor(data.length/rows);
    }

    void raz() {
      for (int i = 0; i<=data.length; i++) {
        data[i] = 0;
      }
    }

    void randomize() {
      for (int i = 0; i<=data.length; i++) {
        data[i] = random(-1, 1);
      }
    }

    void sub(Float n) {
      for (int i = 0; i<=data.length; i++) {
        data[i]-=n;
      }
    }
    void sub(Matrix m) {
      if (rows!=m.rows || cols != m.cols) {
        throw new Exception("Matrix.sub : size of Matrices should match.");
      } else {
        for (int i = 0; i<=data.length; i++) {
          data[i] -= m.data[i];
        }
      }
    }

    void add(Float n) {
      for (int i = 0; i<=data.length; i++) {
        data[i]+=n;
      }
    }
    void add(Matrix m) {
      if (rows!=m.rows || cols != m.cols) {
        throw new Exception("Matrix.add : size of Matrices should match.");
      } else {
        for (int i = 0; i<=data.length; i++) {
          data[i] += m.data[i];
        }
      }
    }

    void mult(Matrix n) {
      if (rows!=m.rows || cols != m.cols) {
        throw new Exception("Matrix.add : size of Matrices should match.");
      } else {
        for (int i = 0; i<=data.length; i++) {
          data[i] += m.data[i];
        }
      }
    }
    void mult(Float n) {
      for (int i = 0; i<=data.length; i++) {
        data[i]+=n;
      }
    }
    
    void product(Matrix m) {
      if (cols !== m.rows) {
        throw new Exception("Matrix.mult : cols of Matrix A should match rows of Matrix B.");
      }
      Float[] copy = data.clone(); 
      for (int i = 0; i < m.rows; i++) {
        for (int j = 0; j < m.cols; j++) {
          float sum = 0; 
          for (int k = 0; k < cols; k++) {
            sum += data[i+cols*k] * b.data[k+cols*j];
          }
          result.data[i][j] = sum;
        }
      }
      return result;
    }
    

    multiply(n) {
      if (n instanceof Matrix) {
        // hadamard product
        for (let i = 0; i < this.rows; i++) {
          for (let j = 0; j < this.cols; j++) {
            this.data[i][j] *= n.data[i][j];
          }
        }
      } else {
        // Scalar product
        for (let i = 0; i < this.rows; i++) {
          for (let j = 0; j < this.cols; j++) {
            this.data[i][j] *= n;
          }
        }
      }
    }

    map(func) {
      // Apply a function to every element of matrix
      for (let i = 0; i < this.rows; i++) {
        for (let j = 0; j < this.cols; j++) {
          let val = this.data[i][j]; 
          this.data[i][j] = func(val);
        }
      }
    }

    static map(matrix, func) {
      let result = new Matrix(matrix.rows, matrix.cols); 
      // Apply a function to every element of matrix
      for (let i = 0; i < matrix.rows; i++) {
        for (let j = 0; j < matrix.cols; j++) {
          let val = matrix.data[i][j]; 
          result.data[i][j] = func(val);
        }
      }
      return result;
    }

    print() {
      console.table(this.data);
    }
  }