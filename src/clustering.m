function [ClusteredSample, Sample] = clustering(Sample, maxDistance, showProgress)
    clusterNo = 1;
    Sample.cluster = zeros(length(Sample.x),1);

    %% Determine to which cluster a signal belongs to
    for iSample1 = 1:length(Sample.x)
        if showProgress == 1
            disp(num2str(iSample1) + "/" + num2str(length(Sample.x)))
        end
        if Sample.cluster(iSample1) == 0
            for iSample2 = 1:length(Sample.x)
                distance = sqrt((Sample.x(iSample1)-Sample.x(iSample2))^2 + (Sample.y(iSample1)-Sample.y(iSample2))^2);
                if distance < maxDistance
                    Sample.cluster(iSample2) = clusterNo;
                end
            end
            clusterNo = clusterNo + 1;
        end
    end
    
    %% Calculate cluster properties and structure data
    disp(num2str(max(Sample.cluster)) + " Clusters")
    
    ClusteredSample.Area = zeros(max(Sample.cluster),1);
    ClusteredSample.x    = zeros(max(Sample.cluster),1);
    ClusteredSample.y    = zeros(max(Sample.cluster),1);
    for iCluster = 1:max(Sample.cluster)
        x = Sample.x.*(Sample.cluster == iCluster);
        y = Sample.y.*(Sample.cluster == iCluster);

        xWeighed = x.*Sample.Area;
        yWeighed = y.*Sample.Area;

        ClusteredSample.Area(iCluster) = sum(Sample.Area.*(Sample.cluster == iCluster));

        ClusteredSample.x(iCluster) = sum(xWeighed)/ClusteredSample.Area(iCluster);
        ClusteredSample.y(iCluster) = sum(yWeighed)/ClusteredSample.Area(iCluster);
    end
end

