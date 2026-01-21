function [SampleFiltered] = filterBySize(Sample,minArea)
    SampleFiltered.x    = zeros(sum(Sample.Area > minArea),1);
    SampleFiltered.y    = zeros(sum(Sample.Area > minArea),1);
    SampleFiltered.Area = zeros(sum(Sample.Area > minArea),1);

    index = 1;
    for iSample = 1:length(Sample.x)
        if Sample.Area(iSample) > minArea
            SampleFiltered.x(index)    = Sample.x(iSample);
            SampleFiltered.y(index)    = Sample.y(iSample);
            SampleFiltered.Area(index) = Sample.Area(iSample);
            index = index + 1;
        end
    end

    
end