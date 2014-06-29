var path = require('path');
var STUBS = path.join(__dirname, 'stubs');
var MX = path.join(__dirname, '..', 'bin', 'mx');
var CWD = path.join(__dirname, '..');
var exec = require('child_process').exec;

var env = {}
Object.keys(process.env).forEach(function(key) {
  env[key] = process.env[key];
});
env.PATH = STUBS + ":" + process.env.PATH;
env.EDITOR = '/usr/bin/nano'
env.PROJECTS = path.join(__dirname, 'mocks', 'projects')

module.exports = function(args, cb) {
  exec(MX + " " + args, {env: env, cwd: CWD}, cb);
};
