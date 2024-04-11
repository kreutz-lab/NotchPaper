function tbl = ReadoutConditions(m)
% Reads out conditions to specific model as a table

global ar

data_number = length(ar.model(m).data);
data_names = strings(data_number,1);
cond_names = {};
% Find all condition parameters names and make unique set
for ii = 1:data_number
    cond_struct = ar.model(m).data(ii).condition;
    cond_names = [cond_names,cond_struct.parameter];
    data_names(ii) = ar.model(m).data(ii).name;
    % Also document link to corresponding data set
end
cond_names_uni = unique(cond_names);

% Find each model condition corresponding data conditions
model_names = NaN(data_number,1);
for ii = 1:length(ar.model(m).condition)
    model_names(ar.model.condition(ii).dLink) = ii;
end

% For each data condition, fill out corrsponding parameter condition value
cond_val_array = strings(data_number,length(cond_names_uni));
for ii = 1:data_number
    cond_struct = ar.model(m).data(ii).condition;
    for jj = 1:length(cond_struct)
        q = strcmp(cond_struct(jj).parameter,cond_names_uni);
        cond_val_array(ii,q) = cond_struct(jj).value;
    end
end

% Make table out of all the information
tbl_cond = array2table(cond_val_array,'VariableNames',cond_names_uni);
tbl = [array2table(data_names),array2table(model_names,'VariableNames',...
    {'ModelCondition'}),tbl_cond];

end