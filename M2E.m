function [ H, F, centroidF, log, ac,F1_value,Precision,Recall,indic,nmi_value,stop ] = M2E(X, K, label, options,Iter,seed )
viewNum = length(X);
H_ = [];
F_ = [];
H = cell(1, viewNum);
F = cell(1, viewNum);
log = 0;
ac = 0;
R=options.rank;
%% initialize basis and coefficient matrices
for i = 1:viewNum
    size_vec=[size(X{i}),R];
    [H{i}, F{i}] = M2E_initial(size_vec,H_, F_,seed);
    I=size_vec(1);
    U{i}=zeros(I,R);
    P{i}=H{i};
end
centroidF=randn(size(F{1},1),R);
optionsForPerViewNMF=options;
oldL=1e100;
%% star interation
j = 0;
stop=0;
while j <Iter
    j = j + 1;
    for i = 1:viewNum
        size_vec = [size(X{i}),R];
        optionsForPerViewNMF.alpha = options.alpha(i);
        [H{i}, P{i}, F{i}, U{i}] = M2E_ADMM(X{i}, H{i}, P{i}, F{i}, U{i}, size_vec, optionsForPerViewNMF, centroidF);
    end
    %% update the F*
    centroidF = options.alpha(1) * F{1};
    for i = 2:viewNum
        centroidF = centroidF + options.alpha(i) * F{i};
    end
        centroidF = centroidF / sum(options.alpha);
    %% calculate the objective function
    logL = 0;
    for i = 1:viewNum
        tmp1 = X{i} - tensor_create(H{i},H{i},F{i});
        tmp2 = F{i} - centroidF;
        logL = logL + norm_fro(tmp1)^2 + options.alpha(i) * norm(tmp2,'fro')^2;
%         fprintf('first %d\n', norm_fro(tmp1)^2);
%         fprintf('second %d \n', norm(tmp2,'fro')^2);
    end
    log(end+1) = logL;
    if (oldL<logL)
        break;
    end
    oldL=logL;
    logL;
end
if j<Iter 
    stop=1;
end
[ac,F1_value,Precision,Recall,indic,nmi_value] = printResult(centroidF, label, K, options.kmeans);
end

