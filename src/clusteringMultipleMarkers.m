function [ClusteredSample, Sample] = clusteringMultipleMarkers(Sample, maxDistance, showProgress)
    clusterNo = 1;
    Sample.cluster = zeros(length(Sample.x),1);
    %% Determine to which spot a cluster belongs to
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
    
    %% Calculate spot properties and structure data
    disp(num2str(max(Sample.cluster)) + " Points")
    
    ClusteredSample.Area    = zeros(max(Sample.cluster),1);
    ClusteredSample.x       = zeros(max(Sample.cluster),1);
    ClusteredSample.y       = zeros(max(Sample.cluster),1);
    ClusteredSample.SOX10   = zeros(max(Sample.cluster),1);
    ClusteredSample.KI67    = zeros(max(Sample.cluster),1);
    ClusteredSample.S100    = zeros(max(Sample.cluster),1);
    ClusteredSample.Amount  = zeros(max(Sample.cluster),1);

    for iCluster = 1:max(Sample.cluster)
        x = Sample.x.*(Sample.cluster == iCluster);
        y = Sample.y.*(Sample.cluster == iCluster);
        presence = unique(Sample.Type.*(Sample.cluster == iCluster));

        for ii = 1:3
            if sum(presence == 1) ~= 0
                ClusteredSample.SOX10(iCluster) = 1;
            end
            if sum(presence == 2) ~= 0
                ClusteredSample.KI67(iCluster) = 1;
            end
            if sum(presence == 3) ~= 0
                ClusteredSample.S100(iCluster) = 1;
            end
        end
        ClusteredSample.Amount(iCluster) = ClusteredSample.SOX10(iCluster) + ClusteredSample.KI67(iCluster) + ClusteredSample.S100(iCluster);

        

        xWeighed = x.*Sample.Area;
        yWeighed = y.*Sample.Area;

        ClusteredSample.Area(iCluster) = sum(Sample.Area.*(Sample.cluster == iCluster));

        ClusteredSample.x(iCluster) = round(sum(xWeighed)/ClusteredSample.Area(iCluster),3);
        ClusteredSample.y(iCluster) = round(sum(yWeighed)/ClusteredSample.Area(iCluster),3);
    end
end

