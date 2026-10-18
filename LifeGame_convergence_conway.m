size = 100;

% マップの初期化（ランダムなセルの状態）
init_rate = 0.2;  % 初期化時に生きたセルが生成される確率
map = rand(size);  % ランダムな値で初期化

% 初期化したマップに基づいてセルの生死を決定
for x = 1:size
    for y = 1:size
        if map(x, y) < init_rate
            map(x, y) = 1;
        else
            map(x, y) = 0;
        end
    end
end

% 生存している隣接セルの数を保存する
ncells = zeros(size, size);

% タイムステップの数
timeframe = 10000;  

% プロットのためのデータ記録用変数
nz_count_history = zeros(1, timeframe);

% シミュレーションループ
for t = 1:timeframe
    % マップを可視化
    spy(map);
    drawnow;
    
    % 可視化を観察するために一時停止
    pause(0.001);  
    
    % 1を数えて記録
    nz_count = nnz(map);
    nz_count_history(t) = nz_count;
    
    % 生存している隣接セルの数を計算
    for i = 1:size
        for j = 1:size
            % 生存している隣接セルの数を計算
            if (i ~= 0 || j ~= 0) && ...   % 自分自身でない
               i - 1 >= 1 && i + 1 <= size && ... % x座標が範囲内
               j - 1 >= 1 && j + 1 <= size    % y座標が範囲内

                ncells(i, j) = ...
                    map(i-1, j-1) + map(i, j-1) + map(i+1, j-1) + ...
                    map(i-1, j) + map(i+1, j) + ...
                    map(i-1, j+1) + map(i, j+1) + map(i+1, j+1);
            end
        end
    end
    
    % Conway's Game of Lifeのルールに基づいてマップを更新
    for i = 1:size
        for j = 1:size
            if map(i, j) == 1  % セルが生きている
                if ncells(i, j) < 2 || ncells(i, j) > 3
                    map(i, j) = 0;  % セルが死ぬ
                end
            else  % セルが死んでいる
                if ncells(i, j) == 3
                    map(i, j) = 1;  % セルが生まれる
                end
            end
        end
    end
end

% 非ゼロ要素の数の変化をグラフで表示
figure;
plot(1:timeframe, nz_count_history, 'b');
xlabel('Time Step');
ylabel('Number of Non-Zero Elements');
title('Number of Non-Zero Elements in the Matrix Over Time');
