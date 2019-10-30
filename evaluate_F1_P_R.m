function [value,Precision,Recall] = evaluate_F1_P_R(labels,pre_labels)
  labels(labels>0) = 1;labels(labels<=0) = 0;
  pre_labels(pre_labels>0) = 1;pre_labels(pre_labels<=0) = 0;
  %positive
  XandY = labels(:)&pre_labels(:);          
  Precision=(sum(XandY(:))+0.00000001)/(sum(pre_labels(:))+0.00000001);
  Recall=(sum(XandY(:))+0.00000001)/(sum(labels(:))+0.00000001);          
  value=2*Precision*Recall/(Precision+Recall);
end