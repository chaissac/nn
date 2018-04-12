class NeuralNetwork {
  int input, hidden, output ;
  Matrix weights_ih, weights_ho, bias_h, bias_o ;
  float learning_rate ;
  
  NeuralNetwork(int _input, int _hidden, int _output) {
    
    input = _input ;
    hidden = _hidden ;
    output = _output ;
    
    weights_ih = new Matrix(hidden, input);
    weights_ho = new Matrix(output, hidden);
    weights_ih.randomize();
    weights_ho.randomize();

    bias_h = new Matrix(this.hidden_nodes, 1);
    bias_o = new Matrix(this.output_nodes, 1);
    bias_h.randomize();
    bias_o.randomize();
    
    learning_rate = 0.1;
  }

  Float[] feedforward(Float[] inputArray) {

    inputs = Matrix.fromArray(input_array);
    hidden = Matrix.multiply(this.weights_ih, inputs);
    hidden.add(this.bias_h);

    hidden.map(sigmoid);
    output = Matrix.multiply(this.weights_ho, hidden);
    output.add(this.bias_o);
    output.map(sigmoid);

    // Sending back to the caller!
    return output.toArray();
  }
  /*
  train(input_array, target_array) {
   // Generating the Hidden Outputs
   let inputs = Matrix.fromArray(input_array);
   let hidden = Matrix.multiply(this.weights_ih, inputs);
   hidden.add(this.bias_h);
   // activation function!
   hidden.map(sigmoid);
   
   // Generating the output's output!
   let outputs = Matrix.multiply(this.weights_ho, hidden);
   outputs.add(this.bias_o);
   outputs.map(sigmoid);
   
   // Convert array to matrix object
   let targets = Matrix.fromArray(target_array);
   
   // Calculate the error
   // ERROR = TARGETS - OUTPUTS
   let output_errors = Matrix.subtract(targets, outputs);
   
   // let gradient = outputs * (1 - outputs);
   // Calculate gradient
   let gradients = Matrix.map(outputs, dsigmoid);
   gradients.multiply(output_errors);
   gradients.multiply(this.learning_rate);
   
   
   // Calculate deltas
   let hidden_T = Matrix.transpose(hidden);
   let weight_ho_deltas = Matrix.multiply(gradients, hidden_T);
   
   // Adjust the weights by deltas
   this.weights_ho.add(weight_ho_deltas);
   // Adjust the bias by its deltas (which is just the gradients)
   this.bias_o.add(gradients);
   
   // Calculate the hidden layer errors
   let who_t = Matrix.transpose(this.weights_ho);
   let hidden_errors = Matrix.multiply(who_t, output_errors);
   
   // Calculate hidden gradient
   let hidden_gradient = Matrix.map(hidden, dsigmoid);
   hidden_gradient.multiply(hidden_errors);
   hidden_gradient.multiply(this.learning_rate);
   
   // Calcuate input->hidden deltas
   let inputs_T = Matrix.transpose(inputs);
   let weight_ih_deltas = Matrix.multiply(hidden_gradient, inputs_T);
   
   this.weights_ih.add(weight_ih_deltas);
   // Adjust the bias by its deltas (which is just the gradients)
   this.bias_h.add(hidden_gradient);
   
   }
   */
}