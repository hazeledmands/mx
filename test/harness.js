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
env.PROJECTS = path.join('test', 'mocks', 'projects')
env.TMUX = null

module.exports = function(opts, cb) {
  if(typeof opts === "string") {
    opts = {
      args: opts
    }
  }

  if(!opts.args) opts.args = ''
  if(!opts.cwd) opts.cwd = CWD

  exec(MX + " " + opts.args, {env: env, cwd: opts.cwd}, cb);
};
