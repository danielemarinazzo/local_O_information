%% 
clear
load('bachChorales.mat')
locOi = oiLocal(bach{:,2:end},13);

%% Load 
load('bachStates.mat')


%% FIGURE 4: Dissonance vs O-info
idOcc = find( bachStates.Occurrence > 0); % Mettiamo un cut off alle occurrence

B = arrayfun(@analyzeChord,bachStates.Chord(idOcc),'UniformOutput',true);
a = extractfield(B,'intervName');
cons  = extractfield(B,'countConsonant');
diss  = extractfield(B,'countDissonant');
other = extractfield(B,'countOther'); % è sempre 0

% figure; boxplot(bach.Oinfo,diss) % Boxplot O-info vs dissonance

figure('Position',[489 275.4000 916 487.6000]); 
boxplot(bachStates.Oinfo,diss);
ylabel('\omega','FontSize',26); yline(0,'Linewidth',1.5); ylim([-4 4]);
xlabel("Number of Dissonant Intervals"); xticklabels(string(0:4))


%% FIGURE 7: Alteration vs O-info
test = @(arg) nnz(ismember(arg,'#')); % Test per contare le alterazioni
idx = cellfun(test,bachStates.Chord);
% [p,tbl,stats] = anova1(bachStates.Oinfo,idx,'off'); 
% figure; [results,means] = multcompare(stats,'CType','bonferroni');
figure; boxplot(bachStates.Oinfo,idx,'Labels',{'0 #','1 #','2 #','3 #'}); ylabel('\omega','FontSize',26); yline(0)
hold on 
text(2,3,'*','FontSize',24)
text(3,3,'*','FontSize',24)


%% FIGURE 3: Probability vs O-Info
% bach1 = bach( log(bachStates.probability)/log(13) < -2.5,:);
figure('Position',[356.2000 141.8000 855.2000 621.6000]);
mdl = fitlm(log(bachStates.probability)/log(13),bachStates.Oinfo);
plot(mdl); axis square
xlabel('$\log_{13}(P)$','Interpreter','latex');ylabel('\omega','FontSize',24,'Interpreter','tex'); yline(0,'Linewidth',1.5);
text(0.8,0.6,sprintf("\\omega \\sim %.2f log_{13}(P) + %.2f", ...
        mdl.Coefficients.Estimate(2),mdl.Coefficients.Estimate(1)),'Units','normalized','Interpreter','tex')
grid on; legend box off
