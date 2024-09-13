const path = require("path");
const webpack = require("webpack");

module.exports = {
  mode: "development",  // on passe en mode dev
  devtool: "source-map",
  entry: {
    application: "./app/javascript/application.js"
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  resolve: {
    modules: [path.resolve(__dirname, 'app/javascript'), 'node_modules'],
  },
  watch: true,  // et on rajoute l'option watch
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
};
