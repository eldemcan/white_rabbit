/**
 * Webpack configuration used to compile engine assets and save them for sprockets.
 */

const path = require("path");
const MiniCssExtractPlugin = require('mini-css-extract-plugin');


module.exports = {
  // entry: {
  //   bundle: "app/javascript/white_rabbit/index.js"
  // },

  mode: 'development',
  watch: true,
  watchOptions: {
    aggregateTimeout: 200,
    poll: 1000,
  },

  plugins: [new MiniCssExtractPlugin()],
  entry: {
    white_rabbit: path.resolve(
      __dirname,
      "app/javascript/white_rabbit/index.js"
    ),

    // white_rabbit_style: path.resolve(
    //   __dirname,
    //   "app/assets/stylesheets/admin.css"
    // ),
  },

  output: {
    filename: "[name].js",
    path: path.resolve(__dirname, "app/assets/javascripts"),
    // library: 'admin',
    // libraryTarget: 'umd',
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: [/node_modules/],
        use: [
          {
            loader: "babel-loader",
            options: {
              presets: [
                "@babel/preset-env",
                {
                  plugins: ["@babel/plugin-proposal-class-properties"],
                },
              ],
            },
          },
        ],
      },
      {
        test: /\.css$/i,
        use: [MiniCssExtractPlugin.loader, "css-loader"],
      },
    ],
  },
};
