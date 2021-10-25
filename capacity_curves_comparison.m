%Comparison of the capacity curves for reference model 
%and the model with internal facade walls' changes (openning)
% from 2100 mm to 2720 mm.
clc
clear all
close all

% choose the 1000 capacity curves file
infold = 'C:\Users\ahmad\Music\Modelization-project\Fragility_and_comparison\capacity_curves_12_11_2020';

% we choose the two or more models in order to make a comparison
types = {'M5_L_FF_MMM','M5_L_FF_NS_InterPiers_L2100toL2720'}


% we plot the idealized capacity curves on function of
% the average parameters of Sdy, Sdu, Ty which are respectively
% maximum elastic displacement, ultimate and 
hold on
for i = 1:length(types)

type = types{i};

%Read 1000 capacity curves file
Para1000 = csvread([infold '\Capacity_curves_' type '.csv']);

%Average of the parameters
%[Sdy, Sdu, Ty]
Para = mean(Para1000);
Para(1) = Para(1)/1000;
Para(2) = Para(2)/1000;

%Idealization of the capacity curve for the initial values
l_Sdu = 0:0.0001:Para(2);
l_Sa = [];
for i = 1:length(l_Sdu)
  if l_Sdu(i) < Para(1)
      l_Sa(i) = l_Sdu(i)*(2*pi()/Para(3))^2;
  else
      l_Sa(i) = Para(1)*(2*pi()/Para(3))^2;
  end
end

%Plot the idealized capacity curve
type_txt = strrep(char(type),'_','\_');
txt = [type_txt];
plot(l_Sdu,l_Sa,'DisplayName',txt)

end

%Plot the idealized capacity curves
hold off
title('Improvement on the capacity curve','Fontsize',16,'FontWeight','bold')
xlabel('S_d [m]','Fontsize',10,'FontWeight','bold');
ylabel('S_a [m/s^2]','Fontsize',10,'FontWeight','bold');
legend show
grid on;

