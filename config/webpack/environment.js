const { environment } = require('@rails/webpacker');

// Get the sass-loader config
const sassLoader = environment.loaders.get('sass');
const sassLoaderConfig = sassLoader.use.find(function (element) {
  return element.loader == 'sass-loader';
});

// Use dart-sass
const options = sassLoaderConfig.options;
options.implementation = require('sass');

// Use the glob loader
const globCssImporter = require('node-sass-glob-importer');
sassLoader.use.find(item => item.loader === 'sass-loader').options.sassOptions = {
  importer: globCssImporter()
};

module.exports = environment;
