function [T]=Kmeans(img)
%% K-means Segmentation (option: K Number of Segments)

%% initialize

%% Load Image
img=medfilt2(img);
img=medfilt2(img);
vector = reshape(img,size(img,1)*size(img,2),1);

%% K-means
% Numarul clusterilor/grupurilor
K = 5;
% centrii cluster
centers = vector( ceil(rand(K,1)*size(vector,1)) ,:);
% distanta si eticheta
dal = zeros(size(vector,1),K+2);
% numar iteratii K-means
kmi = 10;
for n = 1:kmi
    for i = 1:size(vector,1)
        for j = 1:K
            dal(i,j) = norm(vector(i,:) - centers(j,:));
        end
        [distmin, cn] = min(dal(i,1:K));    % 1:K reprezinta distanta de la centrii cluster 1:K
        dal(i,K+1) = cn;                    % K+1 este eticheta cluster
        dal(i,K+2) = distmin;                % K+2 este distanta minima
    end
    
    for i = 1:K
        puncte = (dal(:,K+1) == i);                     % Cluster K puncte
        centers(i,:) = mean(vector(puncte,:));
        if sum(isnan(centers(:))) ~= 0     % daca centers(i,:) sunt NaN atunci inlcouieste cu o valoare random
            nr_new_cluster = find(isnan(centers(:,1)) == 1);     % gasteste NaN centers
            for indice = 1:size(nr_new_cluster,1)
                %generarea random de noi clusteri
                centers(nr_new_cluster(indice),:) = vector(randi(size(vector,1)),:);
            end
        end
    end
end

X = zeros(size(vector));
for i = 1:K
    idx = find(dal(:,K+1) == i);
    X(idx,:) = repmat(centers(i,:),size(idx,1),1);
end
T = reshape(X,size(img,1),size(img,2));
end
