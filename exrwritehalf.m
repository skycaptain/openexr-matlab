function exrwritehalf( filename, pixeldata, channel_names )
%EXRWRITEHALF    Write a multichannel half float image with data passed as packed uint16 data
%   EXRWRITECHANNELS(FILENAME, PIXELDATA, CHANNEL_NAMES)
%   Writes an OpenEXR image with half float data passed packed into uint16 (or with the help
%   of Cleve Laboratory fp16 data type) compressed with piz compression.
%
%   FILENAME Name to save the file as
%
%   PIXELDATA uint16 or fp16 type array with dimensions [height, width, channel]
%
%   CHANNEL_NAMES  Cell array of channel names to use. Has to match third dimension
%   of pixel data. If not given a default set of R, G, B, A, Z, channel_%03d will be used.
%
%   Note: This is inteded for cases when exact HALF float data has to be used packed either
%   manually or using Cleve Laboratory fp16 class to convert and work with them.


    number_of_channels = size(pixeldata, 3);
    channels = {};
    names    = {};


    % Check for minimum number of parameters
    if nargin < 2
        error('At least a filename and some image data has to be passed!');
        return;
    end


    % Check if channel names are given or construct them automatically
    if nargin == 3
        if iscell(channel_names) && size(channel_names, 1) == number_of_channels
            names = channel_names';
        elseif iscell(channel_names) && size(channel_names, 2) == number_of_channels
            names = channel_names;
        else
            error('Parameter 3 is either not a cell array or does not have the correct size!');
            return;
        end
    else
        % Default channel name set for regular exr channels
        default_names = {'R', 'G', 'B', 'A', 'Z'};
        if size(pixeldata, 3) == 1
            names{1} = 'Y';
        else
            for ii=1:size(pixeldata, 3)
                if ii <= size(default_names, 2)
                    names{ii} = default_names{ii};
                else
                    names{ii} = sprintf('channel_%03d', ii);
                end
            end
        end
    end

    % Convert fp16 to uint16 type for passing
    if isa(pixeldata, 'fp16')
        % This method is currently available in a modified version of Cleve Laboratory which
        % was sent to cleve in hope of adding the functionallity to the official release.
        % See https://github.com/irieger/cleve-laboratory/blob/master/code/%40fp16/uint16_packed.m
        pixeldata = uint16_packed(pixeldata);
    end

    % Write image if data is uint16 and is 2 or 3 dimensional
    if isa(pixeldata, 'uint16') && (ndims(pixeldata) == 3 || ndims(pixeldata) == 2)
        for ii=1:size(pixeldata, 3)
            channels{ii} = pixeldata(:,:,ii);
        end

        attributes = containers.Map();
        exrwritechannels(filename, 'piz', 'native', attributes, names, channels);
    else
        error('Invalid data type of pixel data');
        return
    end

end
