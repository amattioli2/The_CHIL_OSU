function [hamCyc,uboundaryVertIDs,boundaryVertIDs,boundaryEdgeIDs] ...
        = layerHamiltonianCycle(subDomain,VertIDs)	% Main function.
    %LAYERHAMILTONIANPATH Hamiltonian path of all sections in a mesh layer.
    %   Detailed explanation goes here
    %
    %   See also HAMILTONIAN, CHILMESH/MESHLAYERS.
    %======================================================================
    
    % Get verts that define the outer boundary of the sub-domain.
    boundaryEdgeIDs	= subDomain.boundaryEdges;      % Boundary edges.
    boundaryVertIDs	= subDomain.edge2Vert(boundaryEdgeIDs);
    IVboundaryEdges = sum(ismember(boundaryVertIDs,VertIDs),2) == 0;
    boundaryVertIDs(IVboundaryEdges,:)	= [];       % Remove IV boundary edges.
    boundaryEdgeIDs(IVboundaryEdges)    = [];
    
    % Index boundary verts with respect to VertIDs.
    [uboundaryVertIDs,~,iunique]   = unique(boundaryVertIDs);
    boundaryVertIDs	= reshape(iunique,size(boundaryVertIDs));
    
    % Create adjacency matrix (graph) for boundary edges of iLayer.
    g   = sparse(boundaryVertIDs(:,1),...           % Does not account for
        boundaryVertIDs(:,2),...                    % IV of layer, therefore
        ones(length(boundaryVertIDs),1),...         % the output indices are
        length(boundaryVertIDs),...                 % wrt boundaryVertIDs.
        length(boundaryVertIDs)) + sparse(boundaryVertIDs(:,2),...
        boundaryVertIDs(:,1),ones(length(boundaryVertIDs),1),...
        length(boundaryVertIDs),length(boundaryVertIDs));
    
    % Compute depth-first search layer and its section(s).
    flagVertIDs	= uboundaryVertIDs;
    hamCyc	= {};                                   % Unknown # of sections.
    while sum(flagVertIDs) > 0
        % Perform depth-1st search from the first available source vertex.
        source	= find(flagVertIDs > 0,1,'first'); 	% Source vertex.
        hamCyc	= [hamCyc,{dfsearch(graph(g),source)}];
        flagVertIDs(hamCyc{end})	= 0;         	% Flag used verts.
    end
end
