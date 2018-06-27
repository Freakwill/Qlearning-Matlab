% story: a robot with 10 power tries to find its heaven that is far from
% it. It has to get the resource first! Come bro! Here we go.

env = rl.MyGridEnv('maze', [6,7]);
env.axes=gca;
heaven = rl.Object('Heaven', env, [6;7], 'Marker', '+', 'Color', 'b');
resource = rl.Object('Resource', env,[3;5;100], 'Color', 'g', 'Marker', 'd');
hell = rl.Object('Hell', env, [5;2], 'Color', 'm', 'Marker', '*');
trap = rl.Object('Trap', env, [2;6], 'Color', 'r', 'Marker', 's');
% wall = rl.RectWall('wall', env, [5;4]);
% wall.size = [1,3];
env.objects=[resource, hell, heaven, trap];
env = env.init();
agent=rl.MyQAgent('Hello', env);
agent=agent.train();