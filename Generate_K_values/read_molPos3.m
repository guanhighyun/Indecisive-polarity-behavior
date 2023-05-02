% Adapted from "read_molPos3.m" from Ramirez SA, Pablo M, Burk S,
% Lew DJ, Elston TC (2021). PLoS Comput Biol 17(7): e1008525.

% Inputs: 
% filename: name of the coordinates file.
% nframes: number of frames of the simulation.

% Outputs:
% t: time.
% positions: molecular coordinates.

function [t,positions] = read_molPos3(filename,nframes)
positions.Cdc42T = cell(nframes,1);
positions.BemGEF42 = cell(nframes,1);
positions.Cdc42Dm = cell(nframes,1);
positions.Cdc42Dc = cell(nframes,1);
positions.BemGEFm = cell(nframes,1);
positions.BemGEFc = cell(nframes,1);
positions.Ram = cell(nframes,1);
positions.Rac = cell(nframes,1);
positions.RaGEF = cell(nframes,1);
positions.FarGEF = cell(nframes,1);

t=nan(nframes,1);
fid=fopen(filename);

frameid = 1;
while ~feof(fid)
    % each line contains:
    % t x1 y1 x2 y2 .. xn yn
    % for all n species of the particular time.
    % all species are listed in the order
    % Cdc42T BemGEF42 Cdc42Dm Cdc42Dc BemGEFm BemGEFc Far1GEFm Far1GEFc
    % complex_Cdc42Dm_BemGEFm complex_Cdc42Dm_BemGEF42 Ga Gi Ra Ri RaGi_transient RiGa_transient
    % Far1GEFGa complex_Cdc42Dm_Far1GEFGa

   if frameid > nframes
        break;
    end   
  
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.Cdc42T{frameid} = [x,y];

    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.BemGEF42{frameid} = [x,y];
    
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.Cdc42Dm{frameid} = [x,y];
    
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.Cdc42Dc{frameid} = [x,y];

    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.BemGEFm{frameid} = [x,y];
    
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.BemGEFc{frameid} = [x,y];
    
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.Ram{frameid} = [x,y];
    
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.Rac{frameid} = [x,y];
    
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.RaGEF{frameid} = [x,y];
    
    currline = fgetl(fid);
    [currt,x,y]=entry_to_xyz(currline);
    if ~isnan(currt) && isnan(t(frameid))
        t(frameid)=currt;
    end
    positions.FarGEF{frameid} = [x,y];

    frameid=frameid+1;
end
fclose(fid);

end

function [t,x,y]=entry_to_xyz(line)
    coords=sscanf(line,'%g');
    if numel(coords)>1
        t = coords(1);
        x = coords(2:2:end);% skip the time value, which is the first entry
        y = coords(3:2:end);
    else
        t = nan; x=[]; y=[];
    end
end
