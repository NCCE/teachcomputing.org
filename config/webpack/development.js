process.env.NODE_ENV = process.env.NODE_ENV || 'development'
const environment = require('./environment');

const SpeedMeasurePlugin = require('speed-measure-webpack-plugin');
const smp = new SpeedMeasurePlugin();

config = environment.toWebpackConfig();
config.devtool = 'sourcemap'

module.exports = smp.wrap(config);
