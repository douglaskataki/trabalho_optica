function G = gain(ff)
    % carregar valores do arquivo com o ganho Raman
    load("Fibra_Standart_Raman_gain_spectrum.mat"); % THz x Ganho
    freq = Fibra_Standart_Raman_gain_spectrum(:,1);
    ganho = Fibra_Standart_Raman_gain_spectrum(:,2);
    
    % procura indice menor que ff
    ind = 1;
    while(freq(ind)<ff)
        ind = ind+1;
    end
    % interpolação linear
    G = ganho(ind)+(ganho(ind+1)-ganho(ind))/(freq(ind+1)-freq(ind));
end