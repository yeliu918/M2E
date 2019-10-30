%% parameter setting
options = [];
options.error = 1e-6;
options.converg =0.0001;
options.method =2;
options.rho=5;
options.mu=10;
options.mu_max=10^6;
options.kmeans = 1;
options.alpha = [0.1 0.1];
options.kmeans = 1;
options.rank=10;


load demo_dataset.mat
options.rank=7;
index_1=10;
index_2=100;
options.alpha=[index_1,index_2];
seed = 7;
Iter=19;
for trial_num=5
    [H_final, F_final, F_centroid, log, ac,F1_value,Precision,Recall,indic,stop] = M2E(data, K, gnd, options, Iter, seed); 
    pos=size(find(indic==1),1);
    fprintf('Pos vs. Neg is %d vs. %d\n', mean(pos), 70-mean(pos));
end


