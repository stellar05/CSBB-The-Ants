clearvars; close all;

%% setup some script properties
% all measures are in micrometers
maxDistanceClusters = 2*sqrt(2);        % Maximum distance for two signals to be considered one cluster
maxDistanceMarkers  = 2*sqrt(2);        % Maximum distance for clusters in different channels to be in the same spot
minSignalArea       = 0;                % Minimum area for a signal to be considered
minClusterArea      = 100;              % Minimum area for a cluster to be considered
SampleName          = "D16";
showProgress        = 1;

%% Import data
rawDataList = [importdata("../data/sox10_" + SampleName + "_signal.csv") importdata("../data/KI67_" + SampleName + "_signal.csv") importdata("../data/s100_" + SampleName + "_signal.csv")];

for ii = 1:3
    rawData = rawDataList(ii);
    newStruct.Area = rawData.data(:,2);
    newStruct.x    = rawData.data(:,6);
    newStruct.y    = rawData.data(:,7);

    if ii == 1
        SOX10 = newStruct;
    end 
    if ii == 2
        KI67 = newStruct;
    end 
    if ii == 3
        S100 = newStruct;
    end
end

%% Filtering signals by area
SOX10Filtered = filterBySize(SOX10,minSignalArea);
KI67Filtered  = filterBySize(KI67, minSignalArea);
S100Filtered  = filterBySize(S100, minSignalArea);

%% Check whether the user wants to start the script, the numbers displayed give a rough idea of the computing time
disp("SOX10: " + num2str(length(SOX10Filtered.x)) + "| Ki67: " + num2str(length(KI67Filtered.x)) + "| S100: " + num2str(length(S100Filtered.x)))
input("Start?")


%% Inspect what signals are clusters
disp("Clustering SOX10")
[SOX10Clustered, SOX10] = clustering(SOX10Filtered, maxDistanceClusters, showProgress);
disp("Clustering KI67")
[KI67Clustered,  KI67]  = clustering(KI67Filtered,  maxDistanceClusters, showProgress);
disp("Clustering S100")
[S100Clustered,  S100]  = clustering(S100Filtered,  maxDistanceClusters, showProgress);

% 1:SOX10; 2:KI67; 3:S100

%% Filter clusters by size
SOX10ClusteredFiltered = filterBySize(SOX10Clustered, minClusterArea);
KI67ClusteredFiltered  = filterBySize(KI67Clustered,  minClusterArea);
S100ClusteredFiltered  = filterBySize(S100Clustered,  minClusterArea);



%% Combine all signals
presence.x      = [SOX10ClusteredFiltered.x;    KI67ClusteredFiltered.x;    S100ClusteredFiltered.x];
presence.y      = [SOX10ClusteredFiltered.y;    KI67ClusteredFiltered.y;    S100ClusteredFiltered.y];
presence.Area   = [SOX10ClusteredFiltered.Area; KI67ClusteredFiltered.Area; S100ClusteredFiltered.Area];
presence.Type   = [ones(length(SOX10ClusteredFiltered.x),1); 2*ones(length(KI67ClusteredFiltered.x),1); 3*ones(length(S100ClusteredFiltered.x),1)];

disp("Crossreference")
[presenceClustered, presence] = ClusteringMultipleMarkers(presence, maxDistanceMarkers, showProgress);


%% Export data
presenceExport.data =       [presenceClustered.Area     presenceClustered.x     presenceClustered.y     presenceClustered.SOX10     presenceClustered.KI67      presenceClustered.S100      presenceClustered.Amount];
presenceExport.colheaders = ["Area"                     "x"                     "y"                     "SOX10"                     "KI67"                      "S100"                      "AmountPresent"];

presenceExport.data = sortrows(presenceExport.data, [7 1], "descend");

writematrix([presenceExport.colheaders; presenceExport.data], SampleName + ".csv")