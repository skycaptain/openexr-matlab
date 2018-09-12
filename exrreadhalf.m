function [pixeldata, channel_names] = exrreadhalf( filename )
%EXRREADHALF    Read OpenEXR image as half float data
%   EXRWRITECHANNELS(FILENAME)
%   Read an OpenEXR image as half float data (IEEE 754-2008 bit structure packed as uint16)
%
%   FILENAME Name of the file to read
%
%   Note: This method is inteded if the intention is needed to get exact half float information
%   out of a half float EXR file and can for example be used with the fp16 file type class
%   from Cleve Laboratory. A slightly modified fp16 constructor allowing packed uint16 passing
%   is available at https://github.com/irieger/cleve-laboratory/blob/master/code/%40fp16/fp16.m

    if nargin == 1

        % read all channel data and put it into one array
        data = exrreadchannels( {'as_half'}, filename );

        channel_names = {};

        if isa(data, 'uint16')
            pixeldata = data;
        else

            % Resorting channels if default RGB(A(Z)) channels are available to reverse
            % sorting by libopenexr.
            default_names = {'R', 'G', 'B', 'A', 'Z'};
            keys = data.keys();

            for ii=1:size(data, 1)
                if ii <= size(default_names, 2) && data.isKey(default_names{ii})
                    pixeldata(:,:, ii) = data(default_names{ii});
                    channel_names{ii}  = default_names{ii};

                else
                    pixeldata(:,:, ii) = data(keys{ii});
                    channel_names{ii}  = keys{ii};
                end
            end

        end

    else
        error('Wrong number of arguments');
        return;
    end

end
