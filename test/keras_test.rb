require_relative "test_helper"

class KerasTest < Minitest::Test
  def test_sequential
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data
    x_train = x_train / 255.0
    x_test = x_test / 255.0

    model = Tf::Keras::Models::Sequential.new([
      Tf::Keras::Layers::Flatten.new(input_shape: [28, 28]),
      Tf::Keras::Layers::Dense.new(128, activation: "relu"),
      Tf::Keras::Layers::Dropout.new(0.2),
      Tf::Keras::Layers::Dense.new(10, activation: "softmax")
    ])

    model.compile(optimizer: "adam", loss: "sparse_categorical_crossentropy", metrics: ["accuracy"])

    skip

    model.fit(x_train, y_train, epochs: 5)
    model.evaluate(x_test, y_test)
  end
end