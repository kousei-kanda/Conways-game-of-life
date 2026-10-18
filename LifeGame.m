% Initial setup
% Code for simulating Conway's Game of Life.

% Define the glider pattern
Gul = [0, 1, 0; 0, 0, 1; 1, 1, 1];
Gur = [0, 1, 0; 1, 0, 0; 1, 1, 1];
Gbl = [1, 1, 1; 0, 0, 1; 0, 1, 0];
Gbr = [1, 1, 1; 1, 0, 0; 0, 1, 0];

% Define the blinker pattern
B = [0, 1, 0; 0, 1 , 0; 0, 1, 0];

% Define the Pulsar pattern
P = [0,0,1,1,1,0,0,0,1,1,1,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0;
    1,0,0,0,0,1,0,1,0,0,0,0,1;
    1,0,0,0,0,1,0,1,0,0,0,0,1;
    1,0,0,0,0,1,0,1,0,0,0,0,1;
    0,0,1,1,1,0,0,0,1,1,1,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,1,1,1,0,0,0,1,1,1,0,0;
    1,0,0,0,0,1,0,1,0,0,0,0,1;
    1,0,0,0,0,1,0,1,0,0,0,0,1;
    1,0,0,0,0,1,0,1,0,0,0,0,1;
    0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,1,1,1,0,0,0,1,1,1,0,0];

% Grid size
gridSize = 100;

% Initialize the map
map = zeros(gridSize, gridSize);
map(5:7, 5:7) = Gul;
map(gridSize-7:gridSize-5, gridSize-7:gridSize-5) = Gbr;
map(gridSize-7:gridSize-5, 5:7) = Gbl;
map(5:7, gridSize-7:gridSize-5) = Gur;
% map(10:12, 10:12) = B;
map(20:32, 20:32) = P;
map(gridSize-32:gridSize-20, gridSize-32:gridSize-20) = P;
map(20:32, gridSize-32:gridSize-20) = P;
map(gridSize-32:gridSize-20, 20:32) = P;

% Store the number of living neighbors
ncells = zeros(gridSize, gridSize);

% Number of time steps
timeframe = 1000;  % Adjust as needed

% Simulation loop
for t = 1:timeframe
    % Visualize the map
    spy(map);
    drawnow;
    
    % Pause for visualization observation
    pause(0.01);  % Adjust as needed
    
    % Calculate the number of living neighbors
    for i = 1:gridSize
        for j = 1:gridSize
            % Calculate the number of living neighbors
            if (i ~= 0 || j ~= 0) && ...   % Not itself
                        i - 1 >= 1 && i + 1 <= gridSize && ... % x-coordinate is within range
                        j - 1 >= 1 && j + 1 <= gridSize    % y-coordinate is within range

            ncells(i, j) = ...
                map(i-1, j-1) + map(i, j-1) + map(i+1, j-1) + ...
                map(i-1, j) + map(i+1, j) + ...
                map(i-1, j+1) + map(i, j+1) + map(i+1, j+1);
             end
        end
    end
    
    % Update the map based on Conway's Game of Life rules
    for i = 1:gridSize
        for j = 1:gridSize
            if map(i, j) == 1  % Cell is alive
                if ncells(i, j) < 2 || ncells(i, j) > 3
                    map(i, j) = 0;  % Cell dies
                end
            else  % Cell is dead
                if ncells(i, j) == 3
                    map(i, j) = 1;  % Cell is born
                end
            end
        end
    end
end