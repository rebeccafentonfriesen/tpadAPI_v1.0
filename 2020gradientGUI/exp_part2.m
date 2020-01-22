%% connect to tpad
%note: you don't have to run this command every time, so you might want to
%pull it out of this script and just run it from the command line? 
[port,dimensions] = connect2tpad();

%% choose the best texture from output of experiment part 1:
n = 7;      %let's say 7th was best
textureBest = texture(n,:); %you'll need output from part 1 for this line
textureLast  = texture(7,:); 

%% create a matrix of 20 iterations of this texture:

%10 iterations of increasing to the right, and 10 to the left:
textureRightBest = repmat(textureBest,[10,1]);
textureLeftBest  = repmat(fliplr(textureBest),[10,1]);

%10 iterations of increasing to the right, and 10 to the left:
textureRightLast = repmat(textureLast,[10,1]);
textureLeftLast  = repmat(fliplr(textureLast),[10,1]);
 
%combine into one big matrix of 20 iterations:
textureAll = [textureRightBest;textureLeftBest;...
              textureRightLast;textureLeftLast;];

%% create randomized order of presentation:
order = randperm(40);

%% cycle through all 40 iterations and ask for subject input:

prompt = 'Is the gradient increasing left (1) or right (2)?';
answers = zeros(length(order),1); %empty array for answers

for i = 1:40
    %load a texture onto the tpad
    current_texture = 2^15*textureAll(order(i),:);
    [~] = loadData(port,2^15,zeros(size(current_texture)),current_texture);
    
    %ask for input
    full_prompt = strcat('(trial_',num2str(i),') ',prompt);
    answers(order(i)) = input(full_prompt);
end

%% save data 
%I'm now saving the data already unscrambled, so you don't need to 
%unscramble the order of trials anymore. I left the randomized order in 
%the saved data just in case, but you shouldn't need to use it

c = clock;
filename = strcat(num2str(c(2:5)),'part2');
save(filename,'order','answers','n');










