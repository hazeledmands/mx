var test = require('tap').test;
var fs = require('fs');
var path = require('path');

var HARNESS = path.join(__dirname, '..', 'harness');
var SESSIONS = path.join(HARNESS, '.sessions');
var MX = path.join(__dirname, '..', '..', 'bin', 'mx');

var exec = require('child_process').exec;

var env = {}
Object.keys(process.env).forEach(function(key) {
  env[key] = process.env[key];
});
env.PATH = HARNESS + ":" + process.env.PATH;

test('mx session', function(t) {
  t.plan(4);
  fs.writeFileSync(SESSIONS, "taco_tuesday\n");
  exec(MX + " taco_tuesday", {env: env}, function(err, stdout, stderr) {
    var output = stdout.trim().split('\n');
    t.equal(err, null, 'mx should properly run');
    t.equal(stderr, '', 'mx should not output anything on stderr');
    t.equal(output.length, 1, 'mx should only invoke tmux once');
    t.equal(output[0], 'tmux -2 switch-client -t taco_tuesday', 'mx should tell tmux to switch to preexisting session');
  });
});
