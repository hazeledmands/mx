var test = require('tap').test;
var harness = require('../harness');
var path = require('path');

test('creating a new session with a config file', function(t) {
  t.plan(9);
  harness('conf', function(err, stdout, stderr) {
    var output = stdout.trim().split('\n');
    t.equal(err, null, 'mx should properly run');
    t.equal(stderr, '', 'mx should not output anything on stderr');
    t.equal(output.length, 6, 'mx should invoke tmux 6 times');

    t.equal(output[0],
      'mx> tmux -2 new-session -c test/mocks/projects/conf -s wahoo -n first -d',
      'mx should create a new session in the conf directory named wahoo with a window called first'
    );

    t.equal(output[1],
      'mx> tmux -2 send-keys -t wahoo:1 \'echo Wahoo!\' C-m',
      'mx should tell tmux to say "Wahoo!"'
    );

    t.equal(output[2],
      'mx> tmux -2 new-window -c test/mocks/projects/conf -n second -t wahoo',
      'mx should tell tmux to open a new window named "second"'
    );

    t.equal(output[3],
      'mx> tmux -2 send-keys -t wahoo:2 \'echo Heya.\' C-m',
      'mx should tell tmux to say "Heya."'
    );

    t.equal(output[4],
      'mx> tmux -2 select-window -t wahoo:1',
      'mx should select the first window'
    );

    t.equal(output[5],
      'mx> tmux -2 switch-client -t wahoo',
      'mx should tell tmux to open the newly created client'
    );

  });
});
