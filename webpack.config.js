/**
 * Webpack configuration used to compile engine assets and save them for sprockets.
 */

const path = require('path');

module.exports = {
  entry: {
    white_rabbit: path.resolve(__dirname, 'app/javascript/white_rabbit/admin.jsx'),
  },

  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'app/assets/javascripts'),
    // library: 'admin',
    // libraryTarget: 'umd',
  },

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['react']
          }
        }
      }
    ]
  },
  resolve: {
    extensions: ['*', '.js', '.jsx'],
  },
};