const { environment } = require('@rails/webpacker');

// Get the sass-loader config
const sassLoader = environment.loaders.get('sass');
const sassLoaderConfig = sassLoader.use.find(function (element) {
  return element.loader == 'sass-loader';
});

// Use dart-sass
const options = sassLoaderConfig.options;
options.implementation = require('sass');

module.exports = environment;
