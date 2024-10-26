% message = readtable("messageFall2024.csv");
message = readtable("encoded_message.csv");
G_big = [
    1 0 0 0 0;
    0 1 0 0 0;
    0 0 1 0 0;
    0 0 0 1 0;
    0 0 0 0 1;
    1 1 0 0 1;
    1 1 1 0 0;
    1 0 1 1 0;
    1 0 0 1 1;
];
H_big=[
    1 1 0 0 1 1 0 0 0; 
    1 1 1 0 0 0 1 0 0; 
    1 0 1 1 0 0 0 1 0; 
    1 0 0 1 1 0 0 0 1;
];

% Create the mapping for 5-bit binary vectors
mapping = containers.Map(...
    {'00000', '00001', '00010', '00011', '00100', '00101', '00110', '00111', ...
     '01000', '01001', '01010', '01011', '01100', '01101', '01110', '01111', ...
     '10000', '10001', '10010', '10011', '10100', '10101', '10110', '10111', ...
     '11000', '11001', '11010', '11011', '11100'}, ...
    {' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', ...
     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ',', '.'});
% to access the map, turn vector into string for mapping
decoded_message = '';
for i=1:height(message)
    vector = message{i,:};
    S = H_big*vector';
    S=round(S,3);
    for k=1:length(S)
        [numerator,denominator] = rat(S(k));
        S(k)=moddiv(numerator,denominator,2);
    end
    if all(S==0)
        
    else
        for j=1:size(H_big,2)
            if all(S==H_big(:,j))
                vector(j)= ~vector(j);
                break
            end
        end
    end
    LCvec = G_big\vector';
    LCvec = round(LCvec,6);
    for k=1:length(LCvec)
        [numerator,denominator] = rat(LCvec(k),1e-6);
        LCvec(k)=moddiv(numerator,denominator,2);
    end
    key = num2str(LCvec,'%1d'); %turns the vector into string with no spaces
    decoded_char = mapping(key);
    decoded_message=[decoded_message decoded_char];
end
disp(decoded_message);


function div = moddiv(a,b,modulus)
    div = mod(a*modinv(b,modulus),modulus);
    return 
end
function inv = modinv(b,modulus)
    for inv=1:modulus
        if mod(b*inv,modulus)==1
            return %returns inv as soon as finds it
        end
    end
    disp(['Failed to find inverse for b = ', num2str(b), ' mod ', num2str(modulus)]);
    error('No inverses exist'); %should not happen for finite field.
end