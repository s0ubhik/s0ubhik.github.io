main_lo();
clc

function main_lo()
    credentails('null', 'null', 0);

    show_banner();
    while true
        stat = login();
        if stat == 1
            show_banner();
            disp('Invalid Login');
        elseif stat == 0
            return;
        else
            break;
        end
    end

    while true
        stat = main_menu();
        if stat == 1
            return;
        end
    end

end

function [status, files] = fetch_files()
    cred = credentails('', '', 0);
    files = 0;
    status = 0;
    try
        files = strsplit(strtrim(webwrite(cred{4}, 'username', cred{1},'password', cred{2})), '\n');
    catch
        show_error('No Internet');
        status = 1;
        return;
    end
end

function wait_enter()
    input('Press ENTER to return');
end

function stat = main_menu()
    cred = credentails('', '', 0);
    stat = 0;
    show_banner();
    fprintf('Welcome %s\n', cred{1});
    auth = cell2mat(cred(3));
    if auth == 1
        display_options({'Upload File', 'Download File', 'Share File', 'Delete File', 'Exit'})
    elseif auth == 2
        display_options({'Upload File', 'Download File', 'Share File', 'Delete Files', 'User Control','Exit'})
    end
    try
        c = str2num(input("Enter Choice: ", 's'));
        if c == 0 || c == 1
            return
        end
    catch exception
        return;
    end
    c = (auth*10) + c;
    if c == 11 || c == 21
        show_banner();
        [files,path] = uigetfile('*.m', 'Select One or More Files', 'MultiSelect', 'on');

        if iscell(files)
            for file = files
                upload_file(path, file);
            end
        elseif ischar(files)
            upload_file(path, files);
        else
            return
        end
        wait_enter();
        return;
    elseif c == 12 || c == 22
        show_banner();
        [stat, files] = fetch_files();
        if stat == 1
            return;
        end
        down_files = listdlg('ListString', files, 'SelectionMode', 'multi', 'Name', 'Download', 'PromptString', 'Choose files:', 'OKString', 'Download');
        for i = down_files
            file = char(files(i));
            download_file(file);
        end
        wait_enter();
    
    elseif c == 13 || c == 23
        show_banner();
        disp("Share File")
        share_user = input('Reciptent Username: ', 's');
        if strcmp(share_user, '')
            return;
        end
        [stat, files] = fetch_files();
        if stat == 1
            return;
        end
        share_files = listdlg('ListString', files, 'SelectionMode', 'multi', 'Name', 'Share', 'PromptString', 'Choose files:', 'OKString', 'Share');
        for i = share_files
            file = char(files(i));
            share_file(file, share_user);
        end
        wait_enter();

    elseif c == 14 || c == 24
        show_banner();
        [stat, files] = fetch_files();
        if stat == 1
            return;
        end
        delete_files = listdlg('ListString', files, 'SelectionMode', 'multi', 'Name', 'Delete', 'PromptString', 'Choose files:', 'OKString', 'Delete');
        for i = delete_files
            file = char(files(i));
            delete_file(file);
        end
        wait_enter();

    elseif c == 15 || c == 26
        stat = 1;
        return;
    elseif c == 25
        show_banner();
        disp("User Control");
        display_options({'Create User', 'Reset Password', 'Delete User', 'Back'})
        c = input('Enter Choice:', 's');
    end
end

function show_banner()
    clc
    disp(['[' 8 'Ornage Lichi]' 8 ''])
    disp('');
end

function display_options(opts)
    c = 1;
    for opt = opts
        fprintf(' [%d] %s\n', c, opts{c});
        c = c + 1;
    end
end

function delete_file(file)
    cred = credentails('', '', 0);

    fprintf("Deleting %s ... ", file);
    try
        stat = webwrite(cred{4}, 'username', cred{1},'password', cred{2}, 'delete', file);
        if strcmp(stat, 'ERROR') == 1
            disp('Failed');
            return;
        else
            disp('Done');
        end

    catch exception
        disp('Error');
    end
end

function share_file(file, share_user)
    cred = credentails('', '', 0);

    fprintf("Sharing %s ... ", file);
    try
        stat = webwrite(cred{4}, 'username', cred{1},'password', cred{2}, 'share', share_user, 'file_name', file);
        if strcmp(stat, 'ERROR') == 1
            disp('Failed');
            return;
        else
            disp('Done');
        end

    catch exception
        disp('Error');
    end
end

function show_error(msg)
    show_banner()
    fprintf(2, 'ERROR: %s\n', msg);
    wait_enter();
end

function download_file(file)
    cred = credentails('', '', 0);

    fprintf("Downloading %s ... ", file);
    try
        data = webwrite(cred{4}, 'username', cred{1},'password', cred{2}, 'download', file);
        if size(data) == [1 0]
            disp('Failed');
            return;
        else
            disp('Done');
        end

        if contains(file, '@')
            c = strsplit(file, '@');
            file = char(strtrim(c(1)));
        end

        while isfile(file)
            fprintf('%s Already Exists ', file);
            c = input('Overwrite (Y/n)', 's');
            if strcmp(c, 'n') == 1
                file = input('Enter new filename: ', 's');
            else
                break
            end
        end
        fileID = fopen(file, 'w');
        for c = data
            fprintf(fileID, '%s', c);
        end
        fclose(fileID);
    catch exception
        disp('Error');
    end

end

function upload_file(path, file)
    cred = credentails('', '', 0);

    fprintf("Uploading %s ... ", char(file));
    data = char(fileread(strcat(path, file)));
    try
        stat = webwrite(cred{4}, 'username', cred{1},'password', cred{2}, 'file_name', char(file), 'file_data', data);
        if strcmp(stat, 'Uploaded')
            disp('Done');
        else
            disp('Failed');
            return;
        end
    catch exception
        disp('Error');
    end

end

function cred_ = credentails(username_, password_, auth_)
    persistent cred;
    cred_ = {'', '', 0, 'http://192.168.31.123:8080/up/'};
    if strcmp(username_,'') == 1
        cred_ = cred;
        return;
    else
        cred = {username_, password_, auth_, 'http://192.168.31.123:8080/up/'};
    end
end


function status = login()
    cred = credentails('', '', 0);
    username = input('Username: ', 's');
    password = input('Password: ', 's');

    disp("Logging in...")
    try
        auth = str2num(webwrite(cred{4}, 'username', username, 'password', password, 'login', 'true'));
    catch
        status = 0;
        show_error('No Internet');
        return;
    end
    if auth == 0
        status = 1;
        return;
    end
    credentails(username, password, auth);
    status = 2;
end
