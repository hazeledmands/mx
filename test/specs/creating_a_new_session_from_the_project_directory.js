var test = require('tap').test;
var harness = require('../harness');

test('creating a new session from the $PROJECT directory', function(t) {
  t.plan(8);
  harness("rice_crispies", function(err, stdout, stderr) {
    var output = stdout.trim().split('\n');

    t.equal(err, null, 'mx should properly run');

    t.equal(stderr, '', 'mx should not output anything on stderr');

    t.equal(output.length, 5, 'mx should invoke tmux 5 times');

    t.equal(output[0],
      'mx> tmux -2 new-session -c test/mocks/projects/rice_crispies -s rice_crispies -n editor -d',
      'mx should tell tmux to create a new session from the rice_crispies directory'
    );

    t.equal(output[1],
      'mx> tmux -2 send-keys -t rice_crispies:1 /usr/bin/nano C-m',
      'mx should tell tmux to open an editor'
    );

    t.equal(output[2],
      'mx> tmux -2 new-window -c test/mocks/projects/rice_crispies -n shell -t rice_crispies',
      'mx should tell tmux to open a new window'
    );

    t.equal(output[3],
      'mx> tmux -2 select-window -t rice_crispies:1',
      'mx should tell tmux to select the editor window'
    );

    t.equal(output[4],
      'mx> tmux -2 switch-client -t rice_crispies',
      'mx should tell tmux to open the newly created client'
    );

  });
});
