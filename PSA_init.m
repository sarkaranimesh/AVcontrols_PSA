%%
clc;
clear all; close all
%%
scenario = scene_1;
n = size(scenario);
Vx = 15;
for ii =1:n(2)
    refPose(:,ii) = [scenario(ii).ActorPoses.Position(1);scenario(ii).ActorPoses.Position(2);scenario(ii).ActorPoses.Yaw];
    yaw_rate_pose(ii) = scenario(ii).ActorPoses.AngularVelocity(3);
end 
xRef = refPose(1,:);
yRef = refPose(2,:) ;
% yRef = refPose(2,:) + 2; %for lane change course
yawRef = refPose(3,:);
refPose = refPose'; % reference waypoints
yaw_rate_pose = deg2rad(yaw_rate_pose); %angular velocity of the path

%% define reference time 
sim_time = 30; % simulation time for city road
s = size(xRef);
tRef = (linspace(0,sim_time,s(2)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 


%%
% Define the sample time, |Ts|, and simulation duration, |T|, in seconds.
Ts = 0.1; % sample time for MPC

%% curvature preview and calculation
PredictionHorizon = 10;
md =get_curvature(Vx,yaw_rate_pose,tRef');
curvature = md.signals.values;
Radius =abs(1./ md.signals.values);

V_curve = sqrt(9.81*0.9.*Radius);
%% Model parameters
Lambda1 = 0.2;
tau1 = 0.7;
Kp =1.5;
Kd = 1.2;