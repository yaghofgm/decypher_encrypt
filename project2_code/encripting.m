% Load the current mappings with "," and "." added
reverse_mapping = containers.Map(...
    {' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', ...
     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ',', '.'}, ...
    {'00000', '00001', '00010', '00011', '00100', '00101', '00110', '00111', ...
     '01000', '01001', '01010', '01011', '01100', '01101', '01110', '01111', ...
     '10000', '10001', '10010', '10011', '10100', '10101', '10110', '10111', ...
     '11000', '11001', '11010', '11011', '11100'});  % Assign binary codes for "," and "."

% Get user input
message = input('Enter the message to encode (uppercase only): ', 's');

% Initialize an empty cell array to store binary vectors for CSV
encoded_vectors = cell(length(message), 1);

for i = 1:length(message)
    % Convert each character to its corresponding 5-bit binary vector
    char = message(i);
    if isKey(reverse_mapping, char)
        binary_vector_str = reverse_mapping(char);
        % Convert string to numeric vector
        binary_vector = arrayfun(@(x) str2double(x), binary_vector_str);

        % Apply G_big transformation
        encoded_vector = mod(G_big * binary_vector', 2);

        % Store the result for CSV
        encoded_vectors{i} = encoded_vector';
    else
        error(['Character ' char ' is not in the mapping.']);
    end
end

% Convert cell array to a table and save it to a CSV file
encoded_table = cell2table(encoded_vectors);
writetable(encoded_table, 'encoded_message.csv');

disp('Message successfully encoded and saved as encoded_message.csv');
