var test = require('tap').test;
var harness = require('../harness');

test('opening a session in a $PROJECT directory with dots', function(t) {
  t.plan(8);
  harness("name.with.dots", function(err, stdout, stderr) {
    var output = stdout.trim().split('\n');
    t.equal(err, null, 'mx should properly run');
    t.equal(stderr, '', 'mx should not output anything on stderr');
    t.equal(output.length, 5, 'mx should invoke tmux 5 times');
    t.equal(output[0], 'name.with.dots> tmux -2 new-session -s name_with_dots -n editor -d', 'mx should tell tmux to create a new session from the name.with.dots directory');
    t.equal(output[1], 'name.with.dots> tmux -2 send-keys -t name_with_dots /usr/bin/nano C-m', 'mx should tell tmux to open an editor');
    t.equal(output[2], 'name.with.dots> tmux -2 new-window -n shell -t name_with_dots', 'mx should tell tmux to open a new window');
    t.equal(output[3], 'name.with.dots> tmux -2 select-window -t name_with_dots:1', 'mx should tell tmux to select the editor window');
    t.equal(output[4], 'name.with.dots> tmux -2 switch-client -t name_with_dots', 'mx should tell tmux to open the newly created client');
  });
});
