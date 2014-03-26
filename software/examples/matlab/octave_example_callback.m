function octave_example_callback
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "kqw"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    tir = java_new("com.tinkerforge.BrickletTemperatureIR", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for temperature callbacks to 1s (1000ms)
    % Note: The callbacks are only called every second if the 
    %       value has changed since the last call!
    tir.setObjectTemperatureCallbackPeriod(1000);
    tir.setAmbientTemperatureCallbackPeriod(1000);

    % Register object temperature callback to function cb_object
    tir.addObjectTemperatureListener("cb_object");
    % Register ambient temperature callback to function cb_ambient
    tir.addAmbientTemperatureListener("cb_ambient");

    input("\nPress any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback functions for object/ambient temperature callbacks 
% (parameters have unit °C/10)
function cb_object(temperature)
    fprintf("Object Temperature: %g°C\n", str2num(temperature.toString())/10);
end
function cb_ambient(temperature)
    fprintf("Ambient Temperature: %g°C\n", str2num(temperature.toString())/10);
end
