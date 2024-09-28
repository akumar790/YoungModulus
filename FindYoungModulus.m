clc
clear all
format long
%prompts user to select file 
[file_name, file_path]=uigetfile('*.xlsx');

%data extraction from selected file
data_read_disp=xlsread(file_name,'C43:C337')/1000000;
data_read_force=xlsread(file_name,'D43:D337')/1000;
diameter=xlsread(file_name,'D34:D34')/1000000;
rad=diameter/(2); 
ini_l=diameter;
area=3.142*rad*rad;

%removing -ve values
A=[data_read_disp, data_read_force];
filtered_data=A(all(A>0,2),:);

%stress and strain calculated
stress=filtered_data(:,2)/area;
strain=filtered_data(:,1)/ini_l;

%getting the slope (Young Modulus)
curve_line=polyfit(strain,stress,1);
y_modulus=curve_line(1)/1000; %in kpa

%prints Young Modulus
fprintf("The Young's Modulus (kPa) of tested specimen is %d\n", y_modulus)
