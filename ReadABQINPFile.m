function [GlobalNodes, Connectivity, EdgeNodes] = ReadABQINPFile(ABQ_inputFile)
fid = fopen(ABQ_inputFile);

a = 0;
currentSection = "";
MaxNumNodes = 0;
EdgeNodes = struct('Top', [], 'Right', [], 'Left', [], 'Bottom', []);
while true
   thisline = fgetl(fid);
   % Check for Node Section
   if(strcmp(thisline,'*Node'))
       currentSection = "Node";
       continue
   end
   % Check for assembly section
   if(length(thisline)>=9)
     if(strcmp(thisline(1:9),'*Assembly'))
         currentSection = "Assembly";
         continue
     end
   end
   % Check for Element section
   if(length(thisline) >=8)
       if(strcmp(thisline(1:8),'*Element'))
           currentSection = "Element";
           continue
       end
   end
   % Leave Element section
   if(length(thisline)>4)
    if(strcmp(thisline(1:5),'*Nset') || strcmp(thisline, '*End Part'))
        currentSection = "";        
        continue
    end
   end

%% *NODE
   % Determine global node numbers and coordinates
   if(strcmp(currentSection,"Node"))
     a = a+1;
     thisline(thisline == ' ') = [];
     tmp =  split(thisline,",");
     %GlobalNodes(a,1) = str2double(tmp{1});
     GlobalNodes(a,1) = str2double(tmp{2});
     GlobalNodes(a,2) = str2double(tmp{3});
   end
 
 %% *ELEMENT  
   % Node Numbers for each element
   if(strcmp(currentSection,"Element"))
       thisline(thisline == ' ') = [];
       tmp =  split(thisline,",");
       if(length(tmp) - 1 > MaxNumNodes)
           MaxNumNodes = length(tmp) - 1;
       end
       for i = 1:length(tmp)-1
           ElemNum = str2double(tmp{1});
           LocalNodes{ElemNum}(i) = str2double(tmp{i+1});
       end
   end

   %% *ASSEMBLY
   % Assign node sets from assembly (For use later in BCs)
   if(strcmp(currentSection,'Assembly'))
      setNum = 0;
      while true
        thisline = fgetl(fid);

        % Break out of loop at end of assembly section
        if(strcmp(thisline,"*End Assembly"))
            currentSection = "";
            break
        end

        % Read through node set sections
        if(length(thisline)>=5)
           if(strcmp(thisline(1:5),"*Nset"))
               currentSection = "*Nset";
               setNum = setNum+1;
               setName{setNum} = extractBetween(thisline,"nset=",",");
               nodesInSet{setNum} = [];
               continue
           end
           if(strcmp(thisline(1:5),"*Else"))
               currentSection = "*Elset";
               continue
           end
        end

        % Start Assigning Nodes to Node sets
        if(strcmp(currentSection,"*Nset"))
           thisline(thisline == ' ') = [];
           tmp = split(thisline,",");

           % Delete trailing commas if only 1 node in set 
           if(isempty(tmp{end}))
               tmp(end) = [];
           end
           
           % If all nodes in a set are evenly spaced apart (i,e. 11,12,13,14,15,16) abaqus will 
           % shortand the input file to read 11,16,1. or (i.e. 10,20,30,40,50) abaqus will shorthand the
           % input file to read 10,50,10. This only seems to happen for
           % nodes spaced out in a pattern instead of when they are more
           % randomly distributed
           if(length(tmp)==3 && mod((str2double(tmp{2})-str2double(tmp{1})),str2double(tmp{end})) == 0)
               tmp = str2double(tmp);
               tmpnew = tmp(1):tmp(end):tmp(2);
               tmp = tmpnew';
               nodesInSet{setNum} = [nodesInSet{setNum}; tmp];
               continue
           end
           nodesInSet{setNum} = [nodesInSet{setNum}; str2double(tmp)];
        end
      end
         % Break out
       if(strcmp(thisline,"*End Assembly"))
          break
      end
   end
end

% Assign Edge Nodes
for i = 1:length(nodesInSet)
    if(strcmp(setName{i},"Left"))
        EdgeNodes.Left = nodesInSet{i};
    elseif(strcmp(setName{i},"Bottom"))
        EdgeNodes.Bottom = nodesInSet{i};
    elseif(strcmp(setName{i},"Right"))
        EdgeNodes.Right = nodesInSet{i};        
    elseif(strcmp(setName{i},"Top"))
        EdgeNodes.Top = nodesInSet{i};    
    end
end

% Assembly Connectivity (Works for 2D quad elements!)
NumElements = length(LocalNodes);
Connectivity = zeros(NumElements, MaxNumNodes);
for i = 1:NumElements
    % Rearrange abaqus quad element node order to match our node order in
    % class
    if(length(LocalNodes{i}) == 8)
        LocalNodes{i} = RearrangeNodeOrder(LocalNodes{i});
    end
    Connectivity(i, :) = LocalNodes{i};
end
end

function Nodes_temp = RearrangeNodeOrder(Nodes)
     Nodes_temp = Nodes;
     Nodes_temp(1) = Nodes(1); Nodes_temp(5) = Nodes(3);
     Nodes_temp(2) = Nodes(5); Nodes_temp(6) = Nodes(7);
     Nodes_temp(3) = Nodes(2); Nodes_temp(7) = Nodes(4);
     Nodes_temp(4) = Nodes(6); Nodes_temp(8) = Nodes(8);
end