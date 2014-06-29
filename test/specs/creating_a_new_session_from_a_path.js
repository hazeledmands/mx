var test = require('tap').test;
var harness = require('../harness');
var path = require('path');
var SESSION = path.join(__dirname, '..', 'mocks', 'red_sofa_project');

test('creating a new session from a path', function(t) {
  t.plan(8);
  harness(SESSION, function(err, stdout, stderr) {
    var output = stdout.trim().split('\n');
    t.equal(err, null, 'mx should properly run');
    t.equal(stderr, '', 'mx should not output anything on stderr');
    t.equal(output.length, 5, 'mx should invoke tmux 5 times');
    t.equal(output[0], 'red_sofa_project> tmux -2 new-session -s red_sofa_project -n editor -d', 'mx should tell tmux to create a new session from the red_sofa_project directory');
    t.equal(output[1], 'red_sofa_project> tmux -2 send-keys -t red_sofa_project /usr/bin/nano C-m', 'mx should tell tmux to open an editor');
    t.equal(output[2], 'red_sofa_project> tmux -2 new-window -n shell -t red_sofa_project', 'mx should tell tmux to open a new window');
    t.equal(output[3], 'red_sofa_project> tmux -2 select-window -t red_sofa_project:1', 'mx should tell tmux to select the editor window');
    t.equal(output[4], 'red_sofa_project> tmux -2 switch-client -t red_sofa_project', 'mx should tell tmux to open the newly created client');
  });
});
