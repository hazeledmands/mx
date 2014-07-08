var test = require('tap').test;
var harness = require('../harness');
var path = require('path');

test('creating a new session from a path', function(t) {
  t.plan(5);
  harness('conf', function(err, stdout, stderr) {
    var output = stdout.trim().split('\n');
    t.equal(err, null, 'mx should properly run');
    t.equal(stderr, '', 'mx should not output anything on stderr');
    t.equal(output.length, 2, 'mx should invoke tmux 5 times');

    t.equal(output[0],
      'Gotcha!',
      'mx should run the conf file'
    );

    t.equal(output[1],
      'conf> tmux -2 switch-client -t conf',
      'mx should tell tmux to open the newly created client'
    );

  });
});
