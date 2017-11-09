%% Adding a point.
% Points list.
P = [0 0; 0 1; 1 1; 1 2; 0 2; -1 2; -1 1; -1 0; 1 3; 2 3; 2 2; 2 1; 3 1; 3 2; 3 3];
C = [1 2 3; 2 4 5; 2 5 6; 2 6 7; 2 7 8; 11 9 4; 11 10 9; 11 15 10; 11 14 15; 11 12 13];
CM = CHILmesh(C,P);
clf;plot(CM);

% Identify boundary edges of next layer.
ElemIDs = [1 10]';           	% Triangle(s) to be converted to quad.
VertIDs = [2 11];               % Vertex of ^ on the OV boundary.
adjacentElemIDs = CM.vert2Elem('VertIDs',VertIDs,'Store','m');
adjacentElemIDs(adjacentElemIDs - ElemIDs == 0) = []
adjacentElemIDs(ismember(adjacentElemIDs,ElemIDs)) = [];
adjacentElems2EdgeIDs = CM.elem2Edge(adjacentElemIDs)
% contraintEdgeIDs = adjacentElems2EdgeIDs(ismember(adjacentElems2EdgeIDs,
verts = unique(nextBoundaryEdgeIDs);
dt = delaunayTriangulation(CM.Points(verts,1),CM.Points(verts,2),nextBoundaryEdgeIDs)
newTris = dt; newTris.ConnectivityList = newTris.ConnectivityList 

