var test = require('tap').test;
var harness = require('../harness');

test('switch to preexisting session', function(t) {
  t.plan(4);
  harness("taco_tuesday", function(err, stdout, stderr) {
    var output = stdout.trim().split('\n');

    t.equal(err, null, 'mx should properly run');

    t.equal(stderr, '', 'mx should not output anything on stderr');

    t.equal(output.length, 1, 'mx should only invoke tmux once');

    t.equal(output[0],
      'mx> tmux -2 switch-client -t taco_tuesday',
      'mx should tell tmux to switch to preexisting session'
    );

  });
});
