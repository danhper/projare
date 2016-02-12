var webpack           = require('webpack')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var nib               = require('nib')
var path              = require('path')

module.exports = {
  entry: {
    app: './web/static/js/app.js',
    vendor: ['riot', 'immutable']
  },
  output: {
    path: './priv/static/js',
    filename: '[name].js'
  },
  devtool: 'source-map',
  module: {
    loaders: [
      {test: /\.json$/, loader: 'json'},
      {test: /\.js$/, loader: 'babel?presets[]=es2015', include: /web\/static\/js/},
      {test: /\.jade$/, loader: 'jade'},
      {test: /\.styl$/, loader: ExtractTextPlugin.extract('style-loader', 'css!stylus')},
      {test: /\.css$/, loader: ExtractTextPlugin.extract('style-loader', 'css-loader')},
      {test: /\.(png|woff|woff2|eot|ttf|svg|gif)/, loader: 'url-loader?limit=10000'},
      {test: /\.jpg/, loader: 'file-loader'}
    ]
  },
  resolve: {
    alias: {
      'utils': path.join(__dirname, './web/static/js/utils'),
      'services': path.join(__dirname, './web/static/js/services')
    }
  },
  externals: {
    'jquery': '$'
  },
  plugins: [
    new ExtractTextPlugin('[name].css', {allChunks: true})
  ],
  stylus: {
    use: [nib()]
  }
}
