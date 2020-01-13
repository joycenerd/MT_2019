function t=inside_triangle(P,P1,P2,P3);
%inside_triangle is used to check if a point P is inside
%the triangle P1P2P3 or not. 
%
%Inputs: P, P1, P2 and P3 are vectors of length 2 or three of the 
% form [x y z] or [x y] 
%
%Output: True 
%True=1     =>   P is on or inside P1P2P3
%True=0     =>   P is outside P1P2P3
%
%Example:
%True=inside_triangle([0.5 0.5],[0 0],[0 2],[2 0]);

P12 = P1-P2; P23 = P2-P3; P31 = P3-P1;
t = sign(det([P31;P23]))*sign(det([P3-P;P23])) >= 0 & ...
    sign(det([P12;P31]))*sign(det([P1-P;P31])) >= 0 & ...
    sign(det([P23;P12]))*sign(det([P2-P;P12])) >= 0 ;
