const { join } = require('path')

const CleanWebpackPlugin = require('clean-webpack-plugin')
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')

const isProduction = process.env.NODE_ENV === 'production'
const src = join(__dirname, 'src')

module.exports = (env = {}) => {
  return {
    mode: isProduction ? 'production' : 'development',
    entry: join(__dirname, 'src/main.js'),
    output: {
      filename: 'js/[name].[chunkhash].js',
      chunkFilename: 'js/[id].[chunkhash].js'
    },
    resolve: {
      extensions: ['.js', '.vue', '.json'],
      alias: {
        '@': src
      }
    },
    module: {
      rules: [
        { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader' },
        { test: /\.vue$/, exclude: /node_modules/, loader: 'vue-loader' }
      ]
    },
    plugins: [
      ...(env.singleRun ? [
        new CleanWebpackPlugin(['dist'])
      ] : []),
      new VueLoaderPlugin(),
      new HtmlWebpackPlugin({ template: './src/index.html' })
    ]
  }
}
