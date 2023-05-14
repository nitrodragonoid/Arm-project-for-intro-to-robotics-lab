function depth_example2()
    %% Create all objects to be used in this file
    % Make Pipeline object to manage streaming
    pipe = realsense.pipeline();
    % Make Colorizer object to prettify depth output
    colorizer = realsense.colorizer();
    % Create a config object to specify configuration of pipeline
    cfg = realsense.config();

    
    %% Set configuration and start streaming with configuration
    % Stream options are in stream.m
    streamType = realsense.stream('depth');
    % Format options are in format.m
    formatType = realsense.format('Distance');
    % Enable default depth
    cfg.enable_stream(streamType,formatType);
    % Enable color stream
    streamType = realsense.stream('color');
    formatType = realsense.format('rgb8');
    cfg.enable_stream(streamType,formatType);
    
    % Start streaming on an arbitrary camera with chosen settings
    profile = pipe.start();

    %% Acquire and Set device parameters 
    % Get streaming device's name
    dev = profile.get_device();    
    name = dev.get_info(realsense.camera_info.name);

    % Access Depth Sensor
    depth_sensor = dev.first('depth_sensor');

    % Access RGB Sensor
    rgb_sensor = dev.first('roi_sensor');
    
    % Find the mapping from 1 depth unit to meters, i.e. 1 depth unit =
    % depth_scaling meters.
    depth_scaling = depth_sensor.get_depth_scale();

    % Set the control parameters for the depth sensor
    % See the option.m file for different settable options that are visible
    % to you in the viewer. 
    optionType = realsense.option('visual_preset');
    % Set parameters to the midrange preset. See for options:
    % https://intelrealsense.github.io/librealsense/doxygen/rs__option_8h.html#a07402b9eb861d1defe57dbab8befa3ad
    depth_sensor.set_option(optionType,9);

    % Set autoexposure for RGB sensor
    optionType = realsense.option('enable_auto_exposure');
    rgb_sensor.set_option(optionType,1);
    optionType = realsense.option('enable_auto_white_balance');
    rgb_sensor.set_option(optionType,1);    
    
    %% Align the color frame to the depth frame and then get the frames
    % Get frames. We discard the first couple to allow
    % the camera time to settle
    for i = 1:5
        fs = pipe.wait_for_frames();
    end
    
    % Alignment
    align_to_depth = realsense.align(realsense.stream.depth);
    fs = align_to_depth.process(fs);

    % Stop streaming
    pipe.stop();

    %% Depth Post-processing
    % Select depth frame
    depth = fs.get_depth_frame();
    width = depth.get_width();
    height = depth.get_height();
    
    % Decimation filter of magnitude 2
