process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment');
environment.config.merge({ devtool: 'source-map' });

const SpeedMeasurePlugin = require('speed-measure-webpack-plugin');
const smp = new SpeedMeasurePlugin();

config = environment.toWebpackConfig();

module.exports = smp.wrap(config);
