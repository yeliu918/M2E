function [ac,F1_value,Precision,Recall,indic,nmi_value] = printResult(X, label, K, kmeansFlag)
for i = 1:20
    if kmeansFlag == 1
        indic = litekmeans(X, K, 'Replicates',20);
        indic = bestMap(label, indic);
        result(i,:) = ClusteringMeasure(label, indic);
%         result_NMI(i) = nmi(label, indic);
        [result_F1(i),result_P(i),result_R(i)]=evaluate_F1_P_R(label, indic);
    else
        [~, indic] = max(X, [] ,2);
    end
end
        fprintf('Acc is %d (%d)\n', mean(result(:,1)), std(result(:,1)));
        fprintf('NMI is %d (%d)\n', mean(result(:,2)), std(result(:,2)));
        fprintf('F1 is %d (%d)\n', mean(result_F1), std(result_F1));
        fprintf('Precision is %d (%d)\n', mean(result_P), std(result_P));
        fprintf('Recall is %d (%d)\n', mean(result_R), std(result_R));
        
        ac=mean(result(:,1));
        nmi_value=mean(result(:,2));
        F1_value = mean(result_F1);
        Precision = mean(result_P);
        Recall = mean(result_R);
% disp(indic);
% disp(size(indic));
% sdisp('the accuracy is:',mean(indic==label));
% result = bestMap(label, indic);
% % disp(indic)
% [ac, nmi_value, cnt] = CalcMetrics(label, indic);
% disp(sprintf('ac: %0.4f\t%d/%d\tnmi:%0.4f\t', ac, cnt, length(label), nmi_value));
% M = crosstab(label,indic); % you can use also use "confusionmat"
% p = munkres(-M);
% [i,j] = find(p);
% M = M(i,:);
% purity = sum(diag(M)) / sum(sum(M))
