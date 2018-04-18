class NeuralNetwork {
  int inputNodes, hiddenNodes, outputNodes ;
  PMatrix weightsIH, weightsHO, biasH, biasO ;
  double learningRate ;
  String activationFunction ;

  NeuralNetwork(int input, int hidden, int output) {

    inputNodes = input ;
    hiddenNodes = hidden ;
    outputNodes = output ;

    weightsIH = new PMatrix(hiddenNodes, inputNodes);
    weightsHO = new PMatrix(outputNodes, hiddenNodes);
    weightsIH.randomize();
    weightsHO.randomize();

    biasH = new PMatrix(hiddenNodes, 1);
    biasO = new PMatrix(outputNodes, 1);
    biasH.randomize();
    biasO.randomize();

    learningRate = 0.5;
    activationFunction = "sigmoid";
  }

  NeuralNetwork(NeuralNetwork n) {

    inputNodes = n.inputNodes ;
    hiddenNodes = n.hiddenNodes ;
    outputNodes = n.outputNodes ;

    weightsIH = n.weightsIH.clone();
    weightsHO = n.weightsHO.clone();

    biasH = n.biasH.clone();
    biasO = n.biasO.clone();

    learningRate = n.learningRate;
    activationFunction = n.activationFunction;
  }
  void setLearningRate(Double l) {
    learningRate = learningRate;
  }

  void setActivationFunction(String func) {
    activationFunction = func;
  }  

  Double[] predict(Double[] inputArray) {

    // Generating the Hidden Outputs
    PMatrix inputs = new PMatrix(inputArray);
    PMatrix hidden = weightsIH.clone();
    hidden.product(inputs);
    hidden.add(biasH);
    // activation function!
    hidden.map(activationFunction);

    // Generating the output's output!
    PMatrix output = weightsHO.clone() ;
    output.product(hidden);
    output.add(biasO);
    output.map(activationFunction);

    // Sending back to the caller!
    return output.toArray();
  }

  void train(Double[] inputArray, Double[] targetArray) {
    // Generating the Hidden Outputs
    PMatrix inputs = new PMatrix(inputArray);
    PMatrix hidden = weightsIH.clone();
    hidden.product(inputs);
    hidden.add(biasH);
    // activation function!
    hidden.map(activationFunction);

    // Generating the output's output!
    PMatrix outputs = weightsHO.clone() ;
    outputs.product(hidden);
    outputs.add(biasO);
    outputs.map(activationFunction);

    // Convert array to matrix object
    PMatrix targets = new PMatrix(targetArray);

    // Calculate the error
    // ERROR = TARGETS - OUTPUTS
    PMatrix outputErrors = targets.clone();
    outputErrors.sub(outputs);

    // let gradient = outputs * (1 - outputs);
    // Calculate gradient
    PMatrix gradient = outputs.clone();
    gradient.map("d"+activationFunction);
    gradient.mult(outputErrors);
    gradient.mult(learningRate);

    // Calculate deltas
    PMatrix hiddenT = hidden.clone();
    hiddenT.transpose();
    PMatrix weightHODeltas = gradient.clone();
    weightHODeltas.product(hiddenT);

    // Adjust the weights by deltas
    weightsHO.add(weightHODeltas);
    // Adjust the bias by its deltas (which is just the gradients)
    biasO.add(gradient);

    // Calculate the hidden layer errors
    PMatrix hiddenErrors = weightsHO.clone();
    hiddenErrors.transpose();
    hiddenErrors.product(outputErrors);

    // Calculate hidden gradient
    PMatrix hiddenGradient = hidden.clone();
    hiddenGradient.map("d"+activationFunction);
    hiddenGradient.mult(hiddenErrors);
    hiddenGradient.mult(learningRate);

    // Calculate input->hidden deltas
    PMatrix inputsT = inputs.clone();
    inputsT.transpose();
    PMatrix weightIHDeltas = hiddenGradient.clone();
    weightIHDeltas.product(inputsT);

    // Adjust the weights by deltas
    weightsIH.add(weightIHDeltas);
    // Adjust the bias by its deltas (which is just the gradients)
    biasH.add(hiddenGradient);
  }
}