function [Domain,time] = Tri2QuadRoutine(Domain,plotProgress,time)
    %TRI2QUADROUTINE Creates a quadrangular or mixed-element mesh.
    %   [Domain,time] = Tri2QuadRoutine(Domain,plotProgress,time)
    %
    %   See also MAIN, CREATEQUADDOMAIN, POSTPROCESSROUTINE.
    %======================================================================
    
    %% 1) Identify Edges Within Each Layer of Domain For Removal.
%     [OE_IE,OV_IV]	= Domain.layers;                % Get layer info.
    for iLayer	= Domain.nLayers:-1:1               % Work outwards.
        % Get elems of layer; create sub-domain CHILmesh.
        ElemIDs	= [Domain.Layers.OE{iLayer}; Domain.Layers.IE{iLayer}];
        subDomain	= CHILmesh(Domain.ConnectivityList(ElemIDs,:),Domain.Points);
        VertIDs	= Domain.Layers.OV{iLayer};         % Verts of outer boundary.
clf; subDomain.plot
        
        % Compute hamiltonian cycle(s) for section(s) of layer.
        [hamCyc,uboundaryVertIDs,boundaryVertIDs,boundaryEdgeIDs] ...
        = layerHamiltonianCycle(subDomain,VertIDs);
    
        % Get adjacency lists to be referenced, flagged throughout routine.
        vert2Edges	= subDomain.vert2Edge('VertIDs',uboundaryVertIDs,'store','m');
        edge2Elems	= subDomain.edge2Elem;          % Wrt to sub-domain.
        
        % Perform routine on each "section" of iLayer.
        for iSection	= 1:size(hamCyc,2)      	% H. cycle(s) of section(s).
            % Wrap h. cycle of layer section w/ destinatin, source verts.
            sectionCycle    = [hamCyc{iSection}(end); hamCyc{iSection};...
                hamCyc{iSection}(1)];               % Indexed to 
            
            % Identify edges in subDomain for removal (match these elems).
            removeEdgeIDs	= zeros(size(edge2Elems,1),1);
            idx_removeEdgeIDs   = 1;
            downEdgeID  = boundaryEdgeIDs(sum(ismember(boundaryVertIDs,sectionCycle(1:2)),2) == 2);
            downEdgeID	= boundaryEdgeIDs(1);     	% Initial down-path Edge,
            for ihp	= 2:length(hp)-1             	% Begin at source vert.
                % Identify up-path and down-path edges wrt ihp vert.
                upEdgeID    = downEdgeID;         	% Shift from downEdge.
                [sEdgeIDs,~]= find(boundaryVertIDs == hp(ihp));
                downEdgeID  = boundaryEdgeIDs(sEdgeIDs(2));
                
                % Get edges incident to vertex ihp and their attached Elems.
                ihp_EdgeIDs	= vert2Edges(hp(ihp),vert2Edges(hp(ihp),:) > 0);
                num_Edges	= length(ihp_EdgeIDs);	% # of edges at vert.
subDomain.plotEdge(upEdgeID,'color','r');  subDomain.plotPoint(VertIDs(hp(ihp-1)),'Color','r');
                if num_Edges == 2                 	% Only boundary edges remain.
                    continue                        % Advance down-path.
                end
                ihp_ElemIDs	= subDomain.edge2Elem(ihp_EdgeIDs);
subDomain.plotEdge(downEdgeID,'color','b');subDomain.plotPoint(VertIDs(hp(ihp)),'Color','g');
subDomain.plotPoint(VertIDs(hp(ihp+1)),'Color','b');% Next vertex along path.
                
                % Sort ihp_EdgeIDs from up-path edge to down-path edge.
                sorted_ihp_EdgeIDs = [upEdgeID;...  % Up edge 1st, down last.
                    zeros(num_Edges-2,1); downEdgeID];
                downElemID	= 0;                    % Down-Path elemID.
                currentEdge	= find(ihp_EdgeIDs == upEdgeID);	% Index to upEdgeID.
                for jdx	= 2:num_Edges-1
                    % ElemID of upEdgeID.
                    upElemID	= ihp_ElemIDs(currentEdge,...
                        ihp_ElemIDs(currentEdge,:) ~= downElemID);
                    ihp_ElemIDs(currentEdge,:)	= 0;% Flag currentEdge as used.
                    
                    % Find "currentEdge" and downElemID for next iteration.
                    [currentEdge,~]	= find(ihp_ElemIDs == upElemID);
                    sorted_ihp_EdgeIDs(jdx) = ihp_EdgeIDs(currentEdge);
                    downElemID	= upElemID;
                end
                
                % For the sorted edges, remove every other edge along path.
                for jdx	= 2:num_Edges-1         	% Do not remove up/downEdges.
                    % Check if edge jdx's ElemIDs have been flagged.
                    ElemIDs_jdxEdge = edge2Elems(sorted_ihp_EdgeIDs(jdx),:);
                    if any(ElemIDs_jdxEdge == 0)    % ElemID flagged.
                        continue                    % Skip to next edge.
                    else                            % No ElemIDs flagged.
                        % Store EdgeID for removal, update counter.
                        removeEdgeIDs(idx_removeEdgeIDs) = sorted_ihp_EdgeIDs(jdx);
%                         vert2Edges(ismember(...     % Flag used edges.
%                             vert2Edges,removeEdgeIDs(1:idx_removeEdgeIDs)))	= 0;
                        idx_removeEdgeIDs	= idx_removeEdgeIDs + 1;
subDomain.plotEdge(removeEdgeIDs(idx_removeEdgeIDs-1),'Color','w');%pause
                        
                        % Flag ElemIDs that are now used.
                        edge2Elems(ismember(edge2Elems,ElemIDs_jdxEdge))	= 0;
                    end
                end
                
                % Identify unmatched triangles in section of layer.
                
                % Move to next section of layer.
            end
        end
    end
    
    %% 2. Remove Edges to Create Quads in Domain.
    
    %% 3. Add/Remove Edges Along Boundary to Complete Tri2Quad.
    
end

