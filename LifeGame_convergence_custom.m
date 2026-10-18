size = 100;

% Initialize the map (random cell states)
init_rate = 0.05;  % Probability of generating a live cell during initialization
map = rand(size);  % Initialize with random values

% Determine cell life based on the initialized map
for x = 1:size
    for y = 1:size
        if map(x, y) < init_rate
            map(x, y) = 1;
        else
            map(x, y) = 0;
        end
    end
end

% Save the number of surviving neighboring cells
ncells = zeros(size);

% Number of time steps
timeframe = 2000;  

% Variables for recording data for plotting
nz_count_history = zeros(1, timeframe);

% Simulation loop
for t = 1:timeframe
    % Visualize the map
    spy(map);
    drawnow;
    
    % Pause to observe visualization
    pause(0.15);  
    
    % Count and record cells with value 1
    nz_count = nnz(map);
    nz_count_history(t) = nz_count;
    
    % Calculate the number of surviving neighboring cells
    for i = 1:size
        for j = 1:size
            % Calculate the number of surviving neighboring cells
            if (i ~= 0 || j ~= 0) && ...   % Not itself
               i - 1 >= 1 && i + 1 <= size && ... % Within x-coordinate range
               j - 1 >= 1 && j + 1 <= size    % Within y-coordinate range

                ncells(i, j) = ...
                    map(i-1, j-1) + map(i, j-1) + map(i+1, j-1) + ...
                    map(i-1, j) + map(i+1, j) + ...
                    map(i-1, j+1) + map(i, j+1) + map(i+1, j+1);
            end
        end
    end
    
    % Update the map based on the new rules
    for i = 1:size
        for j = 1:size
            if map(i, j) == 1  % Cell is alive
                if ncells(i, j) >= 2 && ncells(i, j) <= 5
                    map(i, j) = 1;  % Cell survives
                else
                    map(i, j) = 0;  % Cell dies
                end
            else  % Cell is dead
                if ncells(i, j) >= 3 && ncells(i, j) <= 6
                    map(i, j) = 1;  % Cell is born
                end
            end
        end
    end
end

% Plot the change in the number of non-zero elements over time
figure;
plot(1:timeframe, nz_count_history, 'b');
xlabel('Time Step');
ylabel('Number of Non-Zero Elements');
title('Number of Non-Zero Elements in the Matrix Over Time');
