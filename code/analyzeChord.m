function chordStruct = analyzeChord(chord)
% Analizza il tipo di intervNameli presenti nell'accordo e restituisce una
% variabile che ne indica il tip (CONSONANTE O DISSONANTE)
% Accordo consonante: presenta SOLO terze (maggiori e/o minori), quinte e/o ottave
% Accordo dissonante: accordo che NON è nella categoria consonante
chordStruct = struct;
chordStruct.countConsonant = 0; % Numero intervalli consonanti
chordStruct.countDissonant = 0; % Numero intervalli dissonanti
chordStruct.countOther = 0; % Numero altri intervalli 

C = split(chord);

C = int8(categorical(C',{'C','C#','D','D#','E','F','F#','G','G#','A','A#','B','Rest'},string(1:13),'Ordinal',1));
comb = nchoosek(1:4,2); % Combinantions of 2 indices between 4 elements (instruments)


label=split(chord);
chordStruct.intervName = cell(6,1);
chordStruct.interv = cell(6,1);
for n = 1:height(comb)   
    chordStruct.interv{n} = string(label{comb(n,1)}) + " " + string(label{comb(n,2)});
    if C(comb(n,1)) == 13 || C(comb(n,2)) == 13
        chordStruct.intervName{n} = 'Rest';
    else
        switch abs(C(comb(n,1))-C(comb(n,2)))
            case  4
                chordStruct.intervName{n} = 'Major third';
                chordStruct.countConsonant = chordStruct.countConsonant + 1;
            case  3
                chordStruct.intervName{n} = 'Minor third';
                chordStruct.countConsonant = chordStruct.countConsonant + 1;
            case  5
                chordStruct.intervName{n} = 'Perfect fourth';
                chordStruct.countConsonant = chordStruct.countConsonant + 1;
            case 7
                chordStruct.intervName{n} = 'Perfect fifth';
                chordStruct.countConsonant = chordStruct.countConsonant + 1;
            case  8
                chordStruct.intervName{n} = 'Minor sixth';
                chordStruct.countConsonant = chordStruct.countConsonant + 1;
            case  9
                chordStruct.intervName{n} = 'Major sixth';
                chordStruct.countConsonant = chordStruct.countConsonant + 1;
            case  0
                chordStruct.intervName{n} = 'Octave';
                chordStruct.countConsonant = chordStruct.countConsonant +1;
            case  1                                      % DISSONANT
                chordStruct.intervName{n} = 'Dissonant';   % Minor second
                chordStruct.countDissonant = chordStruct.countDissonant + 1;
            case  2
                chordStruct.intervName{n} = 'Dissonant';   % Major second
                chordStruct.countDissonant = chordStruct.countDissonant + 1;
            case  6
                chordStruct.intervName{n} = 'Dissonant';   % Diminished fifth
                chordStruct.countDissonant = chordStruct.countDissonant + 1;
            case  10
                chordStruct.intervName{n} = 'Dissonant';   % Minor seventh
                chordStruct.countDissonant = chordStruct.countDissonant + 1;
            case  11
                chordStruct.intervName{n} = 'Dissonant';   % Major seventh   
                chordStruct.countDissonant = chordStruct.countDissonant + 1;
                
            otherwise
                chordStruct.intervName{n} = 'Other';
                chordStruct.countOther = chordStruct.countOther  + 1;
        end
        
    end
end

end






% Strategia Rosas
% chordStruct = 0;
% for n = 1:height(comb)   
%     Any chord with at least one consecutive note or a diminished fifth is
%     dissonant
%     if abs(C(comb(n,1))-C(comb(n,2))) == 1 || ...    % Consecutive Note
%        abs(C(comb(n,1))-C(comb(n,2))) == 6           % Diminished fifth
%        chordStruct.type = 'dissonant';
%        chordStruct = 'dissonant';
%         chordStruct = chordStruct + 1; 
%     end         
% end


% Strategia alternativa 
% for n = 1:height(comb)   
%     % If one or more intervNames are not of these types, the chord is dissonant
%     if abs(C(comb(n,1))-C(comb(n,2))) ~= 4 && ...    % Major third 
%        abs(C(comb(n,1))-C(comb(n,2))) ~= 3 && ...    % Minor third 
%        abs(C(comb(n,1))-C(comb(n,2))) ~= 5 && ...    % Perfect fourth
%        abs(C(comb(n,1))-C(comb(n,2))) ~= 7 && ...    % Perfect fifth
%        abs(C(comb(n,1))-C(comb(n,2))) ~= 8 && ...    % Minor sixth
%        abs(C(comb(n,1))-C(comb(n,2))) ~= 9 && ...    % Major sixth
%        abs(C(comb(n,1))-C(comb(n,2))) ~= 0 && ...    % Octave
%        C(comb(n,1)) ~= 13 && C(comb(n,2)) ~= 13 
%        chordStruct.type = 'dissonant';
% %        chordStruct = 'dissonant';
%     end         
% end