%     dec = realsense.decimation_filter(2);
%     depth = dec.process(depth);

    % Spatial Filtering
    % spatial_filter(smooth_alpha, smooth_delta, magnitude, hole_fill)
    spatial = realsense.spatial_filter(.5,20,2,0);
    depth_p = spatial.process(depth);

    % Temporal Filtering
    % temporal_filter(smooth_alpha, smooth_delta, persistence_control)
    temporal = realsense.temporal_filter(.13,20,3);
    depth_p = temporal.process(depth_p);
    
    %% Color Post-processing
    % Select color frame
    color = fs.get_color_frame();    
    
    %% Colorize and display depth frame
    % Colorize depth frame
    depth_color = colorizer.colorize(depth_p);

    % Get actual data and convert into a format imshow can use
    % (Color data arrives as [R, G, B, R, G, B, ...] vector)fs
    data = depth_color.get_data();
    img = permute(reshape(data',[3,depth_color.get_width(),depth_color.get_height()]),[3 2 1]);

    % Display image
    imshow(img);
    title(sprintf("Colorized depth frame from %s", name));

    %% Display RGB frame
    % Get actual data and convert into a format imshow can use
    % (Color data arrives as [R, G, B, R, G, B, ...] vector)fs
    data2 = color.get_data();
    im = permute(reshape(data2',[3,color.get_width(),color.get_height()]),[3 2 1]);

    % Display image
    figure;
    imshow(im);
    title(sprintf("Color RGB frame from %s", name));

    %% Depth frame without colorizing    
    % Convert depth values to meters
    data3 = depth_scaling * depth_p.get_data();

    %Arrange data in the right image format
    ig = permute(reshape(data3',[width,height]),[2 1]);
    
    % Scale depth values to [0 1] for display
    figure;
    imshow(mat2gray(ig));
    %%
    close all
figure;
    imshow(im)
    new_img = imbinarize(im);
    figure;
    imshowpair(im, new_img,'montage');
    bw=~(new_img(:,:,1)&new_img(:,:,2)&new_img(:,:,3));
    figure;
    imshow(bw)
    tmp = bwconncomp(bw);
    for i=1:length(tmp.PixelIdxList)
        if ((length(tmp.PixelIdxList{i}) < 100) || (length(tmp.PixelIdxList{i}) > 1000))
        bw(tmp.PixelIdxList{i}) = 0;
        end
    end
    figure;
    imshow(bw);
    tmp = bwconncomp(bw);
    imred = im(:,:,1);
    imgreen = im(:,:,2);
    imblue = im(:,:,3);
    red = zeros(1,tmp.NumObjects);
    green = zeros(1,tmp.NumObjects);
    blue = zeros(1,tmp.NumObjects);
    r = zeros(1,tmp.NumObjects);
    g = zeros(1,tmp.NumObjects);
    b = zeros(1,tmp.NumObjects);
    new_ig = ig*100;
    top = bw;
    top(:,:) = 0;
    rows = zeros(1,tmp.NumObjects);
    cols = zeros(1,tmp.NumObjects);
 
    for i = 1:tmp.NumObjects
        red(i) = mean(imred(tmp.PixelIdxList{i}));
        green(i) = mean(imgreen(tmp.PixelIdxList{i}));
        blue(i) = mean(imblue(tmp.PixelIdxList{i}));
        if red(i) > 70
            r(i) = 1;
        end
        if green(i) > 70
            g(i) = 1;
        end
        if blue(i) > 70
            b(i) = 1;
        end
        a = [];
        for j = 1:length(tmp.PixelIdxList{i})
            if new_ig(tmp.PixelIdxList{i}(j)) ~= 0
                a(end+1) = new_ig(tmp.PixelIdxList{i}(j));
            end
        end
        figure
        temp = histogram(a ,10);
        [m, idx] = max(temp.Values);
        sz = length(tmp.PixelIdxList{i});
        j = 1;
        while j <= sz
            if new_ig(tmp.PixelIdxList{i}(j)) <= temp.BinEdges(idx+2)
                top(tmp.PixelIdxList{i}(j)) = 1;
                j = j + 1;
            else
                tmp.PixelIdxList{i}(j) = [];
                sz = sz - 1;
            end
        end
        x = ceil(mean(mod(tmp.PixelIdxList{i},480)));
        y = ceil(mean(ceil(tmp.PixelIdxList{i}/480)));
        rows(i) = x;
        cols(i) = y;
        top(x,y) = 0;
    end
    figure
    imshow(top)
    red_obj = 0;
    green_obj = 0;
    blue_obj = 0;
    yellow_obj = 0;
    for i = 1:length(r)
        if (r(i) == 1) && (g(i) == 0) && (b(i) == 0)
            red_obj = red_obj + 1;
        end
        if (r(i) == 0) && (g(i) == 1) && (b(i) == 0)
            green_obj = green_obj + 1;
        end
        if (r(i) == 0) && (g(i) == 1) && (b(i) == 1)
            blue_obj = blue_obj + 1;
        end
        if (r(i) == 1) && (g(i) == 1) && (b(i) == 0)
            yellow_obj = yellow_obj + 1;
        end
    end
    rows
    cols

% Lab 8
% task 8.5
K = [1408.9, 0, 950.7;
      0, 1408.9, 533.1;
      0, 0, 1];

% transformation from camera to base frame (180 rotation about x axis and then translation of [35; 0; 805])

% Rx = [1, 0, 0;
%       0, cosd(180), -sind(180);
%       0, sind(180), cosd(180);]

% p = [35; 0; 805]; % measuring in real life

T = [1, 0, 0, -0;
    0, -1, 0, 0;
    0, 0, -1, 805;
    0, 0, 0, 1];

M = ( K * T (1:3 ,1:4) ) \[ u ; v ;1].* Z ;

Real = M(1:3,1)./10;
b = Arbotix('port', 'COM9', 'nservos', 5);
b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]); % idle state
pick = findOptimalSolution(Real(1), Real(2), Real(3), -pi/2);
pause(2);
b.setpos([0,pi/3,0,pi/3,1.2], [65, 65, 65, 65, 65]);
pause(2);
setPosition(pick);
pause(2);
place = findOptimalSolution(inp_x(1), inp_y(2), inp_z(3), -pi/2);
pause(2);
setPosition(place)
pause(2);
b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
end