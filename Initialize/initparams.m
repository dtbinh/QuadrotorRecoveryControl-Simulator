function []= initparams()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global g m I Ixx Iyy Izz

global Jr Dt Kt PROP_POSNS BUMP_RADIUS BUMP_ANGLE

global AERO_AREA AERO_DENS Cd Tv Kp Kq Kr ALPHA BETA

global u2RpmMat BUMP_NORMS BUMP_TANGS


g = 9.81;

%Mass Properties
m = 0.933; %kg

%Inertia Properties in body fixed frame
Ixx = 0.008737;
Iyy = 0.008988;
Izz = 0.017143;
Ixy = -4.2e-7;
Iyz = -1.14e-6;
Izx = -5.289e-5;


I = [Ixx Ixy Izx;Ixy Iyy Iyz;Izx Iyz Izz]; %vehicle moment of inertias, kg m^2
Jr = 2.20751e-5; %Propeller moment of inertia about rotation axis, kg m^2

load('locations2');
PROP_POSNS = [p1, p2, p3, p4] - repmat(CoM,1,4); %prop locations relative to CoM

%Thrust coefficient
% Kt = 0.000000054; %From Pleiades primitives.c 07-03-2015
Kt = 8.7e-8; %Calculated from thrust needed for Spiri to hover w/ white 8" props
%Kt = 7.015e-8; %Calculated from 8x4.5 APC Prop

%Drag Torque factor of coaxial rotor pairs
Dt = 9.61e-10; %Calculated from 8x4.5 APC Prop


u2RpmMat = inv([-Kt -Kt -Kt -Kt;...
    -Kt*PROP_POSNS(2,1) -Kt*PROP_POSNS(2,2) -Kt*PROP_POSNS(2,3) -Kt*PROP_POSNS(2,4);...
    Kt*PROP_POSNS(1,1) Kt*PROP_POSNS(1,2) Kt*PROP_POSNS(1,3) Kt*PROP_POSNS(1,4);...
    -Dt Dt -Dt Dt]);

%Aerodynamic Drag
AERO_AREA = 0; %Area seen by relative velocity vector
AERO_DENS = 0; %Air density
Cd = 0; %Drag coefficient
Tv = zeros(3); %Wind to body rotation matrix
Kp = 0; %Aerodynamic drag constant
Kq = 0; %Aerodynamic drag constant
Kr = 0; %Aerodynamic drag constant
ALPHA = 0;
BETA = 0;

% Bumper things
BUMP_RADIUS = 0.11;
BUMP_ANGLE = deg2rad(11);

BUMP_NORMS(:,1) = invar2rotmat('Z',deg2rad(45))'*invar2rotmat('Y',BUMP_ANGLE + deg2rad(90))'* [1;0;0];
BUMP_NORMS(:,2) = invar2rotmat('Z',deg2rad(135))'*invar2rotmat('Y',BUMP_ANGLE + deg2rad(90))'* [1;0;0];
BUMP_NORMS(:,3) = invar2rotmat('Z',deg2rad(-135))'*invar2rotmat('Y',BUMP_ANGLE + deg2rad(90))'* [1;0;0];
BUMP_NORMS(:,4) = invar2rotmat('Z',deg2rad(-45))'*invar2rotmat('Y',BUMP_ANGLE + deg2rad(90))'* [1;0;0];

BUMP_TANGS(:,1) = invar2rotmat('Z',deg2rad(45))'*invar2rotmat('Y',BUMP_ANGLE)'*[1;0;0];
BUMP_TANGS(:,2) = invar2rotmat('Z',deg2rad(135))'*invar2rotmat('Y',BUMP_ANGLE)'*[1;0;0];
BUMP_TANGS(:,3) = invar2rotmat('Z',deg2rad(-135))'*invar2rotmat('Y',BUMP_ANGLE)'*[1;0;0];
BUMP_TANGS(:,4) = invar2rotmat('Z',deg2rad(-45))'*invar2rotmat('Y',BUMP_ANGLE)'*[1;0;0];


end

