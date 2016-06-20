function [  ] = setsimulationview( sideview )

switch sideview
    case 'XZ'
        view([0 0]); %view XZ plane
    case 'ZX'
        view([-180,0]);       
    case 'YZ'
        view(90, 0); %view YZ plane
    case 'ZY'
        view(-90,0);
    case 'XY'
        view([0 0 1]);
    case 'V1'
        view([-14.5,6]);
    case 'V2'
        view([-19.5,28]);
    case 'V3'
        view(-130,14);
    case 'VV'
        view([-180,26]);        
    case 'I-03'
        view(-140,26);
    case 'I-05'
        view(-176,30);
    case 'I-06'
        view(-177,6);
    case 'I-07'
        view(-178,8);
    case 'I-09'
        view(-180,8);
    case 'I-10' %crash Ten
        view(-177,20);   
    case 'VI-01'
        view(-177,-18);

end


end

