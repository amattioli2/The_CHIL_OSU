function [sectionVertIDs,done]	= getSectionVerts(g,sectionVertIDs,branchVertID,iZero,done)
    if done
        return
    end
    
    % Identify verts connected along branches from branchVertID.
    [r,~]	= find(g(:,branchVertID));            	% Rows wrt layerVertIDs.               
    foundSectionVertIDs	= r;                        % Connected VertIDs.
    
    % Remove redundant VertIDs; Check for completion.
    first_sectionVertIDs	= foundSectionVertIDs == sectionVertIDs(1);
    if any(first_sectionVertIDs)
        foundSectionVertIDs(first_sectionVertIDs) = [];
        foundSectionVertIDs(ismember(foundSectionVertIDs,sectionVertIDs)) = [];
        if isempty(foundSectionVertIDs) || foundSectionVertIDs(1) == foundSectionVertIDs(2)
            done	= true;                         % This will be the last iteration.
            foundSectionVertIDs = foundSectionVertIDs(1);
        end
    end
    
    % Store VertIDs found in this section of the layer.
    endZero	= iZero + length(foundSectionVertIDs)-1;% Index to storage.
    sectionVertIDs(iZero:endZero)	= foundSectionVertIDs;
    
    % Recursion: Call self until initial branchVertID is reached.
    [sectionVertIDs,done]	= getSectionVerts(g,sectionVertIDs,foundSectionVertIDs,endZero+1,done);
    
    % Remove zeros from list.
    if done
        sectionVertIDs(find(sectionVertIDs == 0,1,'first'):end) = [];
    end
end